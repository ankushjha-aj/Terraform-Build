resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# resource "aws_s3_bucket_acl" "this" {
#   bucket = aws_s3_bucket.this.bucket
#   acl    = 
# }
