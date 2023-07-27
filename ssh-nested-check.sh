#!/usr/bin/expect -f

set timeout -1
set timeout2 30

array set remote_array {	
	root@192.168.8.68
	klapertart@192.168.8.68
}

set pass1 getpas
set pass2 getpas2
set pass3 getpass


log_file -a ssh-nested-check.log

spawn ssh root@192.168.8.75

expect "*password:"
send "getpass\r"

expect "#"


foreach {remote} [array get remote_array] {
	spawn ssh $remote

	expect {
		timeout2 {
			exit 1
		}
		"Are you sure*" {
			send "yes\r"
			exp_continue
		}
		"*password:" {
			send "$pass1\r"
			
			expect {
				"*password:" {
					send "$pass2\r"

					expect {
						"*password:" {
							send "$pass3\r"

							expect {
								"Permission denied*" {
									send "exit\r"
									expect eof
								}
								"$ " {
									puts "Connected!"
									send "exit\r"
									expect eof
								}
							}
						}			
						"$ " {
							puts "Connected!"
							send "exit\r"
							expect eof
						}
					}	
				}			
				"$ " {
					puts "Connected!"
					send "exit\r"
					expect eof
				}
			}	
		}
	}
}


log_file



