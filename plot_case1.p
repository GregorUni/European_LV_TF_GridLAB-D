 set terminal png
 set datafile separator ','    
 set terminal png size 900,700

 
 set autoscale 
set output 'Case1_00_01_00.png'
set multiplot layout 2,3 title "Case 1, time 00:01:00"
 

 set xlabel "Line"
 set ylabel "current rms"
set xrange [1:906]
set xtics 0,906,906

set title "phase A"
 plot    "Output_case1\\output_current_1.csv" every ::4 using (column(0)):2 with boxes notitle

set title 'phase B'
plot    "Output_case1\\output_current_1.csv" every ::4 using (column(0)):4 with boxes notitle

set title 'phase C'
plot    "Output_case1\\output_current_1.csv" every ::4 using (column(0)):6 with boxes notitle




set ylabel "voltage rms"
set xlabel "Bus"
unset title

 plot    "Output_case1\\output_voltage_1.csv" every ::4::906 using (column(0)):2 with boxes notitle

plot    "Output_case1\\output_voltage_1.csv" every ::4::906 using (column(0)):4 with boxes notitle

plot    "Output_case1\\output_voltage_1.csv" every ::4::906 using (column(0)):6 with boxes notitle


unset multiplot
unset output
set output 'Case1_09_26_00.png'
set multiplot layout 2,3 title "Case 1, time 09:26:00"
 

  set xlabel "Line"
 set ylabel "current rms"
set xrange [1:906]
set xtics 0,906,906

set title "phase A"
 plot    "Output_case1\\output_current_566.csv" every ::4 using (column(0)):2 with boxes notitle

set title 'phase B'
plot    "Output_case1\\output_current_566.csv" every ::4 using (column(0)):4 with boxes notitle

set title 'phase C'
plot    "Output_case1\\output_current_566.csv" every ::4 using (column(0)):6 with boxes notitle




set ylabel "voltage rms"
set xlabel "Bus"
unset title

 plot    "Output_case1\\output_voltage_566.csv" every ::4::906 using (column(0)):2 with boxes notitle

plot    "Output_case1\\output_voltage_566.csv" every ::4::906 using (column(0)):4 with boxes notitle

plot    "Output_case1\\output_voltage_566.csv" every ::4::906 using (column(0)):6 with boxes notitle




unset multiplot
unset output
set output 'Case1_24_00_00.png'
set multiplot layout 2,3 title "Case 1, time 24:00:00"
 

  set xlabel "Line"
 set ylabel "current rms"
set xrange [1:906]
set xtics 0,906,906

set title "phase A"
 plot    "Output_case1\\output_current_1440.csv" every ::4 using (column(0)):2 with boxes notitle

set title 'phase B'
plot    "Output_case1\\output_current_1440.csv" every ::4 using (column(0)):4 with boxes notitle

set title 'phase C'
plot    "Output_case1\\output_current_1440.csv" every ::4 using (column(0)):6 with boxes notitle




set ylabel "voltage rms"
set xlabel "Bus"
unset title

 plot    "Output_case1\\output_voltage_1440.csv" every ::4::906 using (column(0)):2 with boxes notitle

plot    "Output_case1\\output_voltage_1440.csv" every ::4::906 using (column(0)):4 with boxes notitle

plot    "Output_case1\\output_voltage_1440.csv" every ::4::906 using (column(0)):6 with boxes notitle


unset multiplot
unset output
set output 'Case1_Time_Series.png'
set title "Case 1, Time Series"
set key left top
set terminal png size 900,400
set ylabel "voltage rms"
set xlabel "Day time [minutes]"
set grid
set xrange [0:1440]
set xtic 0,100,1440

 plot   "Output_case1\\Load1_voltage.csv" every ::9 using (column(0)):2 with lines lw 2 lt 3 title "Load 1", \
    	"Output_case1\\Load32_voltage.csv" every ::9 using (column(0)):2 with lines lw 2 lt 2 title "Load 32", \
		"Output_case1\\Load53_voltage.csv" every ::9 using (column(0)):2 with lines lw 2 lt 1 title "Load 53"