# Python Flask App Deployment with DevOps Tools

Welcome to a guide on deploying a Python Flask web application using a wide array of DevOps tools and practices. This project aims to showcase diverse technologies like Linux, AWS, Terraform, Helm, Python, Docker, Jenkins, and Kubernetes.
## Project Overview

This  project shows a series of stages for deploying a Python Flask web application with DevOps tools. Each stage contributes to demonstrating my desire to become a DevOps engineer.

### Stage 1: GitHub Account and SSH Keys

Begin with setting up your GitHub account and securing communication:

1. GitHub Account: Create an account on GitHub.
2. SSH Keys: Generate SSH keys and link the public key to your GitHub account for secure interaction between your local machine and GitHub.

### Stage 2: Infrastructure Setup with Terraform

Take control of your AWS infrastructure using Terraform:

1. Infrastructure Configuration: Inside the infra folder, the Terraform configuration files are the foundation.
2. Infrastructure Creation: These files define essential components like an EC2 instance, security group, and an Amazon Elastic Container Registry (ECR).
3. Tool Installation: The EC2 instance will be set up with the installation of Git, Jenkins, Docker, Kind, Kubectl, and Helm.

### Stage 3: Application Deployment Configuration

Configure application deployment using Helm and Docker:

1. Helm Chart Configuration: In the helm folder, the Helm chart files define your app for deployment.
2. Containerization: Craft a Dockerfile in your project root, detailing how to containerize the Flask application.

### Stage 4: Automating Deployment with Jenkins

Automate deployment using Jenkins:

1. Pipeline Script: The Jenkinsfile orchestrates the deployment pipeline stages.
2. Building: Build the Docker image, tagging it with the ECR repository URL.
3. Pushing: Push the Docker image to the ECR repository.
4. Deploying: Helm upgrades the deployment with the Helm chart from the helm folder.

### Stage 5: Accessing the Deployed Application

Explore the final deployment and access your app:

1. Deployment Success: After a successful Jenkins pipeline run, your Flask app is deployed on Kubernetes.
2. Endpoint Access: Now you should be able to access your application through the endpoint: http://<EC2_IP>:30000.

## Code Breakdown

### Terraform Configuration Files

1. ec2.tf: Define an AWS EC2 instance, complete with user data for tool installation.
2. ecr.tf: Establish an Amazon Elastic Container Registry (ECR) repository for your Flask app.
3. role.tf: Create an AWS IAM role and instance profile for secure EC2 instance access.
4. sg.tf: Configure an AWS security group, allowing Jenkins, SSH, and Flask app access.

### Helm Configuration Files

1. chart.yaml: Meta-information for the Helm chart, specifying name, version, and app version.
2. values.yaml: Configure Flask app settings, including deployment parameters.

### Dockerfile

The Dockerfile guides Docker image creation, with steps such as:

- Base image selection: python:3.10.10-bullseye.
- Directory creation and app file copying.
- Setting the working directory.
- Dependency installation, including Flask.
- Command to run the Flask app.

### Jenkinsfile

The Jenkinsfile streamlines deployment with:

1. Build: Construct the Docker image, tagging it with the ECR repository's URL.
2. Push: Send the Docker image to the ECR repository.
3. Deploy: Helm updates the deployment with the Helm chart from the helm folder.