% starter script for project 3
DO_TOY = false;
DO_BLEND = false;
DO_MIXED  = false;
DO_COLOR2GRAY = true;

if DO_TOY 
    toyim = im2double(imread('./samples/toy_problem.png')); 
    % im_out should be approximately the same as toyim
    im_out = toy_reconstruct(toyim);
    disp(['Error: ' num2str(sqrt(sum(toyim(:)-im_out(:))))])
end

if DO_BLEND
    clc;
    clear;
   % im_background = imresize(im2double(imread('./samples/wall.jpg')), 0.5, 'bilinear');
  %  im_object = imresize(im2double(imread('./samples/font.jpg')), 0.5, 'bilinear');
 im_background = imresize(im2double(imread('./samples/im2.jpg')), 0.5, 'bilinear');
    im_object = imresize(im2double(imread('./samples/penguin-chick.jpeg')), 0.5, 'bilinear');
    % get source region mask from the user
    objmask = getMask(im_object);
    % align im_s and mask_s with im_background
    [im_s, mask_s] = alignSource(im_object, objmask, im_background);

    % blend
    im_blend = poissonBlend(im_s, mask_s, im_background);
    figure(3), hold off, imshow(im_blend)
end

if DO_MIXED
    clc;
    clear;
    im_bg = imresize(im2double(imread('./samples/wall.jpg')), 0.5, 'bilinear');
    im_object = imresize(im2double(imread('./samples/font.jpg')), 0.5, 'bilinear');

    % get source region mask from the user
    objmask = getMask(im_object);
    % align im_s and mask_s with im_background
    [im_s, mask_s] = alignSource(im_object, objmask, im_bg);

    im_blend = mixedBlend(im_s, mask_s, im_bg);
    figure(3), hold off, imshow(im_blend);
end

if DO_COLOR2GRAY
    im_rgb = im2double(imread('./samples/colorBlindTest35.png'));
%    im_gr = color2gray(im_rgb);
    [hus,s,v]=rgb2hsv(im_rgb);
    [r,c]=size(hus);
    hus=hus(2:r-1,2:c-1);
    s=s(2:r-1,2:c-1);
    mask=true(size(r-2,1),size(c-2,1));
    mask(:,c-2)=false;
    mask(1,:)=false;
    mask(:,1)=false;
    mask(r-2,:)=false;
    im_blend = mixedBlend1(hus, s, mask, v);
    im_blend1 = mixedBlend(hus, mask, v);
    figure(4), hold off, imshow(im_blend), axis image, colormap gray
    figure(5), hold off, imshow(im_blend1), axis image, colormap gray
end
