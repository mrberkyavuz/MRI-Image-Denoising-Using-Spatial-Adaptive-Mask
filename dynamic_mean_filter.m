input_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI_Noisy';
output_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Standart_Mean_Filtered';

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

    for x = 2:height-1
        for y = 2:width-1
            local_window = gray_img(x-1:x+1, y-1:y+1);
            mean_val = mean(local_window(:)); 
            output_img(x, y) = mean_val; 
        end
    end

    save_path = fullfile(output_folder, sprintf('standart_mean_filtered_%s', image_files(img).name));
    imwrite(output_img, save_path);
end

disp('Standard Mean Filter is done.');


