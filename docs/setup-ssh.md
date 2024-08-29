# SSH 接続用設定

Amazon Linux 2 と Amazon Linux 2023 用で異なる部分は記述を分けています。それ以外は共通です。

## 鍵ペアの作成
`~/.ssh/ec2_local_rsa` は任意の名前でOK。ここではこのパス、ファイル名を前提に話を進めます。
```
ssh-keygen -t rsa -f ~/.ssh/ec2_local_rsa
```

## コンテナに公開鍵をコピー

テキストをコピーして、コンテナ内で自分で authorized_keys を作ってもいいですが面倒なのでコピーで済ませます。

### amazon-linux-2
```sh
docker compose cp ~/.ssh/ec2_local_rsa.pub amazon-linux-2:/home/ec2-user/.ssh/authorized_keys
```

### amazon-linux-2023
```sh
docker compose cp ~/.ssh/ec2_local_rsa.pub amazon-linux-2023:/home/ec2-user/.ssh/authorized_keys
```

## 公開鍵の権限を変更

コンテナにログイン。

### Amazon Linux 2
```sh
make aml2
```

### Amazon Linux 2023
```sh
make aml2023
```

コンテナ内でパーミッションと所有者を変更。
```sh
sudo chmod 600 ~/.ssh/authorized_keys && sudo chown ec2-user:ec2-user ~/.ssh/authorized_keys
```

## 接続

下記のコマンドを実行して接続できればOKです。

### Amazon Linux 2
```sh
ssh -i ~/.ssh/ec2_local_rsa -p 20022 ec2-user@localhost
```
```

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
```

### Amazon Linux 2023
```sh
ssh -i ~/.ssh/ec2_local_rsa -p 20122 ec2-user@localhost
```
```
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
Last login: Mon Oct  2 15:15:09 2023 from 172.19.0.1
```

## config

面倒な人は `~/.ssh/config` に書いておけば楽です。

```ssh-config
# Amazon Linux 2
Host amazon-linux
HostName localhost
User ec2-user
Port 20022
IdentityFile ~/.ssh/ec2_local_rsa

# Amazon Linux 2023
Host amazon-linux-2023
HostName localhost
User ec2-user
Port 20122
IdentityFile ~/.ssh/ec2_local_rsa
```
