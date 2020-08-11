%The relative difference of the simulated and the recommended coefficients 
%(BCweir,FAO,KZ2017,and USBR) are calculated in this function. 

%The output from function funRecommendCd is the relative difference (error
%in %).


 function [errorALL, errbarFAO]= funRecommendCd(Cdi,HCFD,CdBCweir)

 
errorALL=[]; %error ans
errbarFAO=[];
errD=[];
s = 0.05;

len = length(Cdi);


%% BCweir from Brater and King (1976)
err_eqn = 100*(Cdi-CdBCweir)./Cdi
er=[nan nan nan nan];
 
errorALL= [errorALL; err_eqn];
errbarFAO=[errbarFAO; er];


%% FAO/DVWK2002 (cd in 0.6-0.8)

DVWK6= 0.6*ones(1,len);
DVWK7= 0.7*ones(1,len);
% DVWK8= 0.8*ones(1,len);


err_DVWK6 = 100*(Cdi-DVWK6)./Cdi;
err_DVWK7 = 100*(Cdi-DVWK7)./Cdi %bar
% err_DVWK8 = 100*(Q3cd_CFDall-DVWK8)./Q3cd_CFDall;


 err67= [ abs(err_DVWK7-err_DVWK6)];%err
% err78= [ abs(err_DVWK7-err_DVWK8)];

errorALL= [errorALL; err_DVWK7];
errbarFAO=[errbarFAO; err67];

 
%% Kupferschmidt and Zhu 2017

KZ = 0.85*(HCFD/sqrt(s)).^(-0.7);
err_KZ = 100*(Cdi-KZ)./Cdi;


errorALL= [errorALL; err_KZ];
errbarFAO=[errbarFAO;er];


 
%% USBR Imquist-Johnson(2017)
%%% cd large than "one"

Wu = 7; zu = 0.9; W = 7; B = 7;
a1 =4.386; b1 = -0.601; c1 = -0.429;
USBR = a1*(Wu/zu)^b1*(W/B)^c1
err_USBR=100*(Cdi-USBR*ones(1,len))./Cdi;



 errorALL= [errorALL; err_USBR];
 errbarFAO=[errbarFAO; er];


















% axis([0, 7, -20, 80])
 
 
 
% UPQ3cd_CFDall = [0.617	0.54	0.508	0.509	0.498]; %real ans
% UPQ3cd_eqn = [0.545	0.544	0.544	0.545	0.544];
% 
% UPerr_eqn = 100*(UPQ3cd_CFDall-UPQ3cd_eqn)./UPQ3cd_CFDall
% 
%  
%  figure(2)
% 
%  bar(UPerr_eqn)
% 
%  axis([0, 7, -10, 80])
%  
 
 
 
 
% x = 1:2;
% data = [10 24.5]';
% errhigh = [2 1];
% errlow  = [4 1];
% 
% bar(x,data)                
% 
% hold on
% 
% er = errorbar(x,data,errlow,errhigh);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% 
% hold off