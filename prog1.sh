#!/bin/bash
src=$1;
dest=$2;
# echo "src is : $src and destination is $dest"
if ([ -z "$src"  ]) || ([ -z "$dest"  ]) || [ "$#" -ne 2 ] 
then
      echo "src and dest dirs missing"
      exit 1;
fi
if [ ! -d "$src" ] 
then
    echo "${src} not found" 
    exit 0;
fi

if [ ! -d "$dest" ] 
then
    # echo "dest does not exist creation needed!" # we need to create the dest 
    mkdir -p "$dest"
fi

x=$(find "${src}" -maxdepth 1 -type f  -name "*.c" | wc -l)
if [ "$x" -gt  3 ]; 
    then
    echo "Do you want to move this files?(y/Y)"
    files=$(find "${src}" -maxdepth 1 -type f  -name "*.c")
        for f in $files
        do
        echo "$f"
        done
    read -r response
            if [ "$response" = "y" -o "$response" = "Y" ];
            then
           mv "${src}/"*.c "${dest}"
            fi
     elif (( x > 0 && x < 3 )); then
    mv "${src}/"*.c "${dest}"
    fi  
# this below gets all of the subdirectories of the parent directory.
count=$(find "${src}" -maxdepth 1 -mindepth 1 -type d | wc -l)
# echo "echo the count is ${count}"
if (( count < 1 )); then
exit 0
fi
readarray -t x <<< `(find "${src}"  -type d)`
# echo "${x[1]}"

for i in "${x[@]}";
do
    if [  -d  "$i"  -a "$i"  !=  "$src" -a "$i" != "$dest" ];
    then 
    tempSrc=$i;
    # echo "source is now ${tempSrc}"
    IFS='/' read -ra my_arr <<< "${tempSrc}"
    #  echo "  all of them ${my_arr[*]}"
    #     echo "the number of things is ${#my_arr[@]}"
        if [ "${#my_arr[@]}" -gt 1 ];
            then
            if [ "${#my_arr[@]}" -eq 2 ] || [ "${src}" == "./" ];then
            subArr=("${my_arr[@]:1}")
            else
            subArr=("${my_arr[@]:2}")
            fi
            newDest="$dest";
                for sub in "${subArr[@]}"
                do
                newDest+="/${sub}";
                done
            #make the directory at the dest
            # rm -rf "$newDest"
            mkdir -p "$newDest"
            # move all of the files from the current src to the newdest
           x=$(find "${tempSrc}" -maxdepth 1 -type f  -name "*.c" | wc -l);
                            if [ "$x" -gt  3 ]; 
                                then
                                echo "Do you want to move this files?(y/Y)"
                               files=$(find "${tempSrc}" -maxdepth 1 -type f  -name "*.c");
                                    for f in $files
                                    do
                                    echo "$f"
                                    done
                                read -r response
                                    if [ "$response" = "y" -o "$response" = "Y" ];
                                    then
                                    mv "${tempSrc}/"*.c "${newDest}"
                                    fi
                                elif (( x > 0 && x < 3 ));then
                                 mv "${tempSrc}/"*.c "${newDest}"
                                fi
            fi
    fi
done
