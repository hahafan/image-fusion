function[im_out] = toy_reconstruct(im);

[imh,imw,nb]=size(im);
im2var=zeros(imh,imw);
im2var(1:imh*imw)=1:imh*imw;

figure,imshow(im);
title('原图');

s=im;

%A为稀疏矩阵
n=imh*imw;
A=sparse(2*n-1);
b=zeros(n,1);
e=1;


%X方向梯度,Object 1.
for y=1:imh
    for x=1:imw-1
        A(e, im2var(y,x+1))=1;
        A(e, im2var(y,x))=-1;
        b(e) = s(y,x+1)-s(y,x); 
        e=e+1;
    end
end


%Y方向梯度，Object 2
for x=1:imw
    for y=1:imh-1
        A(e, im2var(y+1,x))=1;
        A(e, im2var(y,x))=-1;
        b(e) = s(y+1,x)-s(y,x);
        e=e+1;
    end
end

%Object 3

A(e,im2var(1,1))=1;
b(e)=s(1,1);


%使用最小二乘法求解
im_out=A\b;

%reshape将列向量im_out转换成imh*imw矩阵
im_out=reshape(im_out,imh,imw); 
figure,imshow(im_out);
title('重建图');

