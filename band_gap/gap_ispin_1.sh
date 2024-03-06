#!/bin/sh
############## Kedar Sharma ################ 
############### band gap  ##################
############################################
VBM=`awk '/NELECT/ {print $3/2}' $1`
CBM=`awk '/NELECT/ {print $3/2+1}' $1`
nkpt=`awk '/NKPTS/ {print $4}' $1`

e1=`grep "     $VBM     " $1 | head -$nkpt | sort -n -k 2 | tail -1 | awk '{print $2}'`
e2=`grep "     $CBM     " $1 | head -$nkpt | sort -n -k 2 | head -1 | awk '{print $2}'`

echo "VBM: band:" $VBM " E=" $e1
echo "CBM: band:" $CBM " E=" $e2

echo "BAND GAP        : " $(echo  $e2 - $e1 | bc)
