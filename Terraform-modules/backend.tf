terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-hdfc"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "home"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

