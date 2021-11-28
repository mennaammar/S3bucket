data "terraform_remote_state" "vpc" {
  backend = "local"
  workspace ="default"
  config = {
    path = "../log_s3/terraform.tfstate"
  }
}

# resource "aws_s3_bucket_policy" "deny_insecure_transport" {
# bucket = data.terraform_remote_state.vpc.outputs.s3_bucket_id
# policy = data.terraform_remote_state.vpc.outputs.policy

# }