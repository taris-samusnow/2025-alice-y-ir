# 使用方法
## 前提条件
`docker container`及び`docker-compose`の環境があること

## 開発環境構築
.env ファイルに`BUILD_TAGET=dev-user-node`と記載

```bash
$ docker-compose.exe build
$ docker-compose.exe up -d
$ docker exec -it dev-user-node-instance /bin/bash

# アタッチ先のshell
$ yarn install
$ yarn dev --host 0.0.0.0 --port 3000 
```
http://localhost:3000/2025-alice-y-ir/ にブラウザでアクセス
  
ホストのフォルダを使いたい場合は適宜 `docker-compose.yml` の `volumes:`の記述を変更
  
## 実行環境構築
container 運用環境の場合はこの環境で近い状況を再現可能。
.env ファイルに`BUILD_TAGET=serv-user-node`と記載

```bash
$ docker-compose.exe build
$ docker-compose.exe up -d
```
http://localhost:3000/2025-alice-y-ir/ にブラウザでアクセス