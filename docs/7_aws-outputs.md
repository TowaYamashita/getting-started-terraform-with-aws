# URL
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-outputs
https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs

---

# 作成したリソースに関する値を出力する方法
- 出力したい値について定義した `outputs.tf` ファイルを作成して、 `terraform apply` 実行後に `terraform output` を実行することで、作成したリソースに関する値を出力できる

```tf
# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  tags = {
    Name = "SandboxInstance"
  }
}

# outputs.tf
# output <出力した値を入れる変数名> のように定義する
output "instance_id" {
  description = "ID of the EC2 instance"
  # value = <main.tfで定義したリソースタイプ>.<リソース名>.<リソースのプロパティ名> のように定義
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

```

```sh
> terraform apply
// 省略

> terraform output
instance_id = "i-XXX"
instance_public_ip = "192.168.0.3"
```

## TIPS: outputs.tf
### 出力を展開する
-
```tf
# outputs.tf
output "instance_id_with_comment" {
  value = "The Instance ID is ${aws_instance.app_server.id}"
}
```

```sh
> terraform output
instance_id_with_comment = "The Instance ID is i-XXX"
```

### 特定の出力をマスクする
```tf
# outputs.tf
output "instance_id_sensitive" {
  value = aws_instance.app_server.id
  # sensitive が true の場合は、表示する際にマスクする
  sensitive = true
}
```

```sh
> terraform output
instance_id_sensitive = <sensitive>
```

## TIPS: terraform output のオプション
### 特定の出力だけ表示する
- `terraform output <出力の変数名>` を実行することで、特定の出力だけ表示できる

```sh
❯ terraform output instance_id
"i-XXX"

# -raw オプションをつけることで、ダブルクォーテーションで囲まれていない値を表示する
❯ terraform output -raw instance_id
i-XXX
```

### JSON 形式で取得する
- `terraform output -json` を実行することで、以下のようにJSON形式で取得できる
```sh
❯ terraform output -json
{
  "instance_id": {
    "sensitive": false,
    "type": "string",
    "value": "i-XXX"
  },
  "instance_public_ip": {
    "sensitive": false,
    "type": "string",
    "value": "192.168.0.3"
  }
}
```
