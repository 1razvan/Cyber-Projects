#!/bin/bash

#add to webserver directory to run, as well as the python script and the *moby* files

rm list-syscalls-stripped
#remove previous run results
while read s
do
  echo "$s  being removed from moby-default.json"
#iterate through a list of syscalls found in moby-syscalls create a temporary seccomp profile without the syscall
  grep -v "\"${s}\"" ./default-from-moby.json > tmp.json 
  docker run -d --rm --net iss2023/bravo4_n --ip 198.51.100.149 --hostname www.iss.cyber23.test --add-host db.iss.cyber23.test:198.51.100.150 -p 8080:80 --security-opt seccomp:tmp.json --name iss2023-bravo4-web-stripped_c iss2023/bravo4-web-stripped_i 2>&1
#run the container with the new profile
  python3 seccomp-test-script.py || echo $s >> list-of-min-syscalls-running-stripped
#run the test script, if it fails then append the syscall to the list of required syscalls
  docker kill iss2023-bravo4-web-stripped_c 
#remove the container
done < ./moby-syscalls


#script is modified from the provided build-minimal-syscall.sh
#Default profile is sourced from Moby Project (2022)

