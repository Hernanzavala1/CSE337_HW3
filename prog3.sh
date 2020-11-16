#!/bin/bash
weightFile=$1;
    if [ ! -f  "$weightFile" ];
    then 
        echo "missing data file"
        exit 1
    fi
    # check the number of questions iin the weight file, if the length of the input weight array then append ones, if its equal then continue
    #if the lenght of the weights array is greater than the number of questions take a subarray up to N
VAR=$(awk -F',' 'END{ print NF};' $weightFile > .weirdhaireddummy.txt);
read NF < ".weirdhaireddummy.txt"
NF=$((NF - 1 ))
rm -f ".weirdhaireddummy.txt"
input=("$@");
C=("${input[*]:1}")
read -a weights <<< $C
    if [[ "$NF" -lt "${#weights[@]}" ]];
    then
        dif=$((${#weights[@]} - $NF ));
        length=$((${#weights[@]}));
        length=$((length - dif))
        weights=("${weights[*]:0:$length}")
    elif [[ "$NF" -gt "${#weights[@]}" ]];
    then
        dif=$(( $NF - ${#weights[@]} ));
        count=1;
        for (( c=1; c<=dif; c++ ))
            do  
            weights[${#weights[@]}]=1;
            done
    fi

awk -v array1="${weights[*]}" -F',' 'BEGIN{split(array1,list," "); sum=0; count=0} NR>1;  /^\s*$/ {next;}  {count+=1;  for(i=2;i<=NF;i++) sum+=(list[i-1]*$i);} END{ print sum "," count > ".iloveannasomuch.txt"}' "${weightFile}" > ".likesooomuch.txt"

while IFS="," read result count
do 
    count=$((count - 1)); 
    tot=0;
    for i in ${weights[@]}; do
    let tot+=$i
    done
   devibeBy=`expr  $tot \* $count`
    ans=`expr $result / $devibeBy `    
   echo "$ans"
done < ".iloveannasomuch.txt"
rm -f ".iloveannasomuch.txt"
rm -f ".likesooomuch.txt"