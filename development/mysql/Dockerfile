FROM mysql:8.0

COPY ./custom.conf /etc/mysql/conf.d/mysql.cnf

CMD ["mysqld", "--slow_query_log=1"]
