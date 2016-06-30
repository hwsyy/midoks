
#! /bin/sh

#MySQL
cd ./source

groupadd mysql
useradd -g mysql mysql
tar zxvf "mysql-5.5.3-m3.tar.gz"
cd mysql-5.5.3-m3/
./configure --prefix=/usr/local/mysql \
--without-debug \
--enable-thread-safe-client \
--with-pthread \
--enable-assembler \
--enable-profiling \
--with-mysqld-ldflags=-all-static \
--with-client-ldflags=-all-static \
--with-extra-charsets=all \
--with-plugins=all \
--with-mysqld-user=mysql \
--without-embedded-server \
--with-server-suffix=-community \
--with-unix-socket-path=/tmp/mysql.sock
make && make install

#����Ȩ��
setfacl -m u:mysql:rwx -R /usr/local/mysql
setfacl -m d:u:mysql:rwx -R /usr/local/mysql
#��װmysql��test���ݿ�
/usr/local/mysql/bin/mysql_install_db --user=mysql
#����mysql����
#/usr/local/mysql/bin/mysqld_safe --user=mysql &
#�޸�mysql��¼����Ϊ123
#/usr/local/mysql/bin/mysqladmin -uroot password  123456789c
#��mysql��¼
#/usr/local/mysql/bin/mysql -uroot -p123456789c

#ln -s /usr/lib64/mysql/ /usr/lib/mysql

cd ../
cd ../

#mysql socket ���ӷ�ʽ
#/usr/local/mysql/bin/mysql  -S /YOKA/DB/server0/mysql.sock -uroot -p -A