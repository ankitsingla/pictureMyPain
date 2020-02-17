# Note you need gnuplot 4.4 for the pdfcairo terminal.

set terminal pdfcairo size 5,4 font "Gill Sans, 20" linewidth 1 rounded

# Line style for axes
set style line 80 lt rgb "#808080" lw 1

# Line style for grid
set style line 81 lt 0  lw 1 # dashed
set style line 81 lt rgb "#808080"  # grey

set grid back linestyle 81 lw 1
set border 11 back linestyle 80 # Remove border on top and right.  These
             # borders are useless and make it harder
	                  # to see plotted lines near the border.
			      # Also, put it in grey; no need for so much emphasis on a border.
			      set xtics nomirror
			      set ytics nomirror

# Line styles: try to pick pleasing colors, rather
# than strictly primary colors or hard-to-see colors
# like gnuplot's default yellow.  Make the lines thick
# so they're easy to see in small plots in papers.
set style line 1 lt rgb "#f0b654" lw 2.2 pt 6 ps 1 # color was earlier #A00000
set style line 2 lt rgb "#4ab686" lw 2 pt 7 ps 0.7  # color was earlier #00A000
set style line 3 lt rgb "#e62e25" lw 4 pt 2 ps 0.9
set style line 4 lt rgb "#F25900" lw 1.6 pt 9
set style line 5 lt rgb "#996600" lw 1.6 pt 4

#set size square 1,1
set output "rejectionIsNormal.pdf"
set xlabel "Time"
set ylabel "Projects"
set format y ""

unset key
unset mxtics
set xtics 31104000          #see gnuplot time to understand this --- these are seconds in a year, so tics mark each year


# TIME FORMAT
set xdata time
timefmt="%d/%m/%Y"
set format x "%Y"
set xrange [:"1/1/21"]

set datafile separator ","
T(N) = timecolumn(N,timefmt)
set style arrow 1 filled size screen 0.02, 20 fixed lt 2 lw 3
set style arrow 2 head size screen 0.007,90 ls 1
set style arrow 3 head size screen 0.003,90 ls 1

#set label "SIGCOMM" at "1/10/17",1 font "Gill Sans, 14"
#set label "NSDI" at "1/6/19",5 font "Gill Sans, 14"
#set label "ICML" at "1/8/19",17 font "Gill Sans, 14"
#set label "CoNEXT" at "22/1/20",19 font "Gill Sans, 14"
#set label "HotNets" at "1/1/19",18 font "Gill Sans, 14"
#set label "HotNets" at "1/1/20",20 font "Gill Sans, 14"
#
## For adding question mark on not yet determined ones
symbol(z) = "?"

plot "data.csv" using (T(4)) : 1 : (T(5)-T(4)) : (0.0) with vector as 3, \
     "data.csv" using (T(5)) : 1 : ((T(6)-T(5))>0?(T(6)-T(5)):0) : (0.0) with vector as 2, \
     "data.csv" using (T(5)) : 1 : ((T(7)-T(5))>0?(T(7)-T(5)):0) : (0.0) with vector as 2, \
     "data.csv" using (T(5)) : 1 : ((T(8)-T(5))>0?(T(8)-T(5)):0) : (0.0) with vector as 2, \
     "data.csv" using (T(5)) : 1 : ((T(9)-T(5))>0?(T(9)-T(5)):0) : (0.0) with vector as 2, \
     "data.csv" using (T(5)) : 1 : ((T(10)-T(5))>0?(T(10)-T(5)):0) : (0.0) with vector as 2, \
     "data.csv" using (T(5)) : 1 : ((T(11)-T(4))>0?(T(11)-T(5)):0) : (0.0) with vector as 2, \
     "data.csv" using (T(6)>0?T(6):1/0) : 1 with p ls 2, \
     "failed.txt" using (T(2)+5000000):1:(symbol($1)) w labels textcolor ls 3, \
     "dead.txt" using (T(2)):1 w p ls 3
