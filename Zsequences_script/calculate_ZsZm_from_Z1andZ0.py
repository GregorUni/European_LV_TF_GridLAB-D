"""
This script calculate Zs and Zm based on Z1 and Z0
to create the Z11-Z33 matrix (in international units)
"""

import math
import numpy

r1=numpy.array([3.97
,1.257
,1.15
,0.868
,0.469
,0.274
,0.089
,0.166
,0.446
,0.322])
r1=r1*1.6

x1=[0.099
,0.085
,0.088
,0.092
,0.075
,0.073
,0.0675
,0.068
,0.071
,0.074]
x1=numpy.array(x1)

r0=[3.97
,1.257
,1.2
,0.76
,1.581
,0.959
,0.319
,0.58
,1.505
,0.804]
r0=numpy.array(r0)

x0=[0.099
,0.085
,0.088
,0.092
,0.091
,0.079
,0.076
,0.078
,0.083
,0.093]
x0=numpy.array(x0)

#pass units from km to miles:
r1=r1*1.60934
x1=x1*1.60934
r0=r0*1.60934
x0=x0*1.60934


x1=1j*x1
x0=1j*x0

z1=r1+x1
z0=r0+x0

zs=z0-((2/3)*(z0-z1))
zm=(z0-z1)/3

names = ['2c_.007',
         '2c_.0225',
         '2c_16',
         '35_SAC_XSC',
         '4c_.06',
         '4c_.1',
         '4c_.35',
         '4c_185',
         '4c_70',
         '4c_95_SAC_XC']

for i in range(10):
    print (format(names[i]),format(zs[i]),format(zm[i]))


#print ('Zs:\n')
#print (*zs, sep='\n')
#print ('\n')
#print ('Zm:\n')
#print (*zm, sep='\n')
