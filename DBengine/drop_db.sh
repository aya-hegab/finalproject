#!/usr/bin/bash

while true
do
echo "dropping db..."
read -p "write name of db or write 1 to go back to the menu " name_db
    if [[ $name_db == '1' ]]; then
      PS3="1)list 2)create 3)connect 4)drop 5)exit > "
      break
    fi
    flag='t'
    for dir in `cd ../DB; ls -F | grep / | tr '/' ' '`
      do
      if  [[ "$name_db" == $dir ]]; then
        rm -r ../DB/$name_db
        echo 'deleted'
        flag='f'
      fi
      done
      if [[ $flag == 'f' ]]; then
      PS3="1) list 2) create 3) connect 4) drop 5) exit > "
      break
      else
      echo "$name_db doesn't exist"
      fi
done