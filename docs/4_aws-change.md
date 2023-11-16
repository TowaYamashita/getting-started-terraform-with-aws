# URL
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-change

---

# インフラストラクチャの変更を反映
- 設定を変更した後に再度terraform applyを実行することで、Terraformがこの変更を既存のリソースにどのように適用するかを確認した上で反映できる

## TIPS: 変更が反映される際にリソースが一度削除されるかどうかの見分け方
- terraform apply を実行した際に表示される実行プランの接頭辞を確認することで見分けることが可能。
  - 接頭辞が **「-/+」** の場合は、破棄して再作成することを意味する
  - 接頭辞が **「〜」** の場合は、インプレースで更新することを意味する

- 実行プラン内にどのパラメータの変更によってインスタンスを破棄して再生成するかを示すマーク(**# force replacement**)が表示される。
  - この情報を使って、必要に応じて破壊的な更新を避けるように変更を調整することができる


```shell
❯ terraform apply
aws_instance.app_server: Refreshing state... [id=<EC2インスタンスのID>]

Terraform used the selected providers to generate the following
execution plan. Resource actions are indicated with the following
symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.app_server must be replaced
-/+ resource "aws_instance" "app_server" {
      ~ ami                                  = "ami-830c94e3" -> "ami-08d70e59c07c61a3a" # forces replacement
      # 省略
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      # 省略
      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }
      # 省略
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```

## TIPS: 変更が反映された後のインスタンスに関連する値を確認する方法
- terraform show を使うことで、変更が反映された後のインスタンスに関連する値を確認できる
