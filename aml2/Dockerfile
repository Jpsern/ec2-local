FROM amazonlinux:2

# amazon-linux-extras のインストール
RUN amazon-linux-extras install -y

# yum 関係と基本セット導入
# unzip はどっかで使いそうなのでとりあえず入れておく
RUN yum update -y && yum install \
    systemd sudo tar unzip -y
