#!/usr/bin/bash
shopt -s extglob

echo "created tables are"



ls -F | grep -v /
while true
do
  read -p "enter table name u want to insert into or type 1 to go back " table
  flag='t'
  if [[ $table == '1' ]]; then
      PS3="1)list_table 2)create_table 3)drop_table 4)insert_into_table 5)select_from_table 6)delete_from_table 7)update_table 8)back  > "
      break
  fi
  for t in `ls -F | grep -v /`
  do
    
    if [[ "$table" == $t ]]; then
      flag='f'
      numf=`wc -l ".$table""_metadata" | tr ".$table""_metadata" " "`
      for i in `seq $numf`
      do
      while true
      do
        read -p "enter val of col `sed -n "${i}p" ".$table""_metadata" | cut -f1 -d:` " colval
        header=`sed -n "${i}p" ".$table""_metadata" | cut -f1 -d:`
        pkval=`sed -n "${i}p" ".$table""_metadata" | cut -f2 -d:`
        datatpe=`sed -n "${i}p" ".$table""_metadata" | cut -f3 -d:`
        if [[ $datatpe == 'integer' ]]; then
          case $colval in 
          '' )
          echo 'cannot be empty'
          
          continue 
          ;;
          +(*[[:space:]]*) )
          echo 'cannot include space'
          continue 
          ;;
          +([0-9]) )
          if [[ $pkval == 'pk' ]]; then
                if [[ `find . -empty` == "./$table" ]]; then
                    echo -n "$colval" >> ./$table
                    break
                fi
                
                # for r in `cat ./$table | grep "_$header" | tr "_$header" " "`
                n=`cut -f1 -d: ./$table`
                flag2='n'
                for r in `echo $n`
                do
                # echo "r is $r"
                # echo "val is $colval"
                  if [[ $colval == $r ]]; then
                    flag2='m'
                  fi
                done
                if [[ $flag2 == 'm' ]]; then
                  echo "$header must be unique"
                
                # elif [[ $flag2 != 'm' ]]; then
                else 
                  echo -n "$colval" >> ./$table
                  break
                fi
                  
          elif [[ $pkval == 'npk' ]]; then
                echo -n ":$colval" >> ./$table
                break
          fi
          ;; 
          * )
              echo 'not valid'
              continue 
            ;;
          esac
        elif [[ $datatpe == 'string' ]]; then
          case $colval in 
          '' )
          echo 'cannot be empty'
          continue 
          ;;
          +(*[[:space:]]*) )
          echo 'cannot include space'
          continue 
          ;;
          +([0-9]) )
            echo "cant start with num"
          continue
          ;;
          +([a-zA-Z0-9_]) )
              if [[ $pkval == 'npk' ]]; then
                echo -n ":$colval" >> ./$table
                break
              fi
          ;;
          * )
              echo 'not valid'
              continue 
          ;;
          esac
        fi
       done
        
      done
      echo "" >> ./$table
    fi
  done
if [[ $flag == 't' ]]; then
  echo "$table doesn't exists"
fi
done









