%MATLAB 
clc; clear all; close all;

W_0 = 62636856.0;%referans potansiyel değeri 
W_P = 62627104.35224;%gravite potansiyeli

% C_P = W_0 - W_P jeopotansiyel sayı 

C_P = W_0 - W_P;%JEOPOTANSİYEL YÜKSEKLİK M2/S2

fprintf("JEOPOTANSİYEL YÜKSEKLİK: %.8f",C_P);
