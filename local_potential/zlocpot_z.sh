#!/bin/sh
###############  Kedar Sharma ###################
################  loc pot    ####################
#################################################
## get planer average potential
vaspkit << EOF 
426
3      # 1, 2, 3 are used for planner averaged potential along x, y, z directions, respectively
 
EOF

### get xlimit and ylimit
z=`head -5 POSCAR  | tail -1 | awk '{print $3}'` 
ymin=`sort PLANAR_AVERAGE.dat -n -k 2 | head -1 | awk '{print $2}'`
ymax=`sort PLANAR_AVERAGE.dat -n -k 2 | tail -1 | awk '{print $2}'`

XMAX=$(echo "scale=2; $z + 0.1"  | bc)
YMIN=$(echo "scale=2; $ymin - 1"  | bc)
YMAX=$(echo "scale=2; $ymax + 1"  | bc)

cat > plot.gnu << EOF
set term pdf size 6,4
set output "locpot.pdf"

unset key
#set key at 1,9 
#set key font ",16"
set grid
#font ",18"
set tics font ",16"
xmin=-0.1
xmax=XMAX
ymin=YMIN
ymax=YMAX
set xrange [xmin:xmax]
set yrange [ymin:ymax]
set xlabel "z (Angstrom)" font ",16"
set ylabel "Average potential (eV)" font ",16"
set arrow from xmin,0 to xmax,0 nohead
#set arrow from 0,ymin to 0,ymax nohead
set arrow from xmin,ymax1 to xmax,ymax1 nohead

set style fill transparent solid 0.5 noborder
p "PLANAR_AVERAGE.dat" u 1:2   w l lw 3 lc "blue" title "Average potential"
EOF


sed -i "s/XMAX/$XMAX/g" plot.gnu
sed -i "s/YMIN/$YMIN/g" plot.gnu
sed -i "s/YMAX/$YMAX/g" plot.gnu
sed -i "s/ymax1/$ymax/g" plot.gnu

gnuplot -p plot.gnu

rm plot.gnu

