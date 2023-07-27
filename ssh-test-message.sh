#!/usr/bin/expect -f

set timeout -1

spawn ssh root@192.168.8.75

expect "*password: "
send "getpass\r"
expect "#"

set msg "Hello World"
send "echo $msg\r"

expect "$msg"

send "exit\r"
expect eof

