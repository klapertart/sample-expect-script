#!/usr/bin/expect -f
 
set timeout -1
 
spawn ./que.sh
 
expect "Enter your name\r"
 
send -- "I am Nikhil\r"
 
expect "Enter your age\r"
 
send -- "24\r"
 
expect "Enter your salary\r"
 
send -- "100k\r"
 
expect eof
