#!/usr/bin/bash
# shopt -s extglob
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
      elif [[ $(wc -w <./$tname) -eq 0 ]];then
        echo "table is empty"
      else
        found=0
      #   found2='nf'
        cut -f1 -d: ".$tname""_metadata"
        read -p "syntax is col1,col2,.. " syntax
        # cols=`echo $syntax | tr "," " "`
        nnumofloop=`echo $syntax | awk -F, '{print NF}'`
        mostcolnum=`wc -l ".$tname""_metadata" | tr ".$tname""_metadata" " "`
        echo -n "" > ./.lines
        # echo $mostcolnum
        for col in `echo $syntax | tr "," " "`
        do
          for col2 in `cut -f1 -d: ".$tname""_metadata"`
          do
            if [[ $col == $col2 ]]; then
              ((found++))
              echo `cut -f1 -d: ".$tname""_metadata" | cat -n | sed -n "/$col2/p" | tr "$col2" " "` >> ./.lines
            fi
          done
        done
        if [[ $found == $nnumofloop && $nnumofloop > $mostcolnum ]]; then 
          echo "out of range"
        elif [[ $found == $nnumofloop ]]; then
          # echo $syntax | tr , :
          # echo -n > ./.selectedcols
          filenum=0
          for ind in `seq $nnumofloop`
          do
            echo -n "" > .selectedcols_$ind
          done
          for field in `cat ./.lines`
          do
            ((filenum++))
          # echo $syntax | tr , :
            sed -n "${field}p" ".$tname""_metadata" | cut -f1 -d: >> ./.selectedcols_$filenum
            echo "---" >> ./.selectedcols_$filenum
            cat ./$tname | cut -f$field -d: >> ./.selectedcols_$filenum
            # cat ./$tname | cut -f$field -d: >> ./.selectedcols
            # echo "+" >> ./.selectedcols
          done
          pr -m -t `ls -F .selectedcols_* | grep -v :`
        else
          echo "some col not found"
        fi
      fi
  fi

  
done