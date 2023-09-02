resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucketname
}

resource "aws_s3_object" "kind" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "kind.yaml"
  source       = "kind.yaml"
}