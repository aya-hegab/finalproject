#!/usr/bin/bash22
while true
do
  echo "connecting to a db..."
  read -p "write name of db or write 1 to go back to the menu " name_db
  if [[ $name_db == '1' ]]; then
      PS3="1)list 2)create 3)connect 4)drop 5)exit > "
      break
  fi
  flag='t'
  for dir in `cd ../DB; ls -F | grep / | tr '/' ' '`
  do
      if  [[ "$name_db" == $dir ]]; then
        cd ../DB/$name_db
        echo "inside $name_db"
        flag='f'
        PS3="write from 1 to 6> "
        select choice in list_table create_table drop_table insert_into_table select_from_table delete_from_table update_table back 
            do
              case $choice in
              list_table )
                source ../../DBengine/list_table.sh
                ;;
              create_table )
                source ../../DBengine/create_table.sh
                ;;
              drop_table )
                source ../../DBengine/drop_table.sh
                ;;
              insert_into_table )
                source ../../DBengine/insert_into_table.sh
                ;;
              select_from_table )
                source ../../DBengine/select_from_table.sh
                ;;
              delete_from_table )
                source ../../DBengine/delete_from_table.sh
                ;;
              update_table )
                source ../../DBengine/update_table.sh
                ;;
              back )
                cd ../../DBengine
                break
                ;;
              * )
              echo "please chose a number from 1-6"
              esac
            done
      # else
      #     flag='t'
      fi
  done
  if [[ $flag == 't' ]]; then
    echo "$name_db doesn't exist"
  fi
done