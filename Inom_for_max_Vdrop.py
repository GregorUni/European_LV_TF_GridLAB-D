#Inom_for_max_Vdrop

import numpy
import math

#r and x of positive sequence in Ohm/km
r=[3.97,
1.257,
1.15,
0.868,
0.469,
0.274,
0.089,
0.166,
0.446,
0.322]

x=[0.099,
0.085,
0.088,
0.092,
0.075,
0.073,
0.0675,
0.068,
0.071,
0.074]

code=['2c_007',
'2c_0225',
'2c_16',
'35_SAC_XSC',
'4c_06',
'4c_1',
'4c_35',
'4c_185',
'4c_70',
'4c_95_SAC_XC']


L=0.324 #assume the total length is 0.324 km
		#calculated as the largest distance from source to load
In=500 #assume the total current on the feeder is this

#Vnom=230
#Vdrop_limit=Vnom-(Vnom*0.9)

n=55 #number of loads

Vdrop_met1=numpy.real(0.5*(numpy.array(r)+(numpy.array(x)*1j))*L*In*(1+(1/(1.0*n))))


FP=0.95
FPs=math.sin(math.acos(FP))
e=((n+1)/(2*n))
print ('e value:',e)

Vdrop_met2=math.sqrt(3)*e*((numpy.array(r)*FP)+(numpy.array(x)*FPs))*L*In

for c,x,y in zip(code,Vdrop_met1,Vdrop_met2):
    print (c,' ',x,' ',y,' ')

max_Vdrop=23
Imax=max_Vdrop/(math.sqrt(3)*e*((numpy.array(r)*FP)+(numpy.array(x)*FPs))*L)
print (Imax)

from tabulate import tabulate
