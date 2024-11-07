#!/bin/bash

script_file="/script/directory/strip-cmd.sh"
docker_container_name="<container name>"
removed_line=""
line_number=7

while true; do
  # Check if the current line has the "-f" prefix
  current_line=$(sed "${line_number}!d" "$script_file")
  if [[ $current_line == "  -f"* ]]; then
    echo "line has -f"
    # Remove the current line and save it
    docker kill iss2023-bravo4-db-forcestripped_c
    docker rm iss2023-bravo4-db-forcestripped_c
    docker rmi iss2023/bravo4-db-forcestripped_i
    removed_line=$current_line
    sed -i "${line_number}d" "$script_file"
  else
    echo "[Not -f prefix. BREAKING!]"
    # Exit the loop if the current line no longer has the "-f" prefix
    break
  fi

  # Execute the modified script
  sudo $script_file
  docker run -d --net iss2023/bravo_n --ip 198.51.100.150 --hostname db.iss.cyber23.test -e MYSQL_ROOT_PASSWORD="CorrectHorseBatteryStaple-xkcd" -e MYSQL_DATABASE="iss2023db" -e MARIADB_INITDB_SKIP_TZINFO="true" --name iss2023-bravo4-db-forcestripped_c iss2023/bravo4-db-forcestripped_i
  # Wait for 6 seconds
  sleep 6

  # Check if the Docker container is running
  docker_status=$(docker inspect -f '{{.State.Running}}' $docker_container_name)
  if [[ $docker_status == "true" ]]; then
    # Update the line number to the next line
    echo "[REMOVED] $removed_line" >> removed_lines.txt
  else
    # Append the removed line to the bottom of the script
    echo "[*DID NOT REMOVE*]: $removed_line" >> needed_lines.txt
    echo "$removed_line" >> "$script_file"
  fi
done





