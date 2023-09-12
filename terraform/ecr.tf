resource "aws_ecr_repository" "ecr" {
  name = "flaskapp"
}

#We create a ECR repo named flaskapp so we can push an image from the pipeline to the repo.