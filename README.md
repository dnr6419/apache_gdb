# apache_gdb
GDB debugging on Apache

GDB를 이용하여 apache를 동적으로 분석할 수 있도록 만든 이미지 입니다. 

GDB 플러그인 중 하나인 gef를 호환하며 사용할 수 없는 명령어가 다수 있으므로 용도에 맞게 커스터마이징 하시기 바랍니다. 

1. run.sh에 있는 명령어를 수행합니다. 

2. gdb httpd를 수행합니다. 
<pre>
root@de20ed0d1410:/usr/local/apache2# gdb httpd
GNU gdb (Debian 8.2.1-2+b3) 8.2.1
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
</pre>

3. 원하는 함수를 breakpoint를 겁니다. 
readelf 함수를 이용하여 함수의 symbol을 확인할 수 있습니다. 
<pre>
root@1fede8df4ec1:/usr/local/apache2# readelf -s `which httpd` | grep merge | grep file
   306: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND apr_filepath_list_merge
  2439: 00000000000373a0     0 FUNC    GLOBAL DEFAULT  UND apr_filepath_merge
  2216: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND apr_filepath_list_merge
  3705: 00000000000373a0     0 FUNC    GLOBAL DEFAULT  UND apr_filepath_merge
(gdb) b (원하는 함수)
(gdb) b apr_filepath_merge
</pre>

4. breakpoint를 걸어둔 상태에서 다음 명령어를 실행시킵니다.

<pre>
(gdb) run -X -d /usr/local/apache
</pre>

5. gdbserver를 이용해서 IDA와 Ghidra와 같은 프로그램으로 remote debugging이 가능합니다. 
