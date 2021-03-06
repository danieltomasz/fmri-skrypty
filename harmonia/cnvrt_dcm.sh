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
MRI_DIR="$LOCATION/fMRI/MRI/"
DCM="/0001.dcm"

cd "$LOCATION/fMRI/Harmonia"
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )
for item in $DIRS    
     do     
   	cd $item
            eval "temp=${item##*/}"
            if [ ${#temp} -ge 5 ]; 
		then   
                     eval  "temp=${temp:(-5)}"
		      		echo "${temp//_}"
                      		mkdir -p ${MRI_DIR}${temp//_}
                     	 	path="$(find $item -maxdepth 2 -mindepth 2)"
                      		cd "${path}"
                      		RUN=`recon-all -i "${path}"$DCM -subjid  ${temp//_}`
                       		echo $RUN
                     else 
                                echo $temp
                        	mkdir -p ${MRI_DIR}${temp}
				path="$(find $item -maxdepth 2 -mindepth 2)"
                        	cd "${path}"
                        	RUN=`recon-all  -i "${path}"$DCM  -subjid  ${temp}`
                       		echo $RUN

		fi
            

   		   		
   	cd "$LOCATION/fMRI/Harmonia"
     done
#recon-all  -all -subjid
