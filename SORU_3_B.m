%MATLAB
clc; clear all; close all;

% DİNAMİK YÜKSEKLİK

gama_0_45 = 980.6199203/100; % M/S2
W_0 = 62636856.0;%referans potansiyel değeri 
W_P = 62627104.35224;%gravite potansiyeli
C_P = W_0 - W_P; %jeopotansiyel sayı

H_D = (C_P / gama_0_45);% DİNAMİK YÜKSEKLİK M

%HELMERT ORTOMETRİK YÜKSEKLİK

G_P = 9.818649594884 * (10^ 5) / 100000; %M/S2
g_cizgi = G_P + 0.0424 *(H_D/1000);
H_O = C_P / g_cizgi;%HELMERT ORTOMETRİK YÜKSEKLİK

%NORMAL YÜKSEKLİK

%H_N       = C_P / gama_ussu
%gama_ussu = gama_0*[1-(1+f+m-2*f*(sin(enlem)^2))*(H_O/a)+(((H_O/a)^2)/(a^2))]

f          = 1 / 298.257222101 ;
m          = 0.00344978600308 ; % boyutsuz büyüklük 
a          = 6378137 ; %m
enlem      = 38+45/60+0/3600 ;
enlem      = deg2rad(enlem);

gama_ussu = gama_0_45*[1-(1+f+m-2*f*(sin(enlem)^2))*(H_O/a)+(((H_O/a)^2)/(a^2))];

H_N       = C_P / gama_ussu ;

fprintf("DİNAMİK YÜKSEKLİK: %.8f\n",H_D);
fprintf("HELMERT ORTOMETRİK YÜKSEKLİK: %.8f\n",H_O);
fprintf("NORMAL YÜKSEKLİK: %.8f\n",H_N);
