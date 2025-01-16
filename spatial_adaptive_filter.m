input_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI_Noisy';
output_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Spatial_Adaptive_Filtered_1';

if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

image_files = dir(fullfile(input_folder, '*.png'));

for img = 1:length(image_files)
    img_path = fullfile(input_folder, image_files(img).name);
    noisy_img = imread(img_path);
    
    if size(noisy_img, 3) == 3
        gray_img = rgb2gray(noisy_img);
    else
        gray_img = noisy_img;
    end

    [height, width] = size(gray_img);
    output_img = gray_img;

    for x = 4:height-3
        for y = 4:width-3
            local_window = gray_img(x-1:x+1, y-1:y+1);
            num_zeros_255 = sum(local_window(:) == 0 | local_window(:) == 255); %0 ve 255 olan değerleri ölçüyor
            
            if num_zeros_255 <= 4
                window_size = 3;
            elseif num_zeros_255 > 4 && num_zeros_255 <= 12
                window_size = 5;
            else
                window_size = 7;
            end
            
            half_window = floor(window_size / 2);
            x_start = max(x - half_window, 1);
            x_end = min(x + half_window, height);
            y_start = max(y - half_window, 1);
            y_end = min(y + half_window, width);
            
            adaptive_window = gray_img(x_start:x_end, y_start:y_end);
            median_val = median(adaptive_window(:));
            output_img(x, y) = median_val;
        end
    end

    save_path = fullfile(output_folder, sprintf('spatial_adaptive_filtered_%s', image_files(img).name));
    imwrite(output_img, save_path);
end

disp('Spatial Adaptive Mask Filter is done.');
