#!/usr/bin/bash

while true
do
echo "dropping table..."
read -p "write name of table or write 1 to go back to the menu " name_t
    if [[ $name_db == '1' ]]; then
      PS3="1)list 2)create 3)connect 4)drop 5)exit > "
      break
    fi
    flag='t'
    for file in `ls -F | grep -v /`
      do
      if  [[ "$name_t" == $file ]]; then
        rm ./$name_t
        rm ./.$name_t"_metadata"
        echo 'deleted'
        flag='f'
      fi
      done
      if [[ $flag == 'f' ]]; then
      PS3="1) list 2) create 3) connect 4) drop 5) exit > "
      break
      else
      echo "$name_t doesn't exist"
      fi
done