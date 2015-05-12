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

eval cd $SUBJECTS_DIR
eval touch $TXT1
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )

	for item in $DIRS    
    	 do  
           if [ -f $FILE ];
	     then
                eval "temp=${item##*/}"
              echo  ${temp:0:9} >> $TXT1
           fi
         done
CAL=$(awk '!a[$0]++' $TXT1)
rm $TXT1

for item in  $CAL
        do  
		
		if  [ -d $item ];
			then
    		echo "$item = $len characters"
                eval "freeview -v $item/mri/norm.mgz \
         -f $item/surf/lh.pial:edgecolor=red \
            $item/surf/rh.pial:edgecolor=red \
            $item/surf/lh.white:edgecolor=blue \
            $item/surf/rh.white:edgecolor=blue"
		fi
	done    

