#!/usr/bin/bash
shopt -s extglob
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
      # words=`wc -w  ./$tname | tr "./$tname" " "`
      # echo $words
      if [[ "$flag" == 't' ]]; then
        echo "table not found"
      elif [[ $(wc -w <./$tname) -eq 0 ]];then
        echo "table is empty"
      else
        found='nf'
        found2='nf'
        cut -f1 -d: ".$tname""_metadata"
        read -p "syntax is col=value " syntax
        # case syntax in
          # @([=]) )
          colname=`echo $syntax | cut -f1 -d=`
          val=`echo $syntax | cut -f2 -d=`
          c=0
          cline=0
          for i in `cut -f1 -d: ".$tname""_metadata"`
          do
            ((c++))
            if [[ $i == $colname ]]; then
              fnum=$c
              found='f'
                echo -n ""> .deletedp
                for j in `cut -f$fnum -d: ./$tname`
                  do
                    ((cline++))
                    if [[ $j == $val ]]; then
                      found2='f'
                      pnum=$cline
                      echo $pnum >> .deletedp
                    fi
                  done
                  if [[ $found2 == 'nf' ]]; then
                      echo "the value: $val for the colname: $colname not found"
                  else
                    for p in `cat .deletedp`
                    do
                      sed -i "`echo $p`s/:/::/" ./$tname
                    done
                    sed -i '/::/d' ./$tname
                    echo "deleted w/ success"
                  fi
            fi
          done
          if
            [[ $found == 'nf' ]]; then
              echo "the colname: $colname not found"
          fi
        #   ;;
        #   *)
        #   echo "accepts only one val"
        # esac
        
      fi
  fi

  
done