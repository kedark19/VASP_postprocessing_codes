#!/bin/sh
############## Kedar Sharma ################ 
############### band gap  ##################
############################################
mag=`grep "mag=" OSZICAR | tail -1 | awk '{print $10}'`
nkpt=`grep NKP OUTCAR | awk '{print $4}'`
NELECT=`grep NELECT OUTCAR | awk '{print $3}'`

mag1=$(printf  '%.*f' 0 "$mag" )

homo=$(echo $NELECT - $mag1 | bc)
homo_d=$(echo $homo/2 | bc)
lumo_d=$(echo $homo_d + 1 | bc)
homo_u=$(echo $homo_d + $mag1 | bc)
lumo_u=$(echo $homo_u + 1 | bc)

e1vb=`grep "    $homo_u     " OUTCAR | head -$nkpt | sort -n -k 2 | tail -1 | awk '{print $2}'`
e1cb=`grep "    $lumo_u     " OUTCAR | head -$nkpt | sort -n -k 2 | head -1 | awk '{print $2}'`
e2vb=`grep "    $homo_d     " OUTCAR | tail -$nkpt | sort -n -k 2 | tail -1 | awk '{print $2}'`
e2cb=`grep "    $lumo_d     " OUTCAR | tail -$nkpt | sort -n -k 2 | head -1 | awk '{print $2}'`

if  [[ 1 = "$(echo "$e1vb > $e2vb" | bc)" ]]
then
vbm=$e1vb
else
vbm=$e2vb
fi

if  [[ 1 = "$(echo "$e1cb > $e2cb" | bc)" ]]
then
cbm=$e2cb
else
cbm=$e1cb
fi

echo ""
echo "##############################################"
echo "##############  Bang Gap       ###############"
echo "##############################################"
echo "HOMO:  up spin   : " $homo_u " E=   " $e1vb
echo "LUMO:  up spin   : " $lumo_u " E=   " $e1cb
echo " Band gap (up spin)   :     " $(echo $e1cb - $e1vb | bc)  " eV"
echo "----------------------------------------------"
echo "HOMO:  down spin :" $homo_d " E=   " $e2vb
echo "LUMO:  down spin :" $lumo_d " E=   " $e2cb
echo " Band gap (down spin) :     " $(echo $e2cb - $e2vb | bc)  " eV"
echo "----------------------------------------------"
echo "Fundamental  gap (eV) : " "$(echo $cbm - $vbm | bc)"  " eV"
echo "----------------------------------------------"
echo "##############################################"
echo ""
