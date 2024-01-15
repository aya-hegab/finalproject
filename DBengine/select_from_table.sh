#!/usr/bin/bash
#!/usr/bin/bash
PS3="pick from 1 to 3  > "

select choice in select_all select_by_col select_eq back
do
  case $choice in
  select_all )
    source ../../DBengine/select_all.sh
    ;;
    select_by_col )
    source ../../DBengine/select_by_col.sh
    ;;
    select_eq )
    source ../../DBengine/select_eq.sh
    ;;
    back )
    PS3="1)list_table 2)create_table 3)drop_table 4)insert_into_table 5)select_from_table 6)delete_from_table 7)update_table 8)back  > "
    break
    ;;
  * )
  echo "please chose a number from 1-3"
  esac
done