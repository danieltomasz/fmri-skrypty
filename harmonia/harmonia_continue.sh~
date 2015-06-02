#!/bin/bash

if [ $USER == 'fsuser' ] || [ $USER == 'daniel' ];
	then
		FREESURFER_HOME="/usr/local/freesurfer"
		#LOCATION="/media/sf_share"
                 LOCATION="/home/daniel/fMRI"
	else   
		FREESURFER_HOME="/Applications/freesurfer"
		LOCATION="/Users/fsl/Desktop"
	fi


source $FREESURFER_HOME/SetUpFreeSurfer.sh
SUBJECTS_DIR="$LOCATION/Harmonia/continue"


cd $SUBJECTS_DIR
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )

for item in $DIRS    
     do     
   	cd $item
   	if [ -f $FILE ];
		then
   		echo $item
   		COMMAND=`recon-all -make all -s   ${item##*/} -cw256 `
   		echo $COMMAND
   	fi
   		
   	cd ..
     done

