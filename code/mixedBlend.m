function[im_blend]=mixedBlend(im_s, mask_s, im_bg)

[imh,imw,nb]=size(im_s);
im2var=zeros(imh,imw);
im2var(1:imh*imw)=1:imh*imw;


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
            
               d=max((im_s(y,x,:)-im_s(y-1,x,:)),(im_bg(y,x,:)-im_bg(y-1,x,:)));
               
            if mask_s(im2var(y-1,x))
               A(e,im2var(y,x))=1;
               A(e,im2var(y-1,x))=-1;
               b(e,:)=d;
               e=e+1;
            else
          %     d=max((im_s(y,x,:)-im_s(y-1,x,:)),(im_bg(y,x,:)-im_bg(y-1,x,:))); 
               A(e,im2var(y,x))=1;
               b(e,:)=d+im_bg(y-1,x,:);
               e=e+1;
            end  
            %���������ֵ
            
               d=max((im_s(y,x,:)-im_s(y+1,x,:)),(im_bg(y,x,:)-im_bg(y+1,x,:)));
               
            if mask_s(im2var(y+1,x))
               A(e,im2var(y,x))=1;
               A(e,im2var(y+1,x))=-1;
               b(e,:)=d;
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=d+im_bg(y+1,x,:);
               e=e+1;
            end 
            %���������ֵ
            
            d=max((im_s(y,x,:)-im_s(y,x-1,:)),(im_bg(y,x,:)-im_bg(y,x-1,:)));
            
            if mask_s(im2var(y,x-1))
               A(e,im2var(y,x))=1;
               A(e,im2var(y,x-1))=-1;
               b(e,:)=d;
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=d+im_bg(y,x-1,:);
               e=e+1;
            end   
            %���������ֵ
            
            d=max((im_s(y,x,:)-im_s(y,x+1,:)),(im_bg(y,x,:)-im_bg(y,x+1,:)));
            
            if mask_s(im2var(y,x+1))
               A(e,im2var(y,x))=1;
               A(e,im2var(y,x+1))=-1;
               b(e,:)=d;
               e=e+1;
            else
               A(e,im2var(y,x))=1;
               b(e,:)=d+im_bg(y,x+1,:);
               e=e+1;
            end 

        end
    end
end


im_out=A\b;

%reshape��������im_outת����imh*imw����

ind1=find(im_out(:,1));
ind2=ind1+size(im_out,1);
ind3=ind2+size(im_out,1);

im_bg(ind1)=im_out(ind1);
im_bg(ind1+imw*imh)=im_out(ind2);
im_bg(ind1+2*imw*imh)=im_out(ind3);
im_blend=im_bg;
%figure,imshow(im_blend);

function[d]=max(a,b)
if abs(a)>=abs(b)
    d=a;
else
    d=b;
end
