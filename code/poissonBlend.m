function[im_blend] = poissonBlend(im_s, mask_s, im_background);
[imh,imw,nb]=size(im_s);
im2var=zeros(imh,imw);
im2var(1:imh*imw)=1:imh*imw;

%figure,imshow(im_s);
%title('ԭͼ');

%s=im;

%AΪϡ�����
n=imh*imw;
A=sparse(n);
b=zeros(1,3);

e=1

%X�����ݶ�
for y=2:imh-1
    for x=2:imw-1
        if mask_s(im2var(y,x))
            %���������ֵ
            if mask_s(im2var(y-1,x))
               A(e,im2var(y,x))=1;
               A(e,im2var(y-1,x))=-1;
               b(e,:)=im_s(y,x,:)-im_s(y-1,x,:);
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=im_s(y,x,:)-im_s(y-1,x,:)+im_background(y-1,x,:);
               e=e+1;
            end  
            %���������ֵ
            if mask_s(im2var(y+1,x))
               A(e,im2var(y,x))=1;
               A(e,im2var(y+1,x))=-1;
               b(e,:)=im_s(y,x,:)-im_s(y+1,x,:);
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=im_s(y,x,:)-im_s(y+1,x,:)+im_background(y+1,x,:);
               e=e+1;
            end 
            %���������ֵ
            if mask_s(im2var(y,x-1))
               A(e,im2var(y,x))=1;
               A(e,im2var(y,x-1))=-1;
               b(e,:)=im_s(y,x,:)-im_s(y,x-1,:);
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=im_s(y,x,:)-im_s(y,x-1,:)+im_background(y,x-1,:);
               e=e+1;
            end   
            %���������ֵ
            if mask_s(im2var(y,x+1))
               A(e,im2var(y,x))=1;
               A(e,im2var(y,x+1))=-1;
               b(e,:)=im_s(y,x,:)-im_s(y,x+1,:);
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=im_s(y,x,:)-im_s(y,x+1,:)+im_background(y,x+1,:);
               e=e+1;
            end 
%        else
%            A(e, im2var(y,x))=1;
%            b(e) = im_background(y,x); 
%            e=e+1;
        end
    end
end


%ʹ����С���˷����
%red=b(:,1);
%green=b(:,2);
%blue=b(:,3);



im_out=A\b;

%reshape��������im_outת����imh*imw����
im_blend(:,1)=reshape(im_out(:,1),imh,imw); 
%ind1=find(im_out(:,1));
%ind2=ind1+size(im_out,1);
%ind3=ind2+size(im_out,1);

%im_background(ind1)=im_out(ind1);
%im_background(ind1+imw*imh)=im_out(ind2);
%im_background(ind1+2*imw*imh)=im_out(ind3);
%im_blend=im_background;
%figure,imshow(im_blend);


