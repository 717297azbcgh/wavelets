x1=imread('flower.bmp');
figure(1);
subplot(2,2,1)
imshow(x1);
title('原图');


%添加噪声
x2=imread('NoiseImg.bmp');
x1=double(x1);
subplot(2,2,2);
imshow(x2);
title('加噪后');
x3=double(x2);



WAVELET_NAME = 'db2';
SORH_1 = 's';
[cA,cH,cV,cD] = dwt2(x3,WAVELET_NAME);
newCA = cA;
[THR,SORH,KEEPAPP]=ddencmp('den','wv',cH);%获取去噪过程中的默认阈值（软或硬）
newCH=wdencmp('gbl',cH,WAVELET_NAME,2,THR,SORH_1,KEEPAPP);
[THR,SORH,KEEPAPP]=ddencmp('den','wv',cV);%获取去噪过程中的默认阈值（软或硬）
newCV=wdencmp('gbl',cV,WAVELET_NAME,2,THR,SORH_1,KEEPAPP);%用全局阈值对图像去噪
[THR,SORH,KEEPAPP]=ddencmp('den','wv',cD);%获取去噪过程中的默认阈值（软或硬）
newCD=wdencmp('gbl',cD,WAVELET_NAME,2,THR,SORH_1,KEEPAPP);%用全局阈值对图像去噪


x4=idwt2(newCA,newCH,newCV,newCD,WAVELET_NAME);

subplot(2,2,3);
imshow(x4);
title('去噪后，软判决');

SORH_1 = 'h';
newCA = cA;
[THR,SORH,KEEPAPP]=ddencmp('den','wv',cH);%获取去噪过程中的默认阈值（软或硬）
newCH=wdencmp('gbl',cH,WAVELET_NAME,2,THR,SORH_1,KEEPAPP);
[THR,SORH,KEEPAPP]=ddencmp('den','wv',cV);%获取去噪过程中的默认阈值（软或硬）
newCV=wdencmp('gbl',cV,WAVELET_NAME,2,THR,SORH_1,KEEPAPP);%用全局阈值对图像去噪
[THR,SORH,KEEPAPP]=ddencmp('den','wv',cD);%获取去噪过程中的默认阈值（软或硬）
newCD=wdencmp('gbl',cD,WAVELET_NAME,2,THR,SORH_1,KEEPAPP);%用全局阈值对图像去噪


x5=idwt2(newCA,newCH,newCV,newCD,WAVELET_NAME);

subplot(2,2,4);
imshow(x5);
title('去噪后，硬判决');



