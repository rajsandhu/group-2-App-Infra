terraform {
  backend "s3" {
    bucket         = "group-2-elk-4073724601872"
    key            = "infrastruture/terraform.tfstates"    ###ask about the folder
    dynamodb_table = "terraform-lock"
  }
}