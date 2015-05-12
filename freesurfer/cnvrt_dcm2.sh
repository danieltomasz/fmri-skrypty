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
SUBJECTS_DIR="$LOCATION/fMRI/subjects/"
MRI_DIR="$LOCATION/fMRI/MRI/"
t1="/t1mpriso.mgz"


cd "$LOCATION/fMRI/Harmonia"
DIRS=$(find $PWD -maxdepth 1 -mindepth 1 -type d )
for item in $DIRS    
     do     
   	cd $item
            eval "temp=${item##*/}"
            if [ ${#temp} -ge 5 ]; 
		then   
                      eval  "temp=${temp:(-5)}"
                      if [[ ! -f $MRI_DIR${temp//_}$t1 ]]; then 
		      		echo "${temp//_}"
                      		mkdir -p ${MRI_DIR}${temp//_}
                     	 	path="$(find $item -maxdepth 2 -mindepth 2)"
                      		cd "${path}"
                      		MRICON=`mri_convert -it dicom -ot mgz  0001.dcm  $MRI_DIR${temp//_}$t1`
                      		echo $MRICON
                      fi
                      
		else 

                        if [[ ! -f $MRI_DIR${temp}$t1 ]]; then 
                                echo $temp
                        	mkdir -p ${MRI_DIR}${temp}
				path="$(find $item -maxdepth 2 -mindepth 2)"
                        	cd "${path}"
                                MRICON=`mri_convert -it dicom -ot mgz  0001.dcm  ${temp}`
                       		echo $MRICON
                       fi


		fi
            

   		   		
   	cd "$LOCATION/fMRI/Harmonia"
     done
