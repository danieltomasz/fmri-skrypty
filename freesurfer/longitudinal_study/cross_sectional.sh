#!/bin/bash

FREESURFER_HOME="/Applications/freesurfer"
source $FREESURFER_HOME/SetUpFreeSurfer.sh
LOCATION="/Users/fsl/Desktop"
SUBJECTS_DIR="$LOCATION/FREESURFER_DATA/subjects"
MRI_DIR="$LOCATION/FREESURFER_DATA/MRI"


eval cd $MRI_DIR
echo $PWD
FILE="t1mpriso.nii"
i=1

DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )

for item in $DIRS    
     do     
   	cd $item
   	if [ -f $FILE ];
		then
   		echo $item
   		COMMAND=`recon-all -autorecon-all -s $item -i $item/$FILE`
   		echo $COMMAND
   	fi
   		
   	cd ..
     done


