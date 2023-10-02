# EC2-local
[![Lint Dockerfile](https://github.com/Jpsern/ec2-local/actions/workflows/hadolint.yml/badge.svg)](https://github.com/Jpsern/ec2-local/actions/workflows/hadolint.yml)

![](/docs/images/ssh.png)
![](/docs/images/ssh-al2023.png)

VM感覚で使えるローカル用のEC2を作成することができます。

## Requirements
- Docker Desktop(`>=4.19.0`)
- Make

## Installation
```
make build && make up
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
  aml2023              amazon-linux-2023 コンテナにログイン
```

## Advanced
- [SSH接続設定](/docs/setup-ssh.md)
