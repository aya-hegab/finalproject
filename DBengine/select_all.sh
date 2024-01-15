#!/usr/bin/bash
ls -F | grep -v /

while true
do
  read -p "select a table or press 1 to go back " tname
  flag='t'
  if [[ $tname == '1' ]]; then
      PS3="1)select_all 2)select_by_col 3)select_eq 4)back > "
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
        cut -f1 -d: ".$tname""_metadata" | xargs -n20 | tr ' ' :
        cat ./$tname
        PS3="1)select_all 2)select_by_col 3)select_eq 4)back > "
        break
      fi
  fi

  
done