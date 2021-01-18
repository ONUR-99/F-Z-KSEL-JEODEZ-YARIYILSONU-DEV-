%MATLAB
clc; close all; clear all;

%VERİLENLER 
enlem      = 38+45/60+0/3600 ;
enlem      = deg2rad(enlem);
boylam     = 39+30/60+0/3600 ;
boylam     = deg2rad(boylam);
h          = 1025 ; %m
e_kare     = 0.006694380023 ; %1. dışmerkezlik 
a          = 6378137 ; %m
f          = 1 / 298.257222101 ;
k          = 0.001931851353;% boyutsuz büyüklük 
m          = 0.00344978600308 ; % boyutsuz büyüklük 
gama_ekv   = 9.7803267715; %m/s2 ekvatorda normal gravite

% elipsoit yüzeyinde normal gravite 
gama_0 = gama_ekv*((1+k*(sin(enlem)^2))/((1-e_kare*(sin(enlem)^2))^(1/2)));%m/s2

% h elipsoidal yükseklikte NORMAL GRAVİTE 

gama_h = gama_0*(1-(2*h/a)*(1+f+m-2*f*(sin(enlem)^2))+(3/a^2)*h^2);%m/s2
fprintf("NORMAL GRAVİTE: %.8f",gama_h );
