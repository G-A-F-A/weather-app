#!/bin/bash

cd /var/www/weather && mkdir -p tmp/pids

env=$1

if [ $env = "production" ]; then
  echo "** deploy to production **"
  echo "== bundle install =="
  bundle install --path vendor/bundle --jobs=4
  if [ $? -ne 0 ]; then
    echo "bundle installに失敗しました" >&2
    exit 1
  fi
  echo ""
  echo "== compile assets =="
  RAILS_ENV=production bin/rails assets:clobber
  RAILS_ENV=production bin/rails assets:precompile
  if [ $? -ne 0 ]; then
    echo "assetsのコンパイルに失敗しました" >&2
    exit 1
  fi
  echo ""
  DEPLOY_PATH="/var/www/weather"
  echo "== itamae =="
  sudo /home/ec2-user/.rbenv/shims/itamae local -y ${DEPLOY_PATH}/itamae/nodes/prod.yml ${DEPLOY_PATH}/itamae/recipes/webapp.rb
  echo "== puma restart =="
  RAILS_ENV=production bundle exec pumactl restart
fi

if [ $env = "staging" ]; then
  echo "** deploy to staging **"
  echo "== bundle install =="
  bundle install --path vendor/bundle --jobs=4
  if [ $? -ne 0 ]; then
    echo "bundle installに失敗しました" >&2
    exit 1
  fi
  echo ""
  echo "== compile assets =="
  RAILS_ENV=staging bin/rails assets:clobber
  RAILS_ENV=staging bin/rails assets:precompile
  if [ $? -ne 0 ]; then
    echo "assetsのコンパイルに失敗しました" >&2
    exit 1
  fi
  echo ""
  DEPLOY_PATH="/var/www/weather"
  echo "== itamae =="
  sudo /home/ec2-user/.rbenv/shims/itamae local -y ${DEPLOY_PATH}/itamae/nodes/stg.yml ${DEPLOY_PATH}/itamae/recipes/webapp.rb
  echo "== puma restart =="
  RAILS_ENV=staging bundle exec pumactl restart
fi
