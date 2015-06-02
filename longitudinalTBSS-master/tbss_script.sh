#!/bin/bash

dataPath='/home/daniel/fMRI/DTI_long'
scriptPath='/home/daniel/fMRI/skrypty/longitudinalTBSS-master'
cd $dataPath
command=`tcsh $scriptPath/tbss_long.tcsh $dataPath  BRASIG004`
echo $command

