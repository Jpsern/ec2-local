# SSH 接続用設定
## 鍵ペアの作成
`~/.ssh/ec2_local_rsa` は任意の名前でOK。ここではこのパス、ファイル名を前提に話を進めます。
```
ssh-keygen -t rsa -f ~/.ssh/ec2_local_rsa
```

## コンテナに公開鍵をコピー

テキストをコピーして、コンテナ内で自分で authorized_keys を作ってもいいですが面倒なのでコピーで済ませます。

```
docker-compose cp ~/.ssh/ec2_local_rsa.pub amazon-linux-2:/home/ec2-user/.ssh/authorized_keys
```

## 公開鍵の権限を変更

コンテナにログイン。
```
make aml2
```
コンテナ内でパーミッションと所有者を変更。
```
$ sudo chmod 600 ~/.ssh/authorized_keys && sudo chown ec2-user:ec2-user ~/.ssh/authorized_keys
```

## 接続

下記のコマンドを実行して接続できればOKです。
```
$ ssh -i ~/.ssh/ec2_local_rsa -p 20022 ec2-user@localhost
```

```
The authenticity of host '[localhost]:20022 ([::1]:20022)' can't be established.
ED25519 key fingerprint is SHA256:/ZLY*****************************tRXdw.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[localhost]:20022' (ED25519) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
```

## config

面倒な人は `~/.ssh/config` に書いておけば楽です。

```ssh-config
Host amazon-linux
HostName localhost
User ec2-user
Port 20022
IdentityFile ~/.ssh/ec2_local_rsa
```

```
$ ssh amazon-linux
Last login: Sat Feb 11 15:01:13 2023 from gateway

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@c625334c24f2 ~]$
```
