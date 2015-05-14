#!/bin/bash

if [ $USER == 'fsuser' ];
	then
		FREESURFER_HOME="/usr/local/freesurfer"
		LOCATION="/media/sf_share"
	else   
		FREESURFER_HOME="/Applications/freesurfer"
		LOCATION="/Users/fsl/Desktop"
	fi

source $FREESURFER_HOME/SetUpFreeSurfer.sh
SUBJECTS_DIR="$LOCATION/FREESURFER_DATA/subjects/"
MRI_DIR="$LOCATION/FREESURFER_DATA/MRI"
TXT1="$LOCATION/FREESURFER_DATA/tmp1"
SUFF1='_SCAN1'
SUFF2='_SCAN2'

eval cd $SUBJECTS_DIR
eval mkdir -p $LONG
eval touch $TXT1
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )

	for item in $DIRS    
    	do  
	if [ -f $FILE ];then
		echo  ${item: -15:9} >> $TXT1
	fi
	done

CAL=$(awk '!a[$0]++' $TXT1)
rm $TXT1
	for item in  $CAL
        do  
		
	if [ -d $item$SUFF1 ];then
		recon-all -long $item$SUFF1 $item -all
        fi
	if  [ -d $item$SUFF2 ];
            then
               recon-all -long $item$SUFF2 $item -all
	fi
	done      


