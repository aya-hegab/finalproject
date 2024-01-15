#!/usr/bin/bash
ls -F | grep -v /

while true
do
  read -p "select a table or press 1 to go back " tname
  flag='t'
  if [[ $tname == '1' ]]; then
      PS3="1)delete_by_col 2)delete_all 3)back > "
      break
  else
      for t in `ls -F | grep -v /`
      do
        
        if [[ "$tname" == $t ]]; then
          flag='f'
        fi
      done
      if [[ "$flag" == 't' ]]; then
        echo "table not found"
      else
        echo -n "" > ./$tname
        PS3="1)delete_by_col 2)delete_all 3)back > "
        break
      fi
  fi

  
done