# URL
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

---

# Terraform AWS プロバイダの認証に IAM 認証情報を使用する方法
- 環境変数 AWS_ACCESS_KEY_ID と AWS_SECRET_ACCESS_KEY を設定することで、AWSプロバイダでIAM認証情報が使えるようになる

```sh
export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
```

- `$HOME/.aws/`配下にあるconfigure や credential ファイルを使う場合は、Provider ブロック内でファイルパスを与えてやれば使える

# main.tf 内の各ブロックの説明
## Terrform ブロック
Terraform ブロックには、Terraform がインフラストラクチャのプロビジョニングに使用する必須プロバイダを含む Terraform の設定が含まれる

```tf
terraform {
  required_providers {
    aws = {
      # source 属性には、<ホスト名>/<名前空間>/<プロバイダタイプ> のように書く
      source = "registry.terraform.io/hashicorp/aws"
      # TIPS: Terraform はデフォルトで Terraform Registry からプロバイダをインストールするため下のような省略が可能
      # source  = "hashicorp/aws"

      # プロバイダのバージョン(省略可能、省略した場合は最新バージョンを使用する)
      # TIPS: プロバイダのバージョンによって動作しないことを避けるためにバージョンを制約しておくことを推奨
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
```

## Provider ブロック
- Provider ブロックは指定されたプロバイダ（ここではaws）を設定する
- Terraform の設定で複数のプロバイダブロックを使って、異なるプロバイダのリソースを管理することができ、異なるプロバイダを一緒に使うこともできる
  - 例、EC2 インスタンスの IP アドレスを DataDog の監視リソースに渡す

```tf
# provider <Terraform ブロック内で読み込んだプロバイダ名>
provider "aws" {
  region = "us-west-2"
}
```

## Resource ブロック
- Resource ブロックは、インフラストラクチャのコンポーネントを定義する
  - 例: 物理的または仮想的なコンポーネント( EC2 インスタンス)や論理的なリソース( Heroku アプリケーション)

- Resource ブロックには、リソースの設定に使用する引数が含まれる。
- 指定できる引数は、生成するリソースによって異なる
  - 例 EC2 インスタンスの場合は以下の引数などが使える(詳しくはプロバイダのリファレンスを参照)
    - マシンサイズ
    - ディスクイメージ名
    - VPC ID
    - インスタンスに名前を付けるためのタグ

```tf
# resource <リソースタイプ> <リソース名>
# リソースタイプのプレフィクスは プロバイダ名と一致させる必要がある
# この Resource ブロックで作成される EC2 インスタンスの ID は aws_instance.app_server になる
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

# コマンド
## terraform fmt
- terraform fmt を使うことで、カレントディレクトリの設定を自動的に更新し、 `*.tf` ファイルのフォーマットを行う
- 変更が発生したファイル名があればそれを出力する
- すでに正しくフォーマットされているファイル名を返さない

## terraform validate
- terraform validate を使うことで、設定が構文的に有効であることを確認できる
- 成功したら、`Success! The configuration is valid.`のようなメッセージを出力する

## terraform show
- 設定を適用すると、Terraformは `terraform.tfstate` というファイルに管理しているリソースのIDとプロパティをこのファイルに保存して、今後リソースを更新したり破棄したりできるようにしている
- `terraform.tfstate` は Terraform が管理するリソースを追跡する唯一の方法であり、機密情報を含むことが多いため、状態ファイルを安全に保存し、インフラストラクチャを管理する必要がある信頼できるチームメンバーのみにアクセスを制限する必要がある
  - Terraform Cloud や Terraform Enterprise を使ってリモートで状態を保存することを推奨
- terraform show を使うことで、現在の状態を確認できる

## terraform state list
- terraform state list を使うことで、プロジェクトの状態にあるリソースの一覧を表示できる
