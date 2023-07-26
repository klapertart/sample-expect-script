#!/usr/bin/expect -f

set timeout -1

log_file -a ssh-nested.log

spawn ssh root@192.168.8.110

expect "*password:"
send "getpass\r"

expect "#"
send "ssh klapertart@192.168.8.97\r"

	expect {
		"Are you sure*" {
			send "yes\r"
			exp_continue
		}
		"*password:" {
			send "getpass\r"
		}
	}

	expect "$ "
	send "pwd\r"

	expect "$ "
	send "ls -l\r"

	expect "$ "
	send "exit\r"

expect "#"
send "pwd\r"

expect "#"

log_file

send "exit\r"
expect eof
