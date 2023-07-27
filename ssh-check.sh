#!/usr/bin/expect -f

set timeout 30

array set remote_array {	
	rot@192.168.8.75
	root@192.168.8.75
}

set pass1 getpas
set pass2 getpas2
set pass3 getpas

foreach {remote} [array get remote_array] {

	log_file -a ssh-check.log

	spawn ssh $remote

	expect {
		timeout {
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
								"#" {
									puts "Connected!"
									send "exit\r"
									expect eof
								}
							}
						}			
						"#" {
							puts "Connected!"
							send "exit\r"
							expect eof
						}
					}	
				}			
				"#" {
					puts "Connected!"
					send "exit\r"
					expect eof
				}
			}	
		}
	}

	log_file
}