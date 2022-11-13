terraform {
  backend "s3" {
    bucket = "#{Terraform.StateBucket}"
    key    = "#{Terraform.NewSpace.StateBucketKey}"
  }
}