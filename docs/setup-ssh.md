# SSH 接続用設定

Amazon Linux 2023 用の設定です。

## SSH接続用設定の一括実行
次のコマンドで「鍵ペアの作成」「公開鍵のコピー」「公開鍵の権限設定」をまとめて実行できます。
```sh
make setup-ssh
```

なお、既存の `~/.ssh/ec2_local_rsa` がある場合は再作成しません。

## 一括実行の詳細
前述にて一括実行している内容の説明です。不要であれば読み飛ばしてください。

### 鍵ペアの作成
`~/.ssh/ec2_local_rsa` は任意の名前でOK。ここではこのパス、ファイル名を前提に話を進めます。
```
ssh-keygen -t rsa -f ~/.ssh/ec2_local_rsa
```

### コンテナに公開鍵をコピー

テキストをコピーして、コンテナ内で自分で authorized_keys を作ってもいいですが面倒なのでコピーで済ませます。
```sh
docker compose cp ~/.ssh/ec2_local_rsa.pub amazon-linux-2023:/home/ec2-user/.ssh/authorized_keys
```

### 公開鍵の権限を変更

コンテナにログイン。

```sh
make aml2023
```

コンテナ内でパーミッションと所有者を変更。
```sh
sudo chmod 600 ~/.ssh/authorized_keys && sudo chown ec2-user:ec2-user ~/.ssh/authorized_keys
```

## 接続

下記のコマンドを実行して接続できればOKです。

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
Last login: Fri Jun 26 17:51:06 2026 from 172.18.0.1
[ec2-user@localhost ~]$ 
```

## config

面倒な人は `~/.ssh/config` に下記の内容を書いておけば `ssh amazon-linux-2023` だけで接続が可能です。

```ssh-config
Host amazon-linux-2023
HostName localhost
User ec2-user
Port 20122
IdentityFile ~/.ssh/ec2_local_rsa
```
