#!/usr/bin/bash
if [ -d ../DB ]; then
  echo "here we go"
else
  mkdir ../DB
fi

PS3="write from 1 to 5> "
select choice in list create connect drop exit
do
  case $choice in
  list )
    source ./list_db.sh
    ;;
  create )
    source ./create_db.sh
    ;;
  connect )
    source ./connect_db.sh
    ;;
  drop )
    source ./drop_db.sh 
    ;;
  exit )
    break
    ;;
  * )
  echo "please chose a number from 1-5"
  esac
done