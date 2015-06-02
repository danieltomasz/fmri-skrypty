#!/bin/bash

if [ $USER == 'daniel' ];
	then
		FREESURFER_HOME="/usr/local/freesurfer"
		LOCATION="/home/daniel/fMRI"

	else   
		FREESURFER_HOME="/Applications/freesurfer"
		LOCATION="/Users/fsl/Desktop"
	fi


source $FREESURFER_HOME/SetUpFreeSurfer.sh

DATAFOLDER='Freesurfer_32ch'
SUBJECTS_DIR="$LOCATION/$DATAFOLDER/subjects"
MRI_DIR="$LOCATION/$DATAFOLDER/MRI"
eval "mkdir -p $SUBJECTS_DIR"

eval cd $MRI_DIR
echo $PWD
FILE="t1mpriso.nii"
i=1

DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )
#echo $DIRS
for item in $DIRS    
     do     
   	cd $item/T1
        
   	if [ -f $FILE ];
		then
   		echo $item
   		COMMAND=`recon-all -autorecon-all -s $item -i $item/T1/$FILE`
   		echo $COMMAND
   	fi
   		
   	cd ..
     done


