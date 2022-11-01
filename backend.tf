terraform {
  backend "s3" {
    bucket         = "group-2-elk-4073724601872"
    key            = "group-2-elk/app-infra/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}
