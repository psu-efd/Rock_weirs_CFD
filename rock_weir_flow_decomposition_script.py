#This is a Python-based design tool developed for the proposed flow decomposition method.
#More details are in the section "A NEW DESIGN TOOL FOR ROCK WEIR HYDRAULICS" in the paper. 

import numpy as np
from scipy import optimize


################### Start of user input #########################

#Note:
#     1. All values are in SI units

#rock geometry and properties
Height_weir= 0.926     #weir (rock) height (m)
Thickness_weir = 0.9   #weir (rock) thickness in flow direction (m)
Width_weir= 7          #weir (rock) width (m)
theta= 22.03           #rock weir porosity (percentage)

#total discharge
#Qt= float(input("Please enter Qtotal: "))
Qt = 6   #specified total discharge (m^3/s)

################### End of user input #########################

#weir discharge coefficient (overflow part)
#input parameters: h-water depth above weir, B-weir thickness (along flow direction)
def Cd(h,Thickness_weir):
    cd = (-0.0032*h**6+0.0562*h**5 -0.3822*h**4 +1.2757*h**3 -2.106*h**2 +1.6268*h +2.1979)*(3/2)/np.sqrt(2*32.2)
    #print('cd=',cd)
    return cd
    
#orifice loss coefficient (interstitial flow part)
#input parameters: theta-porosity
def K(theta):
    Co = 0.0112*theta+0.3551
    #print("Co=",Co)
    return Co

#weir discharge correction coefficient due to porosity
#input parameters: theta-porosity
def Cporo(theta):
    Ci = 0.0228*theta+1.163
    #print("Ci=",Ci)
    return Ci

    
#area within the rock weir which is open to flow
A=Height_weir*Width_weir*theta/100
print('Area within rock weir open to flow, A = ',A, ' m^2.')

#define the function
#discharge function when the flow is within the rock
#i.e., interstitial flow only.
def solQ_inter_only(hg):
    y =-Qt+A*np.sqrt(2*9.81*hg)*K(theta)
    return y

#discharge function when the rock weir is submerged
#here h1 is the water depth above the weir
def solQall(h1):
    q_gap = A*np.sqrt(2*9.81*(h1+Height_weir))*K(theta)
    q_weir = Cporo(theta)*2/3*Cd(h1,Thickness_weir)*Width_weir*np.sqrt(2*9.81)*h1**1.5
    y =-Qt + q_gap + q_weir
    return y

#calculate the weir flow discharge (over the weir) given water
#depth above it.
def Qweir(h1):
    return Cporo(theta)*2/3*Cd(h1,Thickness_weir)*Width_weir*np.sqrt(2*9.81)*h1**1.5

#calculate the discharge within the rock, i.e., interstitial flow part
def Qgap(h1): 
    return A*np.sqrt(2*9.81*(h1+Height_weir))*K(theta)


#use fsolve(...) function
hg = optimize.fsolve(solQ_inter_only, 0.6) 
#print("hg=",hg)


if hg < Height_weir:
    print("Only interstitial flow, water head =", hg, " m.")
    
else:    
    hall = optimize.fsolve(solQall, 1) 
    print("With interstitial flow and weir flow, water head =", hall, " m.")
    print("With interstitial flow and weir flow, water stage =", hall+Height_weir, " m.")
    
    Qw=Qweir(hall)
    print('Weir flow, Qw=',Qw[0], ' m^3/s.')
 
    Qg=Qgap(hall)
    print('Interstitial flow, Qg=',Qg[0],' m^3/s.')

    print('Total flow, Qtotal=',Qw[0]+Qg[0], ' m^3/s.')
