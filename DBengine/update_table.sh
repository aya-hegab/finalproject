#!/usr/bin/bash
shopt -s extglob
ls -F | grep -v /

while true
do
  read -p "select a table or press 1 to go back " tname
  flag='t'
  if [[ $tname == '1' ]]; then
      PS3="1)list_table 2)create_table 3)drop_table 4)insert_into_table 5)select_from_table 6)delete_from_table 7)update_table 8)back  > "
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
              echo -n ""> .updatedp
              for j in `cut -f$fnum -d: ./$tname`
                do
                  ((cline++))
                  if [[ $j == $val ]]; then
                    found2='f'
                    pnum=$cline
                    
                    echo $pnum >> .updatedp
                    read -p "enter new value w/ syntax colname=newval " update
                    colname2=`echo $update | cut -f1 -d=`
                    newval=`echo $update | cut -f2 -d=`
                    b=0
                    for i in `cut -f1 -d: ".$tname""_metadata"`
                    do
                      # echo $i
                      # echo $colname2
                      ((b++))
                      if [[ $i == $colname2 ]]; then
                      # echo "no"
                        fnum2=$b
                        pkval=`sed -n "${fnum2}p" ".$tname""_metadata" | cut -f2 -d:`
                        datatype=`sed -n "${fnum2}p" ".$tname""_metadata" | cut -f3 -d:`
                      fi
                    done
                  fi
                done
                if [[ $found2 == 'nf' ]]; then
                    echo "the value: $val for the colname: $colname not found"
                else
                    if [[ $datatype == 'integer' ]]; then
                      case $newval in 
                      '' )
                      echo 'cannot be empty'
                      ;;
                      +(*[[:space:]]*) )
                      echo 'cannot include space'
                      # continue 
                      ;;
                      +([0-9]) )
                      if [[ $pkval == 'pk' ]]; then
                            n=`cut -f1 -d: ./$tname`
                            flag5='n'
                            for r in `echo $n`
                            do
                              if [[ $newval == $r ]]; then
                                flag5='m'
                              fi
                            done
                            if [[ $flag5 == 'm' ]]; then
                              echo "must be unique"
                            else 
                              if [[ $(wc -w <./.updatedp) -gt 1 ]];then
                                echo "must be unique"
                              else
                              for p in `cat .updatedp`
                                do
                                  oldval=`sed -n "${p}p" ./$tname | cut -f$fnum2 -d:`
                                  # echo $pkval
                                  # echo $datatype
                                  sed -i "`echo $p`s/$oldval/$newval/" ./$tname
                                done
                              fi
                            fi
                              
                      elif [[ $pkval == 'npk' ]]; then
                            for p in `cat .updatedp`
                                do
                                  oldval=`sed -n "${p}p" ./$tname | cut -f$fnum2 -d:`
                                  echo $pkval
                                  echo $datatype
                                  sed -i "`echo $p`s/$oldval/$newval/" ./$tname
                                done
                      fi
                      ;; 
                      * )
                          echo 'not valid'
                          # continue 
                        ;;
                      esac
                    elif [[ $datatype == 'string' ]]; then
                      case $newval in 
                      '' )
                      echo 'cannot be empty'
                      # continue 
                      ;;
                      +(*[[:space:]]*) )
                      echo 'cannot include space'
                      # continue 
                      ;;
                      +([0-9]) )
                        echo "cant start with num"
                      # continue
                      ;;
                      +([a-zA-Z0-9_]) )
                          if [[ $pkval == 'npk' ]]; then
                            for p in `cat .updatedp`
                                do
                                  oldval=`sed -n "${p}p" ./$tname | cut -f$fnum2 -d:`
                                  # echo $pkval
                                  # echo $datatype
                                  sed -i "`echo $p`s/$oldval/$newval/" ./$tname
                                done
                          fi
                      ;;
                      * )
                          echo 'not valid'
                          # continue 
                      ;;
                      esac
                    fi
                fi
          fi
        done
        if
          [[ $found == 'nf' ]]; then
            echo "the colname: $colname not found"
        fi
      fi
  fi

  
done