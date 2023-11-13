# URL
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

---

# Terraform のインストール方法(macOS)
インストール方法は以下の2種類がある

## パッケージマネージャ(Homebrew)を利用する場合
- brew コマンドが使える環境下で以下を実行する

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## パッケージマネージャを利用しない場合
### コンパイル済みのバイナリをダウンロードする場合
- 以下のURLからビルド済みのバイナリをダウンロードする
  - https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_darwin_arm64.zip
- 適切なディレクトリ(例: /usr/local/bin/)にパスを通してからバイナリを配置する

### ソースコードから手動でコンパイルする場合
- go コマンドが使える環境下で以下を実行する

```sh
git clone https://github.com/hashicorp/terraform.git
cd terraform
go install
```

- 適切なディレクトリ(例: /usr/local/bin/)にパスを通してからバイナリを配置する

## TIPS: タブ補完

- `terraform -install-autocomplete` を実行することで、Terraformコマンドのタブ補完を有効にすることができる
  - bash と zsh 限定


# コマンド
## terraform init
- プロジェクトを初期化し、プロバイダと呼ばれるプラグインをダウンロードする

## terraform apply
- main.tf に記述した内容でプロビジョニングする
  - プロビジョニングの際に、Terraform が確認を求めてくるので、yesと入力してENTERを押す必要がある

## terraform destroy
- main.tf に記述した内容でプロビジョニングしたリソースを破棄する
