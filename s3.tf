resource "aws_s3_bucket" "ada_s3_bucket" {
  bucket = "igor-ribeiro-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = {
    Name        = "ada_s3_bucket"
    Environment = "Dev"
  }
}
