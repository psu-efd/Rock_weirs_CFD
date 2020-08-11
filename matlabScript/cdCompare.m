%This is a matlab script to evaluate existing recommended Cd for rock
%weir.
%The simulated Cdi is compared with four existing recommend Cd, which are
%'BCweir','FAO','KZ', and 'USBR'.


%Cdi is the back-calculated coefficient from weir weir equation with
%simulated weir overflow (Qw) and water head (H).

%HCFD is the simulated water head (H).

%CdBCweir is the recommend coefficients developed for broad-crested weir.

%Other recommend coefficients (FAO,KZ2017,and USBR) are calculted in
%function named funRecommendCd.

%The output from function funRecommendCd is the relative difference of
%recommended and simulated coefficients.




clc; clear;


% % plot range: axis([xmin, xmax, ymin, ymax])
xmin = 0.5;  ymin = -60; ymax=60;
xmax = 5.5;
xmax2 = 5.5;

porosity = [13.46 22.03 21.9 29.37];
ci = 0.0228*porosity+1.163;

name ={'BCweir','FAO','KZ','USBR','Present'};



%% Q3

Cdi_Q3 = [0.765	0.601	0 0];
HCFD_Q3 = [0.177 0.026	0 0];
CdBCweir_Q3 = [0.497	0.344	0 0];
[errorALL_Q3, errbarFAO_Q3]= funRecommendCd(Cdi_Q3,HCFD_Q3,CdBCweir_Q3);


%add CFD ci regression resuts in the comparision
c3=ci.*CdBCweir_Q3;
ciCFDerr=100*(Cdi_Q3-c3)./Cdi_Q3;


errorALL_Q3 = [errorALL_Q3; ciCFDerr];
errbarFAO_Q3 =[errbarFAO_Q3; nan nan nan nan];


figure(1)
subplot(3,1,1)

b=bar(errorALL_Q3,'EdgeColor','none');hold on;
axis([xmin, xmax2, ymin, ymax]);
% title('(a) Q_{weir} in Q = 3 m^3/s')
title('(a)')
b(1).FaceColor = [0 0.4470 0.7410]
b(2).FaceColor =[237 63 81]/255;
b(3).FaceColor =[0.9290 0.6940 0.1250];
b(4).FaceColor = [0.4660 0.6740 0.1880];



set(gca, 'XTick', 1:length(Cdi_Q3)+1,'XtickLabel',name)
% ylabel('error (%)');
set(gca,'LineWidth',2.5,'TickLength',[0 0])
set(gca,'YGrid','on','XGrid','off')


ngroups = size(errorALL_Q3, 1);
nbars = size(errorALL_Q3, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, errorALL_Q3(:,i), errbarFAO_Q3(:,i),'LineStyle', 'None','LineWidth', 2,'color',[0 0 0]);
end
hold off





%% Q8
Cdi_Q8 = [0.808	0.827	0.779	0.886]; %real ans
HCFD_Q8= [0.484	0.359	0.358	0.238];
CdBCweir_Q8 = [0.513	0.499	0.498	0.495];
[errorALL_Q8, errbarFAO_Q8]= funbarPlotQ(Cdi_Q8,HCFD_Q8,CdBCweir_Q8);

%add CFD ci regression resuts in the comparision
c8=ci.*CdBCweir_Q8;
ciCFDerr=100*(Cdi_Q8-c8)./Cdi_Q8;

errorALL_Q8 = [errorALL_Q8; ciCFDerr];
errbarFAO_Q8 =[errbarFAO_Q8; nan nan nan nan];



subplot(3,1,2)

b=bar(errorALL_Q8,'EdgeColor','none');hold on;
axis([xmin, xmax2, ymin, ymax])
% title('(b) Q_{weir} in Q = 8 m^3/s')
title('(b)')
b(1).FaceColor = [0 0.4470 0.7410]
b(2).FaceColor =[237 63 81]/255;
b(3).FaceColor =[0.9290 0.6940 0.1250];
b(4).FaceColor = [0.4660 0.6740 0.1880];


set(gca, 'XTick', 1:length(Cdi_Q8)+1,'XtickLabel',name)
% ylabel('error (%)');
set(gca,'LineWidth',2.5,'TickLength',[0 0])
set(gca,'YGrid','on','XGrid','off')


ngroups = size(errorALL_Q8, 1);
nbars = size(errorALL_Q8, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, errorALL_Q8(:,i), errbarFAO_Q8(:,i),'LineStyle', 'None','LineWidth', 2,'color',[0 0 0]);
end
hold off




%% Q10
Cdi_Q10 = [0.799	0.831	0.849	0.912]; %real ans
HCFD_Q10= [0.572	0.443	0.443	0.319];
CdBCweir_Q10 = [0.525	0.508	0.509	0.498];
[errorALL_Q10, errbarFAO_Q10]= funbarPlotQ(Cdi_Q10,HCFD_Q10,CdBCweir_Q10);



%add CFD ci regression resuts in the comparision
c10=ci.*CdBCweir_Q10;
ciCFDerr=100*(Cdi_Q10-c10)./Cdi_Q10;



errorALL_Q10 = [errorALL_Q10; ciCFDerr];
errbarFAO_Q10 =[errbarFAO_Q10; nan nan nan nan];



subplot(3,1,3)


b=bar(errorALL_Q10,'EdgeColor','none');hold on;
axis([xmin, xmax2, ymin, ymax])
% title('(f) Q_{weir} in Q = 10 m^3/s')
title('(c)')
b(1).FaceColor = [0 0.4470 0.7410]
b(2).FaceColor =[237 63 81]/255;
b(3).FaceColor =[0.9290 0.6940 0.1250];
b(4).FaceColor = [0.4660 0.6740 0.1880];


set(gca, 'XTick', 1:length(Cdi_Q3)+1,'XtickLabel',name)
% ylabel('error (%)');
set(gca,'LineWidth',2.5,'TickLength',[0 0])
set(gca,'YGrid','on','XGrid','off')


ngroups = size(errorALL_Q10, 1);
nbars = size(errorALL_Q10, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, errorALL_Q10(:,i), errbarFAO_Q10(:,i),'LineStyle', 'None','LineWidth', 2,'color',[0 0 0]);
end
hold off


 set(gca, 'XTick', 1:length(Cdi_Q3)+1,'XtickLabel',name)


set(findall(gcf,'-property','FontSize'),'FontSize',25)
set(gca,'LineWidth',2.5,'TickLength',[0 0])

set(findall(gcf,'-property','FontName'),'FontName','Tinos')


 set(gcf,'Position',[0,0,1000,1200],'color',[1 1 1])
set(gca,'YGrid','on','XGrid','off')



