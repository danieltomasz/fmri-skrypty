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
    		echo "$item"
eval "freeview -f $item/surf/lh.pial:overlay=$item1/surf/lh.long.thickness-cp1.fwhm15.mgh:overlay_threshold=0,3.5:overlay=$item/surf/lh.long.thickness-stack.mgh:annot=$item/label/lh.aparc.annot:annot_outline=1 --timecourse --colorscale"
		fi
	done    



