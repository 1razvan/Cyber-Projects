#!/bin/bash

#move to the database server directory to run, as well as the python script and the *moby* files

rm list-of-min-syscalls-running
#remove previous run results
while read s
do
  echo "$s  being removed from moby-default.json"
#iterate through a list of syscalls found in moby-syscalls create a temporary seccomp profile without the syscall
  grep -v "\"${s}\"" ./default-from-moby.json > tmp.json
  docker run -d --rm --security-opt seccomp:tmp.json --net iss2023/bravo4_n --cap-drop=ALL --cap-add=SETGID --cap-add=SETUID --cap-add=CHOWN --ip 198.51.100.150 --hostname db.iss.cyber23.test -e MARIADB_INITDB_SKIP_TZINFO="true" --security-opt label:type:dbserver-selinux_t -e MYSQL_ROOT_PASSWORD="CorrectHorseBatteryStaple-xkcd" -v bravo4-db-volume:/var/lib:rw --user mysql -e MYSQL_DATABASE="iss2023db" --name iss2023-bravo4-db-stripped_c iss2023/bravo4-db-stripped_i 2>&1
#run the container with the new profile
  sleep 3
#wait for the database to initialise
  python3 seccomp-test-script.py || echo $s >> list-of-min-syscalls-running-stripped
#run the test script, if it fails then append the syscall to the list of required syscalls 
  docker kill iss2023-bravo4-db-stripped_c 
#remove the container
done < ./moby-syscalls


#script is modified from the provided build-minimal-syscall.sh
#Default profile is sourced from Moby Project (2022)
