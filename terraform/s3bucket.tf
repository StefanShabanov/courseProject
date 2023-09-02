# Create an AWS S3 bucket using the specified variable for the bucket name.
resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucketname
}

# Upload a YAML file ("kind.yaml") to the S3 bucket created above.
resource "aws_s3_object" "kind" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "kind.yaml"
  source       = "kind.yaml"
}
