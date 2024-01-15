#!/usr/bin/bash
shopt -s extglob
while true
do
  echo "creating db..."
  read -p "write name of db or write 1 to go back to the db menu " name_db
  case $name_db in 
    '1' )
    PS3="1)list 2)create 3)connect 4)drop 5)exit > "
    break
    ;;
    '' )
    echo 'cannot be empty'
    continue 
    ;;

    +(*[[:space:]]*) )
    echo 'cannot include space'
    continue 
    ;;
    +([0-9]) )
    echo 'cannot start with num'
    continue
    ;; 
    +([a-zA-Z0-9_]) )
    flag='t'
    for dir in `cd ../DB; ls -F | grep / | tr '/' ' '`
      do
      if  [[ "$name_db" == $dir ]]; then
        echo "$name_db already exist"
        flag='f'
      fi
      done
      if [[ $flag == 't' ]]; then
      mkdir ../DB/$name_db
      echo 'done'
      PS3="1)list 2)create 3)connect 4)drop 5)exit > "
      break
      fi
    ;;
    * )
    echo 'not valid'
    continue 
    ;;
    esac
done
