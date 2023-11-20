# Terraform （AWS）

docs ディレクトリの配下にチュートリアルのメモを配置しています。

## OverView

TODO

## Environment

```shell
> terraform -version
Terraform v1.6.3
on darwin_arm64
+ provider registry.terraform.io/hashicorp/aws v4.67.0
```

## Usage

1. `AdministratorAccess` のIAMポリシーをアタッチされたIAMユーザを作成し、そのユーザのアクセスキーIDとシークレットアクセスキーを取得する

2. us-west-2 リージョンに 適当な名前でS3 バケットを作成する(作成後に `main.tf` の15行目の値を作成したS3バケット名で書き換える)

3. 下記コマンドを実行して、セットアップを行う

```shell
export AWS_ACCESS_KEY_ID=<アクセスキーID>
export AWS_SECRET_ACCESS_KEY=<シークレットアクセスキー>
terraform init
```

4. 下記コマンドを実行して、プロビジョニングする
```shell
terraform apply
```

5. 下記コマンドを実行して、プロビジョニングしたリソースを破棄する

```shell
terraform destroy
```

> 2で作成した S3 バケットは Terraform で管理していないため `terraform destroy` では破棄されない。手動で削除する必要がある
