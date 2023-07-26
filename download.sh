#!/usr/bin/expect -f
 
set timeout -1
 
spawn scp root@192.168.8.121:/home/test.txt .
 
expect "*assword:"
 
send -- "getpass\r"
  
expect eof
