terraform {
  # 使用するプロバイダについての設定を定義
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {} # Docker プロバイダを初期化する

resource "docker_image" "nginx" {
  name         = "nginx" # Docker Hub から nginx イメージを取得する
  keep_locally = false   # terraform destroy が実行された際にイメージが削除する
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id # 上記で定義した nginx イメージを使用してコンテナを作成する
  name  = "tutorial"                  # コンテナに "tutorial" という名前を割り当てる

  # コンテナの内部ポート80と ホストのポート8000をマッピングする
  ports {
    internal = 80
    external = 8000
  }
}
