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
#ln -s /usr/local/freesurfer/subjects/fsaverage /media/sf_share/FREESURFER_DATA/subjects/fsaverage

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

read  -p "What you want to do (type 'see' if you want see individual or 'glm' )" variable

if [ "$variable" == "see" ]; then

for item in  $CAL
        do  
		
		if  [ -d $item ];
			then
    		echo "$item"
eval "freeview -f $item/surf/lh.pial:overlay=$item/surf/lh.long.thickness-pc1.fwhm15.mgh:overlay_threshold=0,3.5:overlay=$item/surf/lh.long.thickness-stack.mgh:annot=$item/label/lh.aparc.annot:annot_outline=1 --timecourse --colorscale"
		fi
	done    
elif  [ "$variable" == "glm" ]; then
SUBJECTS_DIR="$LOCATION/FREESURFER_DATA/subjects"
eval "long_mris_slopes --qdec ${SUBJECTS_DIR}/qdec/long.qdec.table.dat \
      --meas thickness \
      --hemi lh \
      --sd $SUBJECTS_DIR \
      --do-pc1 --do-label \
      --generic-time \
      --fwhm 15 \
      --qcache fsaverage \
      --stack-pc1 lh.testretest.thickness-pc1.stack.mgh \
      --isec-labels lh.testretest.fsaverage.cortex.label

mri_glmfit --osgm \
           --glmdir lh.testretest.thickness-pc1.fwhm15 \
           --y lh.testretest.thickness-pc1.stack.fwhm15.mgh \
           --label lh.testretest.fsaverage.cortex.label \
           --surf fsaverage lh

tksurfer fsaverage lh pial -overlay lh.testretest.thickness-pc1.fwhm15/osgm/sig.mgh "
else
	echo " You mistype your command"
fi


