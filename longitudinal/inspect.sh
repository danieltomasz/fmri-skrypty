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
L=".long."

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

read  -p "What you want to see (type base or long )" variable

if [ "$variable" == "base" ]; then
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
elif [ "$variable" == "long" ]; then
	for item in  $CAL
        do  
		eval "temp1=$item${SUFF1}$L$item"
		eval "temp2=$item${SUFF2}$L$item"
		if  [ -d $temp1 ] && [ -d $temp2 ] ;then
			echo " Both files $temp1 & $temp2 exists"
			eval "freeview -v $temp1/mri/norm.mgz \
            		$temp2/mri/norm.mgz \
		     -f $temp1/surf/lh.pial:edgecolor=255,128,128 \
      	        	$temp1/surf/lh.white:edgecolor=lightblue \
			$temp1/surf/rh.pial:edgecolor=255,128,128 \
      	        	$temp1/surf/rh.white:edgecolor=lightblue \
			$temp2/surf/lh.pial:edgecolor=255,128,128 \
      	        	$temp2/surf/lh.white:edgecolor=lightblue \
			$temp2/surf/rh.pial:edgecolor=255,128,128 \
      	        	$temp2/surf/rh.white:edgecolor=lightblue"
		elif [ -d $temp1 ]; then
			echo " Only file $temp1 exists"
                	eval "freeview -v $temp1/mri/norm.mgz \
	     	     -f $temp1/surf/lh.pial:edgecolor=255,128,128 \
      	        	$temp1/surf/lh.white:edgecolor=lightblue \
			$temp1/surf/rh.pial:edgecolor=255,128,128 \
      	        	$temp1/surf/rh.white:edgecolor=lightblue"
		elif [ -d $temp2 ]; then
			echo " Only file $temp2 exists"
			eval "freeview -v $temp2/mri/norm.mgz \
		     -f $temp2/surf/lh.pial:edgecolor=255,128,128 \
      	        	$temp2/surf/lh.white:edgecolor=lightblue \
			$temp2/surf/rh.pial:edgecolor=255,128,128 \
      	        	$temp2/surf/rh.white:edgecolor=lightblue"

             
		fi
		done    
else
	echo " You mistype your command"
fi
