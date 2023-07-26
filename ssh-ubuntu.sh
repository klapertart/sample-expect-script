#!/usr/bin/expect -f

set timeout -1

log_file -a log-ssh-ubuntu

spawn ssh klapertart@192.168.8.97

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

log_file

send "exit\r"
expect eof

