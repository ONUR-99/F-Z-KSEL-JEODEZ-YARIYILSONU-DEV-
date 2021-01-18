%MATLAB
clc; clear all; close all;

%VERİLENLER 
e_ussukare = 0.006739496775 ;%2. dışmerkezlik
e_kare     = 0.006694380023 ;%1. dışmerkezlik
a          = 6378137 ; %m
f          = 1 / 298.257222101 ;
GM         = 3986005*10^8 ; % m3/s2
w          = 7.292115*10^(-5) ; %rad/s
enlem      = 38+45/60+0/3600 ;
enlem      = deg2rad(enlem);
boylam     = 39+30/60+0/3600 ;
boylam     = deg2rad(boylam);
h          = 1025 ; %m
b          = 6356752.3141 ; %m küçük yarıçap
c          = 6399593.6259 ; %m kutup eğrilik yarıçapı

%meridyene dik yöndeki eğrilik yarıçapı
N = c /( ( 1 + e_ussukare * (cos(enlem))^2 ) ^ (1/2)) ;

%jeodezik dik koordinatlar 

x = (N + h) * (cos(enlem) * cos(boylam)) ; %m
y = (N + h) * (cos(enlem) * sin(boylam)) ; %m
z = ((1 - e_kare)* N + h) * sin(enlem) ; %m

%KÜRSEL KOORDİNATLAR 
% radyal bileşen 
r = (x^2 + y^2 + z^2)^ (1/2) ;
% boylam 
boylam_2 = atan(y/x) ;
% enlem
enlem_2 = atan( ((x^2 + y^2)^(1/2)) / z);

%Küresel koordinatları verilen bir noktanın normal gravite potansiyeli 

%P_n_t = ((2 * n - 1) / n) * t * P_n_1_t - ((n - 1) / n) * P_n_2_t;
t = cos(enlem_2);
J_2 = 1.08263000*10^(-3);
J_4 = -2.37091222*10^(-6);
J_6 = 6.0834706*10^(-9);
J_8 = -1.427*10^(-11);

P_0_t = 1 ;
P_1_t = cos(enlem_2);

n = 2;
D_1 = (a/r)^(n) ;
P_2_t = ((2 * n - 1) / n) * t * P_1_t - ((n - 1) / n) * P_0_t ;

n =3 ;
P_3_t = ((2 * n - 1) / n) * t * P_2_t - ((n - 1) / n) * P_1_t ;

n =4 ;
D_2 = (a/r)^(n) ;
P_4_t = ((2 * n - 1) / n) * t * P_3_t - ((n - 1) / n) * P_2_t;

n =5 ;
P_5_t = ((2 * n - 1) / n) * t * P_4_t - ((n - 1) / n) * P_3_t ;

n =6 ;
D_3 = (a/r)^(n);
P_6_t = ((2 * n - 1) / n) * t * P_5_t - ((n - 1) / n) * P_4_t ;


carpim =(P_2_t * J_2 * D_1)+(P_4_t * J_4 * D_2)+(P_6_t * J_6 * D_3);
%fprintf("Çarpım: %.13f", carpim);

%küresel koordinatları verilen bir noktanın NORMAL GRAVİTE POTANSİYELİ

U = (GM / r) * (1 - carpim)+ (w^2 / 2) * (r^2) * ((sin(enlem_2))^2)
fprintf("NORMAL GRAVİTE POTANSİYELİ: %.8f", U);
