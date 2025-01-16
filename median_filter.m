input_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI_Noisy';
output_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI_Processed';

if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

image_files = dir(fullfile(input_folder, '*.png'));

for i = 1:length(image_files)
    image_path = fullfile(input_folder, image_files(i).name);
    noisy_image = imread(image_path);
    
    if size(noisy_image, 3) == 3
        gray_image = rgb2gray(noisy_image);
    else
        gray_image = noisy_image;
    end

    [rows, cols] = size(gray_image);
    processed_image = gray_image; 

    for r = 2:rows-1
        for c = 2:cols-1
            window = gray_image(r-1:r+1, c-1:c+1); 

            if all(window(:) == 0) || all(window(:) == 255)
                mean_val = mean(window(:)); 
                processed_image(r, c) = mean_val;
            else
                valid_elements = window(window > 0 & window < 255);
                if ~isempty(valid_elements)
                    median_val = median(valid_elements); 
                    processed_image(r, c) = median_val;
                end
            end
        end
    end

    output_path = fullfile(output_folder, sprintf('processed_%s', image_files(i).name));
    imwrite(processed_image, output_path);
end

disp('median done.');
