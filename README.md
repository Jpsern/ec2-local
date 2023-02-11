# EC2-local

<img src="https://user-images.githubusercontent.com/7730843/216323604-7770ac01-f385-4fdb-bfd1-0d7c62a29b92.png" alt="sample" width="500px">

VM感覚で使えるローカル用のEC2を作成することができます。

## Requirements
- Docker
- Make

## Installation
```
make build
```

## Usage
```
USAGE
  make [TARGET]([ARGS])

TARGETS
  help                 ヘルプの表示
  down                 コンテナ停止
  clean                コンテナ、イメージ、ボリューム掃除
  build                コンテナ初期化
  rebuild              コンテナ作り直し
  up                   コンテナ起動
  restart              コンテナ再起動
  aml2                 amazon-linux-2 コンテナにログイン
```

## Advanced
- [SSH接続設定](/docs/setup-ssh.md)
