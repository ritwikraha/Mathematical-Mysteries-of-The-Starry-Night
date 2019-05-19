I = imread('starry_night.jpg');
%we read the image and find out it's size and number of channels
size(I);
red = I(:,:,1); % Red channel
green = I(:,:,2); % Green channel
blue = I(:,:,3); % Blue channel
black = zeros(size(I, 1), size(I, 2));
just_red = cat(3, red, black, black);
just_green = cat(3, black, green, black);
just_blue = cat(3, black, black, blue);

%%
I2 = imread('just_stars.jpg');
is = size(I2);
I3 = imresize(I,[is(1) is(2)]);

% [feat, rect] = imcrop(I2);
% imwrite(feat,'small_feature.jpg');

corr = real(ifft2(fft2(rgb2gray(I2)) .* fft2(rot90(rgb2gray(feat),2),is(1),is(2))));
figure
imshow(corr,[])

% Compute the correlation of the template image with the original image
% by rotating the template image by 180 degrees and then using the FFT-based convolution technique.
% (Convolution is equivalent to correlation if you rotate the convolution kernel by 180 degrees.) 
% To match the template to the image, use the fft2 and ifft2 functions. 
% In the resulting image, bright peaks correspond to occurrences of the feature.

max(corr(:))

thresh =  max(corr(:))/1.5; % Use a threshold that's a little less than max.
Td = corr > thresh;
se = strel('disk',5);
Tdil = imdilate(Td,se);
figure
imshow(Tdil) % Display pixels with values over the threshold.