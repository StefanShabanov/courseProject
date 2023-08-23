pipeline {
    agent any
    environment{
        image_name="211209708326.dkr.ecr.eu-central-1.amazonaws.com/flaskapp" #Paste the link for your repo in AWS ECR.
        region="eu-central-1"
    }
    stages {
        stage("Build") {
            steps {
                sh '''
                aws ecr get-login-password --region $region | docker login --username AWS --password-stdin 211209708326.dkr.ecr.eu-central-1.amazonaws.com #Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI#
                docker build -t $image_name:latest .
                '''
            }
        }
        stage("Push") {
            steps {
                sh '''
                docker push $image_name:latest
                '''
            }
        }
        stage("Deploy") {
            steps {
                sh '''
                helm upgrade flask helm/ --install --wait --atomic
                '''
            }
        }
    }
}