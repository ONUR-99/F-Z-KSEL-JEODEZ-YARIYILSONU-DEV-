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
W_P        = 62627104.35224;%gravite potansiyeli
m          = 0.00344978600308 ; % boyutsuz büyüklük 
a          = 6378137 ; %m
W_0        = 62636856.0;%referans potansiyel değeri 
gama_0_45  = 980.6199203/100; % M/S2
gama_ekv   = 9.7803267715 ;
k          = 0.001931851353;% boyutsuz büyüklük 
G_P = 9.818649594884 * (10^ 5) / 100000; %M/S2

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

U = (GM / r) * (1 - carpim)+ (w^2 / 2) * (r^2) * ((sin(enlem_2))^2);
%fprintf("U: %.13f", U);

%BOZUCU POTANSİYEL 

T = W_P - U ;

%YÜKSEKLİK ANOMALİSİ 

C_P = W_0 - W_P; %jeopotansiyel sayı
H_D = (C_P / gama_0_45);% DİNAMİK YÜKSEKLİK M

g_cizgi = G_P + 0.0424 *(H_D/1000);
H_O = C_P / g_cizgi;%HELMERT ORTOMETRİK YÜKSEKLİK

N_1       = r - H_O ;
gama_ussu = gama_0_45*[1-(1+f+m-2*f*(sin(enlem)^2))*(H_O/a)+(((H_O/a)^2)/(a^2))];

zita = N_1-((g_cizgi - gama_ussu)/gama_ussu)*H_O; %YÜKSEKLİK ANOMALİSİ M


%GRAVİTE BOZUKLUĞU 

gama_0 = gama_ekv*((1+k*(sin(enlem)^2))/((1-e_kare*(sin(enlem)^2))^(1/2)));%m/s2
gama_h = gama_0*(1-(2*h/a)*(1+f+m-2*f*(sin(enlem)^2))+(3/a^2)*h^2);%m/s2

delta_g = (G_P - gama_h)*1000%mGal 

%GRAVİTE ANOMALİSİ 

g_0 = G_P+0.3086*H_O; 

b_delta_g = g_0 - gama_0;

fprintf("BOZUCU POTANSİYEL: %.8f\n",T);
fprintf("YÜKSEKLİK ANOMALİSİ: %.8f\n",zita);
fprintf("GRAVİTE BOZUKLUĞU: %.8f\n",delta_g);
fprintf("GRAVİTE ANOMALİSİ: %.8f\n",b_delta_g);
