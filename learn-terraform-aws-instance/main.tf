# Terraformブロック
terraform {
  required_providers {
    aws = {
      # AWSプロバイダーのソースとバージョン
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  # このコードが実行されるために必要なTerraformの最低バージョン
  required_version = ">= 1.2.0"
}

# プロバイダーブロック
# 今回は AWSプロバイダーを使うためにそれに関する設定を宣言する
provider "aws" {
  # 使用するAWSリージョン
  region = "us-west-2"
}

# リソースブロック
# 今回は EC2 インスタンスを建てるのでそれに関する設定を宣言する
resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}
