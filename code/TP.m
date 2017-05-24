%%

imLc = imread('tsukuba/imL.png');
imRc = imread('tsukuba/imR.png');
imL = rgb2gray(imLc);
imR = rgb2gray(imRc);

lambda = 1;

 [disparity, energy] = stereo_belief_propagation(imL, imR, lambda);

 figure(1);
 plot(energy);
