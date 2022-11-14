terraform {
  backend "s3" {
    bucket = "#{Terraform.StateBucket}"
    # This value must be unique for each space created. A value like:
    # new-space-#{Octopus.Space.Name | ToLower | Replace " " "-"}
    # works well.
    key    = "#{Terraform.NewSpace.StateBucketKey}"
  }
}