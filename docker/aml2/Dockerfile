FROM amazonlinux:2

# amazon-linux-extras のインストール
RUN amazon-linux-extras install -y

# yum 関係と基本セット導入
# unzip はどっかで使いそうなのでとりあえず入れておく
RUN yum update -y && yum install \
    vim hostname which procps systemd sudo tar unzip -y

# 日本語対応
ENV LANG="ja_JP.UTF-8" LANGUAGE="ja_JP:ja" LC_ALL="ja_JP.UTF-8"

# ec2-user の作成
# 本物らしくパスワードなしで sudo が使えるようにしておく
ARG USERNAME=ec2-user
RUN useradd -m -s /bin/bash $USERNAME && echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers

CMD [ "/sbin/init" ]

