#!/bin/bash
FOLDER="/home/brain/host/DANE/PREPROC/2247"
eval cd $FOLDER
var=$(<bvals)
ar=($var)

cnt=0; 
for el in "${ar[@]}"; do
        [[ $el == "0" ]] && echo $cnt 
        ((++cnt))
done



