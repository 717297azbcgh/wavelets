clc; clear all; close all;
lenaimg = double(imread('flower.bmp')); % to read lena image

figure(1);
subplot(2,2,1);
imshow(lenaimg,[]);
title(' Original image')
axis on;

h_DB_high =[-0.48296 0.83652 -0.22414 -0.12941]; % Daubechies D2 high-pass filter for image
h_DB_low =[-0.12940 0.22414 0.83651 0.48296]; % Daubechies D2 high-pass filter for image

h_haar_high = [0.707 0.707]; %Haar high-pass filter for image
h = [-0.707 0.707]; %Haar high-pass filter for image



% WAVELET FOR IMAGE NOISE REDUCTION:
% Add white noise to the image:
mean = 0; % Mean
Variance = 20; %Sigma can vary from 2 to 20
%X noisy = Image + Gaussian white noise
lenanoise = double(lenaimg) + (mean + Variance * randn(size(lenaimg)));
subplot(2,2,2);
imshow(lenanoise,[]);
title(' Noisy Image ')
axis on;
%Wavelet transform:
level = 2; %Select the levels
wave_dec = multiwaveletdecomposition(lenanoise, h, level);

%Estimation of the noise level
noise_level=[wave_dec(129:256,1:128) wave_dec(129:256,129:256) wave_dec(1:128,129:256)];
Variance=median(abs(noise_level(:)))/0.6745;

threshold=10*Variance;

%hard-thresholding:
hthres=wave_dec.*((abs(wave_dec)>threshold));

%soft-thresholding:
sthres=(sign(wave_dec).*(abs(wave_dec)-threshold)).*((abs(wave_dec)>threshold));

%reconstruction for hard thresholding
imrech = multiwaveletreconstruction(hthres, h, level);
subplot(2,2,3);
imshow(imrech,[]);
title(' Hard Thresholding ')
axis on

%reconstruction for soft thresholding
imrecs = multiwaveletreconstruction(sthres, h, level);
subplot(2,2,4);
imshow(imrecs,[]);
title(' Soft Thresholding')
axis on
% A greater PSNR value indicates better image quality.
peaksnr_soft = psnr(imrecs,lenaimg)
peaksnr_hard = psnr(imrech,lenaimg)

%使用 ref 作为参考图像或三维体，计算灰度图像或三维体 A 的结构相似性 (SSIM) 索引。值越接近 1 表示图像质量越好。
ssimval_soft = ssim(imrecs,lenaimg)
ssimval_hard = ssim(imrech,lenaimg)

