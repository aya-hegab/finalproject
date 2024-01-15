#!/usr/bin/bash
shopt -s extglob

echo "created tables"

ls -F | grep -v /

while true
do
  echo "creating table..."
  read -p "write name of the table or write 1 to go back to the table menu " name_t
  case $name_t in 
    '1' )
    PS3="1)list_table 2)create_table 3)drop_table 4)insert_into_table 5)select_from_table 6)delete_from_table 7)update_table 8)back  > "
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
    for file in `ls -F | grep -v /`
      do
      if  [[ "$name_t" == $file ]]; then
        echo "$name_t already exist"
        flag='f'
      fi
      done
      if [[ $flag == 't' ]]; then
      touch ./$name_t
      touch ./"."$name_t"_metadata"
      read -p "enter num of fields " num
      if [[ $num == 0 ]]; then
      echo "can't be zero try again"
      rm ./$name_t
      rm ./"."$name_t"_metadata"
      else
      for f in `seq $num`
        do
         while true
         do
          read -p "enter name of field #$f " name
          echo -n $name >> ./"."$name_t"_metadata"
          case $name in 
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
              # if [[ `cat ./"."$name_t"_metadata" | grep ":pk" | cut -f2 -d:` == 'pk' ]]; then
              if [[ $f == '1' ]]; then
                echo -n ":pk" >> ./"."$name_t"_metadata"
                echo ":integer" >> ./"."$name_t"_metadata"
              else
              
              echo -n ":npk" >> ./"."$name_t"_metadata"
              select choice3 in integr string
              do
                case $choice3 in
                  integr )
                  echo ":integer" >> ./"."$name_t"_metadata"
                  break
                ;;
                  string )
                  echo ":string" >> ./"."$name_t"_metadata"
                  break
                ;;
                esac
              done
              fi
              
              
              break
            ;;
            * )
              echo 'not valid'
              continue 
            ;;
            esac
            done
        done
        fi
      fi
    ;;
    * )
    echo 'not valid'
    continue 
    ;;
    esac
done
