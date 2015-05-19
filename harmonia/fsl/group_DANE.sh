#!/bin/bash

MAIN="/home/brain/host/DANE/PREPROC"
eval cd $MAIN

dirs=($(find $PWD -maxdepth 1 -type d))	
dirs[0]=''

#loop over folders with different persons
for item in ${dirs[*]}
     do     
   	echo $item
   	eval cd $item
        NAZWA="/home/brain/host/DANE/TBSS/"
        BASE=$(basename $item)
        NAZWA+=$BASE'FA.nii.gz'
        echo $NAZWA
        eval cp dti_FA.nii.gz  $NAZWA
done

#analysis within the folder
cd "/home/brain/host/DANE/TBSS/"
tbss_1_preproc *.nii.gz
tbss_2_reg -T
tbss_3_postreg -S
tbss_4_prestats 0.3
cd Stats
randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -c 1.5
tbss_fill tbss_clustere_corrp_tstat1 0.949 mean_FA tbss_clustere_corrp_tstat1_filled
fslview $FSLDIR/data/standard/MNI152_T1_1mm mean_FA_skeleton -l Green  -b .3,.7 tbss_tstat1 -l Red-Yellow -b 1.5,3 tbss_clustere_corrp_tstat1_filled  -l Blue-Lightblue -b 0.949,1



