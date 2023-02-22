# EC2-local

![](/docs/images/ssh.png)

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
