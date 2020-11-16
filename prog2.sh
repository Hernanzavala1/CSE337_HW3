#!/bin/bash
datafile=$1;
output=$2;
if ([ -z "$datafile"  ]) || ([ -z "$output"  ]) || [ "$#" -ne 2 ] 
then
      echo "data file or output file not found"
      exit 1;
fi

if [ ! -f "$datafile" ]; then
    echo "$datafile  not found"
    exit 1
fi
# if [ ! -f  "$output" ];
# then 
# touch "${output}"
# fi
awk -F'[,;:]' '{for (i=1;i<=NF;i++) sum[i]+=$i;}; END{for (i in sum) print " col " i ": " sum[i] ;}'  "${datafile}" > "$output"