%% Simulation Exercise number3
addpath 'seemri'
clear all
close all
%%  Preparations
gammabar = 42.58e6;
gamma = 2*pi*gammabar;
%% Basic Gradient Echo Imaging
B0 = 1.5;
tp =  1e-3;
alpha = pi/2;
B1 = alpha / (gamma*tp);
f_rf = gammabar*B0;
rf = RectPulse(B1, f_rf, 0, tp);

iv = disc(3,1);
TE = 10e-3;
TR = 2;

tau = 4e-3;
FOV= 0.8;    
dw = 0.1;
kmax =  1/(2*dw);
dk = 1/FOV;
dk = kmax/ceil(kmax/dk);
ks = -kmax:dk:kmax-dk;