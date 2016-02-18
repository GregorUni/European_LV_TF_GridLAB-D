 set terminal png
 set datafile separator ','    
 set terminal png size 900,700

 
set autoscale 
set output 'Case1_gridcolor_00_01_00.png'
set title "Case 1, time 00:01:00"

#set grid
set pointsize 0.2
set autoscale
set xlabel "coordinate x"
set ylabel "coordinate y"
set xtics autofreq
set ytics autofreq
#set xtics 380860,380000,391040
set zlabel "Voltage [V] phase A" rotate

plot 'IEEE_files\\European_LV_CSV\\Buscoords-.csv' every ::3 using 2:3
