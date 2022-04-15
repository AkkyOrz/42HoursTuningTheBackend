#!/bin/bash

# ===========================
# 負荷試験スクリプト
# サービスを一度再起動した後、負荷試験を実施します。
# ===========================

echo "サービスを再起動します。"
mv /var/log/nginx/access.log "/var/log/nginx/`date +"%Y%m%d%H%M%S"`_access.log"
mv /var/log/mysql/mysql-slow.log "/var/log/mysql/`date +"%Y%m%d%H%M%S"`_mysql-slow.log"
touch /var/log/nginx/access.log
chmod 777 /var/log/nginx/access.log
touch /var/log/mysql/mysql-slow.log
chmod 777 /var/log/mysql/mysql-slow.log

(cd ../development && docker-compose down && docker-compose up -d)

while :
do
    mysql=$(docker ps -f status=running --format "{{.ID}}\t{{.Names}}" | grep mysql. | cut -f 1)

    if [ -n "$mysql" ]; then
        break;
    fi
    echo "mysqlコンテナの作成を待機しています..."
    sleep 1
done

while :
do
    docker exec -it $mysql bash -c "echo -n 'select 1;' | mysql app" &> /dev/null && break
    echo "mysqlコンテナの起動を待機しています..."
    sleep 1
done

echo "負荷試験を開始します。"
(cd ../scoring/tool && locust)
