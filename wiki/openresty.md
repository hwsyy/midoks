### openresty ʹ��

### ��Ҫ����Դ
- wget https://openresty.org/download/openresty-1.9.7.4.tar.gz
- http://www.pcre.org/

### ��װ
```
yum install readline-devel pcre-devel openssl-devel gcc

unzip pcre-8.38.zip 
./configure --enable-utf8



tar zxvf openresty-1.9.7.4.tar.gz

./configure \
--with-luajit \
--without-http_redis2_module \
--with-http_iconv_module \
--with-http_postgres_module \
--without-pcre \
--with-debug 


make
make install


make -j2 #֧�ֶ������

./configure --with-prce


```