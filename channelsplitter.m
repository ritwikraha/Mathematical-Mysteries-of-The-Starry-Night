function [r,g,b]= channelsplitter(I)
red = I(:,:,1); % Red channel
green = I(:,:,2); % Green channel
blue = I(:,:,3); % Blue channel
black = zeros(size(I, 1), size(I, 2));
r = cat(3, red, black, black);
g = cat(3, black, green, black);
b = cat(3, black, black, blue);
end
