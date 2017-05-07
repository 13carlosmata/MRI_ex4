%% Simulation Exercise number4
addpath 'seemri'
clear all
close all
%%  Preparations
gammabar = 42.58e6;
gamma = 2*pi*gammabar;
%% Basic Gradient Echo Imaging
res = 1;
B0 = 1.5;
tp =  1e-3;
alpha = pi/2;
B1 = alpha / (gamma*tp);
f_rf = gammabar*B0;
rf = RectPulse(B1, f_rf, 0, tp);

iv = disc(3,res);
TE = 10e-3;
TR = 2;

tau = 4e-3;
FOV= 1;   %Changed to 220 when using brain* functions    
dw = res;
kmax =  1/(2*dw);
dk = 1/FOV;

dk = kmax/ceil(kmax/dk);
ks = -kmax:dk:kmax-dk;
w = gamma*B0;

Gpexs = ks/(gammabar*tau);
gx = Gradient([tp tp+tau], {Gpexs 0});
Gfey1 = -kmax/(gammabar*tau);
Gfey2 = kmax/(gammabar*tau);
gy = Gradient([tp tp+tau TE-tau TE+tau], [Gfey1 0 Gfey2 0]);
%%
dt = dk/(gammabar*Gfey2);
adc = ADC(TE-tau, TE+tau, dt);
[S,ts] = seemri(iv,B0,rf,gx,gy,adc,TR,length(Gpexs),'Plot',false);
%[S1,ts1] = brain_4mm_pixel(B0,rf,gx,gy,adc,TR,length(Gpexs));
%[S1,ts1] = brain_2mm_pixel(B0,rf,gx,gy,adc,TR,length(Gpexs));
%%
figure
mrireconstruct(S,kmax,'Plot',true);
%mrireconstruct(S1,kmax,'Plot',true);
title(['Reconstructed image with dw:',num2str(dw)]);
%% Comment this section if using the brain* functions
figure
imagesc(reshape(iv.Mz0,sqrt(size(iv.Mz0,2)),sqrt(size(iv.Mz0,2))));
title('Original Image');
colormap gray
