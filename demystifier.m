%% Reading the image: size and channels
I = imread('starry_night.jpg');
%we read the image and find out it's size and number of channels
%this is always step 1 for finding out any mysteries in an image 
size(I);

%% Image cropping - eddies
% the image is cropped to sample the eddies that make up the most
% interesting part of the image 
I2 = imread('just_stars.jpg');
is = size(I2);
%cropping from the cropped image to use for feature extraction
% [feat, rect] = imcrop(I2);
% imwrite(feat,'small_feature.jpg');
I3 = imread('small_feature.jpg');

[I2r,I2g,I2b]=channelsplitter(I2);
[I3r,I3g,I3b]=channelsplitter(I3);
%% Image correlation

corr = real(ifft2(fft2(rgb2gray(I2)) .* fft2(rot90(rgb2gray(I3),2),is(1),is(2))));
figure
imshow(corr,[])

% Compute the correlation of the template image with the original image
% by rotating the template image by 180 degrees and then using the FFT-based convolution technique.
% (Convolution is equivalent to correlation if you rotate the convolution kernel by 180 degrees.)
% Multiplying the FT of one function by the
% complex conjugate of the FT of the other gives the
% FT of their correlation
% – This is the Correlation Theorem
% To match the template to the image, use the fft2 and ifft2 functions. 
% In the resulting image, bright peaks correspond to occurrences of the feature.

max(corr(:))

%% Thresholding of correlated image
% use a threshold that's a little less than max.
thresh =  max(corr(:))/1.5;
% display pixels with values over the threshold.
Td = corr > thresh;
se = strel('disk',5);
Tdil = imdilate(Td,se);
figure
imshow(Tdil,[]) 