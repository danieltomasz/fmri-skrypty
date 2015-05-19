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
SUBJECTS_DIR="$LOCATION/long-tutorial/"
cd $SUBJECTS_DIR
#eval "freeview -f OAS2_0001/surf/lh.pial:overlay=OAS2_0001/surf/lh.long.thickness-avg.fwhm15.mgh:overlay_threshold=0,3.5:overlay=OAS2_0001/surf/lh.long.thickness-stack.mgh:annot=OAS2_0001/label/lh.aparc.annot:annot_outline=1 --timecourse --colorscale"
eval "freeview -f fsaverage/surf/lh.pial:overlay=$SUBJECTS_DIR/OAS2_0001/surf/lh.long.thickness-pc1.fwhm15.fsaverage.mgh:overlay_threshold=2,5 --colorscale"

