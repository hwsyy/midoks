### openresty ʹ��

### ��Ҫ����Դ
- wget http://openresty.org/download/ngx_openresty-1.4.3.6.tar.gz
- http://www.pcre.org/

### ��װ
```
yum install readline-devel pcre-devel openssl-devel gcc tcl

unzip pcre-8.38.zip 
./configure --enable-utf8

tar zxvf openresty-1.9.7.4.tar.gz

./configure \
--prefix=/usr/local/openresty \
--with-luajit \
--with-pcre=../pcre \
--without-http_redis2_module \
--with-http_iconv_module \
--with-http_postgres_module \
--with-debug 


make
make install


make -j2 #֧�ֶ������

##����
/usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/nginx/conf/nginx
## ֹͣ|����
/usr/local/openresty/nginx/sbin/nginx -s relaod|stop
##���
/usr/local/openresty/nginx/sbin/nginx -t

```



### ע��
--with-pcre=../pcre \ #������д pcre����ҩ·��

����ģʽ,�Ѵ����ùر�
lua_code_cache off;