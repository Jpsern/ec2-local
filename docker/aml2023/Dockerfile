# https://hub.docker.com/_/amazonlinux
FROM amazonlinux:2023

# DL4006警告対応
# https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 必要なものいろいろ入れる
RUN dnf update -y && dnf install \
    git tree glibc-langpack-ja update-motd openssh-server vim hostname which procps systemd sudo tar unzip -y && yum clean all

# 日本語対応
ENV LANG ja_JP.utf8
ENV LC_ALL ja_JP.utf8
ENV TZ Asia/Tokyo
RUN dnf reinstall -y glibc-common

# vim の設定ファイル
# root と ec2-user 両方に反映させたいのでスケルトンにも追加しておく
COPY .vimrc /root/.vimrc
COPY .vimrc /etc/skel/.vimrc

# SSH接続用設定
# PasswordAuthentication と Port の設定を変更
RUN mkdir -m 700 /root/.ssh && mkdir -m 700 /etc/skel/.ssh
RUN sed -ri 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
  && sed -ri 's/^PasswordAuthentication yes/#PasswordAuthentication yes/' /etc/ssh/sshd_config \
  && sed -ri 's/^#Port 22/Port 20022/' /etc/ssh/sshd_config \
  && echo 'root:password' | chpasswd

# motd の更新を実行
# 一応 enable も指定しておく
RUN update-motd --enable && update-motd

# ec2-user の作成
# 本物らしくパスワードなしで sudo が使えるようにしておく
ARG USERNAME=ec2-user
RUN useradd -m -s /bin/bash $USERNAME && echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers

# systemd実行対応用
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
