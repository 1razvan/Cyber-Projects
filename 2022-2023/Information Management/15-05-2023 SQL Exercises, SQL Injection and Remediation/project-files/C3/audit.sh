#!/bin/bash

# you must replace "postgresql.conf" in the postgresql config folder
# run the script as sudo

script_dir=$(pwd)

systemctl restart postgresql

cd ../C1/ && ./test.sh

chmod 777 /var/lib/postgresql/14/pg_log/

cd /var/lib/postgresql/14/pg_log/

latest_log=$(ls -tp | grep -v /$ | head -1) 

cp /var/lib/postgresql/14/pg_log/$latest_log $script_dir/

cd $script_dir

less $latest_log


