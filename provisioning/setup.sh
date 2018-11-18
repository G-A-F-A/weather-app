#!/bin/bash

# appディレクトリ作成
echo '== Make Dir =='
sudo mkdir /var/www && cd /var/www
sudo mkdir weather && sudo chown ec2-user:ec2-user weather

# タイムゾーン
echo '== TimeZone =='
sudo timedatectl set-timezone Asia/Tokyo

# ロケール
echo '== Locale =='
sudo localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf

# 設定の反映
sudo systemctl restart crond.service

# アップデート
echo '== yum update =='
sudo yum -y update

# MariaDBの削除
sudo yum -y remove mariadb-libs

# 必要なパッケージのインストール
echo '== package install =='
sudo yum -y install git make gcc-c++ patch openssl-devel libyaml-devel libffi-devel libicu-devel libxml2 libxslt libxml2-devel libxslt-devel zlib-devel readline-devel mysql mysql-server mysql-devel ImageMagick ImageMagick-devel epel-release

# yarnのインストール
echo '== yarn install =='
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo yum -y install yarn

# rbenv及びruby2.5.1のインストール
echo '== ruby install =='
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv rehash
rbenv install -v 2.5.1
rbenv global 2.5.1
rbenv rehash

# nginxのインストール
echo '== nginx install =='
sudo amazon-linux-extras install nginx1.12

# bundlerとitamaeのインストール
echo '== gem install =='
gem install bundler itamae --no-document

exit 0
