# URL
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-destroy

---

# インフラストラクチャを破棄する

- terraform destroy を使うことで、**Terraform プロジェクトによって管理されているリソース** を終了する
  - Terraform プロジェクトによって管理されていない他の場所で実行されているリソースは破壊されないため注意

- terraform destroy 実行時は以下のような実行計画が表示されるため、意図しないリソースが消されないかを確認する
  - 実行計画内のリソースのプレフィクスとして「-」がついていると、terraform destroy によって消されることを意味する

```shell
> terraform destroy
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

   aws_instance.app_server will be destroyed
  - resource "aws_instance" "app_server" {
      - ami                          = "ami-08d70e59c07c61a3a" -> null
      - arn                          = "arn:aws:ec2:us-west-2:561656980159:instance/i-0fd4a35969bd21710" -> null
#...

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
```
