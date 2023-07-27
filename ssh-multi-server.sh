#!/usr/bin/expect -f

set timeout -1

array set remote_array {	
	root@192.168.8.75 getpass
	klapertart@192.168.8.68 getpass
}


foreach {remote pass} [array get remote_array] {

	log_file -a ssh-multiserver.log

	spawn ssh $remote

	expect {
		"Are you sure*" {
			send "yes\r"
			exp_continue
		}
		"*password:" {
			send "$pass\r"
		}
	}

	expect {
		"$ " {
			send "pwd\r"
			expect "$ "
		}		
		"#" {
			send "pwd\r"
			expect "#"
		}
	}

	log_file

	send "exit\r"
	expect eof
}