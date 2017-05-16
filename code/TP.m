%%

imLc = imread('tsukuba/imL.png');
imRc = imread('tsukuba/imR.png');
imL = rgb2gray(imLc);
imR = rgb2gray(imRc);

lambda = 10;

 [disparity, energy] = stereo_belief_propagation(imL, imR, lambda);
 
 
 %% Debug
 img_right = imR;
 img_left = imL;
tau             = 15; 
num_iterations  = 60; % number of iterations
[height, width] = size(img_left);



