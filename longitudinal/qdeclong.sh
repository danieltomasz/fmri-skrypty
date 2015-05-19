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

#COMMAND=`long_mris_slopes --qdec ${SUBJECTS_DIR}qdec/long.qdec.table.dat --meas thickness --hemi lh --do-avg --do-rate --do-pc1 --do-spc --do-stack --do-label --time years --qcache fsaverage --sd $SUBJECTS_DIR`
#echo $COMMAND
#COMMAND=`long_mris_slopes --qdec ${SUBJECTS_DIR}qdec/long.qdec.table.dat --meas thickness --hemi rh --do-avg --do-rate --do-pc1 --do-spc --do-stack --do-label --time years --qcache fsaverage --sd $SUBJECTS_DIR`
#echo $COMMAND

cd $SUBJECTS_DIR
eval "long_qdec_table --qdec ./qdec/long.qdec.table.dat --cross --out ./qdec/cross.qdec.table.dat"
eval "qdec --table ./qdec/cross.qdec.table.dat"