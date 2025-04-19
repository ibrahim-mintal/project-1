terraform {
  backend "s3" {
    bucket       = "mintal-terraform"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
