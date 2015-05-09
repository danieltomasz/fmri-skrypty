#!/bin/bash

FREESURFER_HOME="/Applications/freesurfer"
FREESURFER_HOME="/usr/local/freesurfer"
source $FREESURFER_HOME/SetUpFreeSurfer.sh

LOCATION="/Users/fsl/Desktop"
LOCATION="/media/sf_share"
SUBJECTS_DIR="$LOCATION/FREESURFER_DATA/subjects/"
MRI_DIR="$LOCATION/FREESURFER_DATA/MRI"
TXT1="$LOCATION/FREESURFER_DATA/tmp1"
TXT2="$LOCATION/FREESURFER_DATA/tmp2"
SUFF1='_SCAN1/'
SUFF2='_SCAN2/'
eval cd $SUBJECTS_DIR
eval touch $TXT1
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )

	for item in $DIRS    
    	 do  
           if [ -f $FILE ];
	     then
              echo  ${item: -15:9} >> $TXT1
           fi
         done
CAL=$(awk '!a[$0]++' $TXT1)
rm $TXT1
	for item in  $CAL
        do  
		if [[ -d $item$SUFF1 && -d $item$SUFF2 ]]; 
			then 
    			recon-all -base $item -tp $item$SUFF1 -tp $item$SUFF2 -all
		elif  [ -d $item$SUFF1 ];
			then
			recon-all -base $item -tp $item$SUFF1 -all
		else
     			recon-all -base $item -tp  $item$SUFF2 -all
		fi
	done      

