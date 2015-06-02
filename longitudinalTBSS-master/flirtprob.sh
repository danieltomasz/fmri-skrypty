#!/bin/bash
i1=BRASIG004_FA_TP1.nii.gz
i2=BRASIG004_FA_TP2.nii.gz
flirt -in  $1 -ref $i2  -omat mat1 
flirt -in $i2 -ref $i1 -omat mat2

avscale --allparams mat1 | grep -A 4 "Forward half transform" | tail -n 4 > halfmat1
avscale --allparams mat2 | grep -A 4 "Forward half transform" | tail -n 4 > halfmat2

  
