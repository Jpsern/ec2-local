FROM amazonlinux:2

# amazon-linux-extras のインストール
RUN amazon-linux-extras install -y

# yum 関係と基本セット導入
# unzip はどっかで使いそうなのでとりあえず入れておく
RUN yum update -y && yum install \
    systemd sudo tar unzip -y

# ec2-user の作成
# 本物らしくパスワードなしで sudo が使えるようにしておく
RUN useradd 'ec2-user' && echo 'ec2-user ALL=NOPASSWD: ALL' >> /etc/sudoers
