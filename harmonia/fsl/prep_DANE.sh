#!/bin/bash
#sudo mount -t vboxsf -o rw,uid=1000,gid=1000 share ~/host

MAIN="/home/brain/host/DANE"
eval cd $MAIN
cd RAW
dirs=($(find $PWD -maxdepth 1 -type d))
dirs[0]=''

#${#arr[*]} number of elemements in arr
#loop over folders with different persons
#for item in ${dirs[*]}
for i in `seq 22 $(expr ${#dirs[*]} - 1)`; #wybieram numery katolalogow, tutaj kontynuuje od 22 w gore
     do 
	item=${dirs[$i]}
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
	DCM2NII=`dcm2nii -a n -d n -g n -n y -v y -f n -o $FOLDER *`
	echo $DCM2NII
	echo $FOLDER
	cd $FOLDER
        fslmerge -a dwidata $(ls -1 *.nii | sort -n)
        rm *.nii
	BVECS=$FOLDER'/bvecs'
	BVALS=$FOLDER'/bvals'
	eval mv *.bvec $BVECS
	eval mv *.bval $BVALS
        # własciwa analiza na  przygotowanych plikach nifti
        fslroi dwidata nodif_A 0 1
	fslroi dwidata nodif_B 66 1 #przygotowuję obrazy z b0
	fslmaths nodif_A -add nodif_B -div 2 nodif #uśredniony obraz
        fslroi dwidata  data_stripp 1 129 
        fslmerge -t data nodif  data_stripp #w 4D jako pierwszy  slice będzie ten uśredniony
        eddy_correct data.nii.gz data_corr.nii.gz 0
	bet data_corr.nii.gz data_corr_brain_mask.nii.gz -f .3
        dtifit -k data_corr.nii.gz -o dti -m data_corr_brain_mask.nii.gz -r bvecs -b bvals
        rm nodif_A.nii.gz nodif_B.nii.gz nodif.nii.gz  data_stripp.nii.gz data.nii.gz data_corr.nii.gz
        
done


#to jest analiza z tutorialu  fsl, której nie robię 
: <<'END'
echo 0 -1 0 0.10414 >> acqparams.txt

fslmerge -t AP_PA_b0 nodif_b0_A nodif_b0_B
topup --imain=AP_PA_b0 --datain=acqparams.txt --config=b02b0.cnf --out=topup_AP_PA_b0
applytopup --imain=nodif,nodif_PA --topup=topup_AP_PA_b0 --datain=acqparams.txt --inindex=1,2 --out=hifi_nodif
bet hifi_nodif hifi_nodif_brain -m -f 0.2
#najpierw poprawka na prądy wirowe
eddy --imain=dwidata --mask=hifi_nodif_brain_mask --index=index.txt --acqp=acqparams.txt --bvecs=bvecs --bvals=bvals --fwhm=0 \
--topup=topup_AP_PA_b0 --flm=quadratic --out=eddy_unwarped_images
dtifit -k data -m nodif_brain_mask -r bvecs -b bvals -o dti 

END
