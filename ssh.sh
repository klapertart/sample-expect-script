#!/usr/bin/expect -f

set timeout -1

spawn ssh root@192.168.8.110

expect "*password: "
send "getpass\r"
expect "#"

log_file -a telnetlog2

send "cd /home\r"
expect "#"
send "pwd\r"
expect "#"
send "ls\r"
expect "#"

log_file

#expect -re "(.*)\r"

#set output $expect_out(1,string)

#puts "Command Output: $output\n"

send "exit\r"
expect eof

