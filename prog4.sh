#!/bin/bash
directory=$1;
if [ "$#" -lt 1  ];
then 
echo "score directory missing"
exit 1;
fi
if [ ! -d  "$directory" ];
    then 
        echo "$directory is not a directory"
        exit 1
    fi
readarray -t temp < <(ls ${directory}/*.txt) 
for i in "${temp[@]}";
   do 
      totalPoint=50;
      awk -F',' 'BEGIN{studentId=0; sum=0;} NR>1; {studentId=$1; for(i=2;i<=6;i++) sum+=($i);} END{print  studentId "," sum > ".rabbitOnABlueStick.txt" }' "${i}" > ".greenglassedgoose.txt"
      rm -f ".greenglassedgoose.txt"
      while IFS="," read studentId totalScore
      do 
      ans=$((totalScore * 100))
      ans=$((ans / totalPoint))  
      if ((ans >= 93 ));
         then
            echo "${studentId}:A "
         elif (( ans >= 80 && ans <= 92 ));
         then 
            echo "${studentId}:B "
         elif (( ans >= 65 && ans <= 79 ));
         then 
            echo "${studentId}:C "
         else
            echo "${studentId}:D "
      fi
      done < ".rabbitOnABlueStick.txt"
      rm -f ".rabbitOnABlueStick.txt"
   done