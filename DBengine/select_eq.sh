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
          filenum=0
          # for ind in `seq $nnumofloop`
          # do
          #   echo -n "" > .selectedcols_$ind
          # done
          # echo "before"
          find . -name '.selectedcols_*' -delete
          # echo "afte"
          for field in `cat ./.lines`
          do
            ((filenum++))
            sed -n "${field}p" ".$tname""_metadata" | cut -f1 -d: >> ./.selectedcols_$filenum
            echo "---" >> ./.selectedcols_$filenum
            cat ./$tname | cut -f$field -d: >> ./.selectedcols_$filenum
          done
          # echo -n "" > ./.final
          pr -m -t `ls -F .selectedcols_* | grep -v :` > ./.final
          cut -f1 -d: ".$tname""_metadata"
          echo "which rows"
          read -p "syntax is col=value " syntax2
          rowcolname=`echo $syntax2 | cut -f1 -d=`
          val=`echo $syntax2 | cut -f2 -d=`
          f5='nf'
          f5val='nf'
          c=0
          for k in `cut -f1 -d: ".$tname""_metadata"`
          do
            ((c++))
            if [[ $k == $rowcolname ]]; then
              f5='f'
              fieldnum=$c
            fi
          done
          if [[ $f5 == 'f' ]]; then
              cline=0
              echo -n ""> .updatedp
              for kval in `cut -f$fieldnum -d: ./$tname`
              do
                if [[ $kval == $val ]]; then
                 ((cline++))
                  f5val='f'
                  pnum=$cline
                  echo $pnum >> .updatedp
                fi
              done
              if [[ $f5val == 'f' ]]; then
                # for k in `echo $syntax | tr "," " "`
                # echo "name=mona"
                # cat -n ./.final | sed -n "/$val/p" | tr "$val" " "
                # cut -f1 -d: ".$tname" | cat -n | sed -n "/$val/p" | tr "$val" " "
                cut -f$fieldnum -d: ./$tname > .test
                # cat -n .test | sed -n "/$val/p" | tr "$val" " " 
                # cat -n .test | sed -n "/$val/p" | tr "$val" " " >> .test2
                # for teest in `cat .test2`
                sed -n "1p" .final
                sed -n "2p" .final
                for teest in `cat -n .test | sed -n "/$val/p" | tr "$val" " " `
                do
                  ((teest++))
                  ((teest++))
                  sed -n ${teest}p .final
                done
                
              else
                echo "val ain't found"
              fi
          else
            "col ain't found"
          fi
          # echo $syntax | tr , :
          # echo -n > ./.selectedcols
          # filenum=0
          # for ind in `seq $nnumofloop`
          # do
          #   echo -n "" > .selectedcols_$ind
          # done
          # for field in `cat ./.lines`
          # do
          #   ((filenum++))
          # # echo $syntax | tr , :
          #   sed -n "${field}p" ".$tname""_metadata" | cut -f1 -d: >> ./.selectedcols_$filenum
          #   echo "-------" >> ./.selectedcols_$filenum
          #   cat ./$tname | cut -f$field -d: >> ./.selectedcols_$filenum
          #   # cat ./$tname | cut -f$field -d: >> ./.selectedcols
          #   # echo "+" >> ./.selectedcols
          # done
          # pr -m -t `ls -F .selectedcols_* | grep -v :`
        else
          echo "some col not found"
        fi
      fi
  fi

  
done