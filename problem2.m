clear all;
close all;
clc;

image = imread('hidden-symbols.tif');

% size of filter
n = 3;
m = 3;

[width, height] = size(image);

% finds out how much to pad using modulo
padsize_i = mod(width, n);
padsize_j = mod(height, m);

% replicate padding
output = padarray(image,[padsize_i, padsize_j],'replicate','both');

% increments by n step until width
for i = 1:n:width
    % increments by m step until height
    for j = 1:m:height
        i_new = i + n - 1;
        j_new = j + m - 1;
        
        % control the max exceed of the indexing step at the end
        if (i_new > width)
            i_new = width;
        end
        if (j_new > height)
            j_new = height;
        end
        
        % make a local image
        local = image(i:i_new, j:j_new);

        % histeq that local image
        local = histeq(local, 0:255);

        % output modification
        output(i:i_new, j:j_new) = local;
    end
end

% write
imwrite(output, 'problem2 3x3.bmp');
