#!/bin/bash
i1=BRASIG004_FA_TP1.nii.gz
i2=BRASIG004_FA_TP2.nii.gz
o1=BRASIG004_FA_TP1_halfway.nii.gz
o2=BRASIG004_FA_TP2_halfway.nii.gz

#flirt -in  $i1 -ref $i2 -omat mat1 
#flirt -in $i2 -ref $i1 -omat mat2

avscale --allparams mat1 | grep -A 4 "Forward half transform" | tail -n 4 > halfmat1
<<Coment

avscale --allparams mat2 | grep -A 4 "Forward half transform" | tail -n 4 > halfmat2

applywarp -i $i1 -r $i2 --premat=halfmat1 -o $o1 --interp=spline
applywarp -i $i2 -r $i1 --premat=halfmat2 -o $o2 --interp=spline
Coment
