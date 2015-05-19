#!/bin/bash

if [ $USER == 'fsuser' ] || [ $USER == 'brain' ];
	then
		FREESURFER_HOME="/usr/local/freesurfer"
		LOCATION="/media/sf_share"
	else   
		FREESURFER_HOME="/Applications/freesurfer"
		LOCATION="/Users/fsl/Desktop"
	fi


source $FREESURFER_HOME/SetUpFreeSurfer.sh
SUBJECTS_DIR="$LOCATION/Harmonia/subjects/"


cd $SUBJECTS_DIR
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )

for item in $DIRS    
     do     
   	cd $item
   	if [ -f $FILE ];
		then
   		echo $item
   		COMMAND=`recon-all  -all -subjid ${item##*/} -cw256`
   		echo $COMMAND
   	fi
   		
   	cd ..
     done
