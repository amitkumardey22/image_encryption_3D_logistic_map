clc;
clear all;
%3D chaotic map for image encryption
%3.53<l<3.81
%0<b<0.022
%0<a<0.015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% 3D CHAOS GENERATION CODE%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 x(1)=0.2350;
 y(1)=0.3500;
 z(1)=0.7350;
 a(1)=0.0125;
 b(1)=0.0157;
 l(1)=3.7700;
 image_height=256;
 for i=1:1:70000
     x(i+1)=l*x(i)*(1-x(i))+b*y(i)*y(i)*x(i)+a*z(i)*z(i)*z(i);
     y(i+1)=l*y(i)*(1-y(i))+b*z(i)*z(i)*y(i)+a*x(i)*x(i)*x(i);
     z(i+1)=l*z(i)*(1-z(i))+b*x(i)*x(i)*z(i)+a*y(i)*y(i);
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%histogram equalization and preparation for use%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 x=ceil(mod((x*100000),image_height));
 y=ceil(mod((y*100000),image_height));
 z=ceil(mod((z*100000),8));
 x1=unique(x,'stable');
 y1=unique(y,'stable');
 z1=unique(z,'stable');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%IMAGE INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
o=imread('iiest.jpeg');
o=rgb2gray(o);
original=o;
o=dec2bin(o,8);
bitimage=reshape(o,[256,256,8]);

o=[o(:)];
N=size(o,1);
A=bitimage;


for i=1:1:256
    for j=1:1:256
        for k=1:1:8
            A(x1(i),y1(j),z1(k))=bitimage(i,j,k);
        end;
    end;
end;
A=reshape(A,[65536,8]);

size(A);

r=bin2dec(A);

size(r);
encrypted_image = uint8(reshape(r,256,256,1));
size(encrypted_image);
figure
subplot(3,2,1)
imshow(original)
title('Original image');
subplot(3,2,2)
imhist(original);
title('Original image histogram');
subplot(3,2,3)
imshow(encrypted_image)
title('encrypted image');
subplot(3,2,4)
imhist(encrypted_image);
imwrite(encrypted_image, 'encrypted_image.jpg', 'Quality', 100);
title('Encrypted image histogram');

%%%%%%%%%%%%%%%%%%%%%% DECRYPTION %%%%%%%%%%%%%%%%%%%%%


        
encrypt=dec2bin(encrypted_image,8);
size(encrypt);
bitimage=reshape(encrypt,[256,256,8]);
A=bitimage;


for i=1:1:256
    for j=1:1:256
        for k=1:1:8
            A(i,j,k)=bitimage(x1(i),y1(j),z1(k));
        end;
    end;
end;
A=reshape(A,[65536,8]);

size(A);

r=bin2dec(A);

size(r);
d_image = uint8(reshape(r,256,256,1));
size(d_image);
subplot(3,2,5)
imshow(d_image)
title('decrypted image');
subplot(3,2,6)
imhist(d_image);
imwrite(d_image, 'decrypted_image.jpg', 'Quality', 100);
title('Decrypted image histogram');

