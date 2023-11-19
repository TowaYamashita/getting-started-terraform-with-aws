# URL
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-variables

---

# 変数を使う

- `variables.tf` 内に変数を定義するブロックを定義することで、`main.tf`から定義した変数を参照できる
  - Terraform は `*.tf` をすべて読み込むため、`variables.tf` の名前でなくてもよい

```tf
# variable <変数名> のように定義する
variable "instance_name" {
  # 変数の説明
  description = "Value of the Name tag for the EC2 instance"
  # 変数の型(例: string, number, boolなど)
  type        = string
  # 変数のデフォルト値
  default     = "ExampleAppServerInstance"
}

variable "instance_type" {
  description = "Value of the Instance Type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}
```

```tf
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = var.instance_type
  tags = {
    # var.<validables.tfで定義した変数名> のようにすることで参照できる
    Name = var.instance_name
  }
}
```

# デフォルト設定を上書きする
- `terraform apply -var "<変数名>=<値>"` を実行することで、上書きができる
  - 例: instance_nameを「YetAnotherName」、 instance_typeを「t3.micro」に上書きしたい場合は、以下のコマンドを実行する
    - `terraform apply -var "instance_name=YetAnotherName" -var "instance_type=t3.micro"`
- 変数名に上書きしたい値を定義した `*.tfvars` ファイルを作成して、 `terraform apply -var-file *.tfvars` を実行することでも、上書きできる
  - 例えば、同じ Terraform プロジェクトで開発環境と本番環境のインフラストラクチャを管理する場合に、 コマンドラインでいちいち指定するよりもどの *.tfvars を使うかを選択するだけでよいので便利
