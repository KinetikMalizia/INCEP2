#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

#Check if the database exists

#if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
#then 

#	echo "Database already exists"
#else

# Set root option so that connexion without root password is not possible

mysql_secure_installation << EOF

Y
rootroot
rootroot
Y
n
Y
Y
EOF

#mysql -uroot launch mysql command line client
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot


echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress_fm.sql

#fi

/etc/init.d/mysql stop

exec "$@"