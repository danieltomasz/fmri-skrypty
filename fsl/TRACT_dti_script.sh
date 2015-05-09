#!/bin/bash
#sudo mount -t vboxsf -o rw,uid=1000,gid=1000 share ~/host

MAIN="/home/brain/host/TRACT"
eval cd $MAIN
cd RAW
dirs=($(find $PWD -maxdepth 1 -type d))
dirs[0]=''

#loop over folders with different persons
for item in ${dirs[*]}
     do     
   	echo $item
   	eval cd $item
        FOLDER=$MAIN"/PREPROC/"
   	FOLDER+=${PWD##*/}
	eval mkdir -p  $FOLDER
	   #tworzę log-file
	LOG_FILE=$FOLDER'/logfile.log'
	eval touch $LOG_FILE
	exec 1> >(tee -a ${LOG_FILE} )
	exec 2> >(tee -a ${LOG_FILE} >&2)
	DCM2NII=`dcm2nii -a y -d n -g y -n y -v y -f n -o $FOLDER *.IMA`
	echo $DCM2NII
	echo $FOLDER
	cd $FOLDER
	BVECS=$FOLDER'/bvecs'
	BVALS=$FOLDER'/bvals'
        DWIDATA=$FOLDER'/data.nii.gz'
	eval mv *.bvec $BVECS
	eval mv *.bval $BVALS
        eval mv DTI64* $DWIDATA
        eddy_correct data.nii.gz data_eddy.nii.gz 0
	bet data_eddy.nii.gz data_eddy_brain_mask.nii.gz -f .3
        dtifit -k data_eddy.nii.gz -o dti -m data_eddy_brain_mask.nii.gz -r bvecs -b bvals
done




#to jest moja rzeczywista analiza
: <<'END'
fslroi dwidata nodif 0 1
fslroi dwidata nodif_PA 65 1
fslmerge -t AP_PA_b0 nodif nodif_PA
topup --imain=AP_PA_b0 --datain=acqparams.txt --config=b02b0.cnf --out=topup_AP_PA_b0
applytopup --imain=nodif,nodif_PA --topup=topup_AP_PA_b0 --datain=acqparams.txt --inindex=1,2 --out=hifi_nodif
bet hifi_nodif hifi_nodif_brain -m -f 0.2
#najpierw poprawka na prądy wirowe
eddy --imain=dwidata --mask=hifi_nodif_brain_mask --index=index.txt --acqp=acqparams.txt --bvecs=bvecs --bvals=bvals --fwhm=0 \
--topup=topup_AP_PA_b0 --flm=quadratic --out=eddy_unwarped_images

 bvals
END
