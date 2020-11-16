#!/bin/bash
file=$1;
dictionary=$2;
if [ "$#" -lt 1  ];
    then 
    echo "input file and dictionary missing"
    exit 1;
fi
if [ "$#" -lt 2  ];
    then 
    echo "Either input file or dictionary is missing "
    exit 1;
fi
if [[ ! -f  "$file"  ]];
    then 
        echo "$file  is not a file"
        exit 1;
elif [[ ! -f  "$dictionary"  ]];
        then 
         echo "$dictionary is not a file"
         exit 1;
fi
readarray -t resultSet < <(grep -Eo '\b[[:alpha:]]{4}\b' $file) 
# echo "${resultSet[*]}"
for i in "${resultSet[@]}"
do
   if grep -qF "$i" "$dictionary";then
        # echo "$i"
        echo -n ''
        else
        echo "$i"
    fi
done