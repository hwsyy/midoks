### window编译php及php扩展

- https://wiki.php.net/internals/windows/stepbystepbuild
- http://windows.php.net/downloads/php-sdk/
- https://github.com/php-memcached-dev/php-memcached
- http://www.cygwin.com/
- http://svn.coderepos.org/share/lang/c/libmemcached-win32/

```

phpsdk_setvars.bat

buildconf
configure --help
configure --disable-all --enable-cli
nmake

nmake snap

```


- 遇到的问题

- 1.命令缺少(mc)
从vs2012命令行进入,不会遇到此问题( VS2012->工具->Visual Studio命令提示(C) )
```
Recreating build dirs
        "" -h win32\ -r x64\Release_TS\ -x x64\Release_TS\ win32\build\wsyslog.m
c
'-h' 不是内部或外部命令，也不是可运行的程序
或批处理文件。
NMAKE : fatal error U1077: “"”: 返回代码“0x1”


C:/Program Files (x86)/Windows Kits/8.0/bin/x64/mc.exe(路径加入到系统变量中)
```

### 相关文章
- http://blog.csdn.net/letshi/article/details/45702299

- 如有错误及不足,欢迎指正