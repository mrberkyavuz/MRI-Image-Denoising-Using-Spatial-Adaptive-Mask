input_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI_Noisy';
output_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Adaptive_Median_Filtered';

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
            window_size = 3;
            max_window_size = 7;
            adaptive_done = false;

            while ~adaptive_done
                half_window = floor(window_size / 2); % merkez ile kenarlar arasındaki mesafe
                x_start = max(x - half_window, 1);
                x_end = min(x + half_window, height);
                y_start = max(y - half_window, 1);
                y_end = min(y + half_window, width);
                
                local_window = gray_img(x_start:x_end, y_start:y_end);
                min_val = min(local_window(:));
                max_val = max(local_window(:));
                median_val = median(local_window(:));
                current_pixel = gray_img(x, y);

                if median_val > min_val && median_val < max_val % median değeri minimum ve maksimum arasında ise geçerlidir.
                    if current_pixel > min_val && current_pixel < max_val
                        output_img(x, y) = current_pixel; % merkezi piksel geçerli bir değerse
                    else
                        output_img(x, y) = median_val;
                    end
                    adaptive_done = true;
                else
                    window_size = window_size + 2;
                    if window_size > max_window_size
                        output_img(x, y) = median_val;
                        adaptive_done = true;
                    end
                end
            end
        end
    end

    save_path = fullfile(output_folder, sprintf('adaptive_median_filtered_%s', image_files(img).name));
    imwrite(output_img, save_path);
end

disp('Adaptive Median Filter is done');


