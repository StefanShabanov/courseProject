# Retrieve the latest AWS Linux 2 AMI ID.
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Create a networking resource to specify the VPC Subnet for the EC2 instance.
resource "aws_network_interface" "interface" {
  subnet_id       = "subnet-03e6289b7b37451da" # Replace with your subnet ID from AWS VPC.
  security_groups = [aws_security_group.allow_tls.id] # Attach security group to allow Jenkins traffic.
}

# Create an AWS EC2 Instance, install software, and configure it.
resource "aws_instance" "ec2" {
  depends_on           = [aws_network_interface.interface]
  ami                  = data.aws_ami.amazon-linux-2.id
  instance_type        = "t2.medium"
  user_data            = <<EOF
    #!/bin/bash

    # Update the system and install Jenkins, Git, and Java.
    yum update -y
    wget -O /etc/yum.repos.d/jenkins.repo \
        https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum upgrade -y
    amazon-linux-extras install java-openjdk11 -y
    yum install jenkins git -y

    # Install DOCKER and start the Docker service.
    yum install -y docker
    systemctl start docker
    usermod -aG docker jenkins
    systemctl start jenkins

    # Install KUBECTL and HELM.
    curl -LO https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2

    # Install KIND (Kubernetes in Docker).
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    aws s3 cp s3://${var.bucketname}/kind.yaml /var/lib/jenkins/
    kind create cluster --config=/var/lib/jenkins/kind.yaml
    mkdir -p /var/lib/jenkins/.kube/   ##Creating kube directory so we can give credentials for k8s and give access to the cluster.##
    kind get kubeconfig --name=kind > /var/lib/jenkins/.kube/config 
    chown -R jenkins: /var/lib/jenkins/.kube/
EOF
  iam_instance_profile = aws_iam_instance_profile.profile.name
  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }
  tags = {
    Name = "Jenkins"
  }
}
#Attaching our role to the EC2 VM and granting Jenkins access to AWS.