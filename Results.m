mean_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Standart_Mean_Filtered';
median_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Standart_Median_Filtered';
adaptive_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Adaptive_Median_Filtered';
spatial_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Spatial_Adaptive_Filtered_1';
proposed_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Proposed_Out';
proposed_v1_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\Proposed_v1';
reference_folder = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI';

image_files = dir(fullfile(mean_folder, '*.png'));
image_files = image_files(1:10);

noise_levels = 0.1:0.1:1.0;

mse_values = zeros(10, 8);
psnr_values = zeros(10, 8);

for i = 1:10
    base_name = image_files(i).name;
    base_name = erase(base_name, 'standart_mean_filtered_noisy_');
    base_name = erase(base_name, '.png');

    % Referans görüntüyü okuyun
    reference_img = imread(fullfile(reference_folder, strcat(base_name, '.png')));

    % Diğer filtrelenmiş görüntüleri okuyun
    mean_img = imread(fullfile(mean_folder, strcat('standart_mean_filtered_noisy_', base_name, '.png')));
    median_img = imread(fullfile(median_folder, strcat('standart_median_filtered_noisy_', base_name, '.png')));
    adaptive_img = imread(fullfile(adaptive_folder, strcat('adaptive_median_filtered_noisy_', base_name, '.png')));
    spatial_img = imread(fullfile(spatial_folder, strcat('spatial_adaptive_filtered_noisy_', base_name, '.png')));
    proposed_img = imread(fullfile(proposed_folder, strcat('proposed_noisy_', base_name, '.png')));
    proposed_v1_img = imread(fullfile(proposed_v1_folder, strcat('spatial_adaptive_filtered_noisy_', base_name, '.png')));

    % Görselleri normalize edin
    reference_img = double(reference_img) / 255;
    mean_img = double(mean_img) / 255;
    median_img = double(median_img) / 255;
    adaptive_img = double(adaptive_img) / 255;
    spatial_img = double(spatial_img) / 255;
    proposed_img = double(proposed_img) / 255;
    proposed_v1_img = double(proposed_v1_img) / 255;

    % MSE hesaplamaları
    mse_values(i, 1) = i; % Image number
    mse_values(i, 2) = noise_levels(i); % Noise level
    mse_values(i, 3) = mean(mean((reference_img - mean_img).^2, 'all')); % Mean filter MSE
    mse_values(i, 4) = mean(mean((reference_img - median_img).^2, 'all')); % Median filter MSE
    mse_values(i, 5) = mean(mean((reference_img - adaptive_img).^2, 'all')); % Adaptive Median MSE
    mse_values(i, 6) = mean(mean((reference_img - spatial_img).^2, 'all')); % Spatial Adaptive MSE
    mse_values(i, 7) = mean(mean((reference_img - proposed_img).^2, 'all')); % Proposed Method MSE
    mse_values(i, 8) = mean(mean((reference_img - proposed_v1_img).^2, 'all')); % Proposed v1 Method MSE

    % PSNR hesaplamaları
    psnr_values(i, 1) = i; % Image number
    psnr_values(i, 2) = noise_levels(i); % Noise level
    psnr_values(i, 3) = 10 * log10((255^2) / mse_values(i, 3)); % Mean filter PSNR
    psnr_values(i, 4) = 10 * log10((255^2) / mse_values(i, 4)); % Median filter PSNR
    psnr_values(i, 5) = 10 * log10((255^2) / mse_values(i, 5)); % Adaptive Median PSNR
    psnr_values(i, 6) = 10 * log10((255^2) / mse_values(i, 6)); % Spatial Adaptive PSNR
    psnr_values(i, 7) = 10 * log10((255^2) / mse_values(i, 7)); % Proposed Method PSNR
    psnr_values(i, 8) = 10 * log10((255^2) / mse_values(i, 8)); % Proposed v1 Method PSNR
end

mse_table = array2table(mse_values, ...
    'VariableNames', {'Image_No', 'Noise_Level', 'Mean_Filter', 'Median_Filter', 'Adaptive_Median', 'Spatial_Adaptive_Filter', 'Proposed_Method', 'Proposed_v1_Method'});

psnr_table = array2table(psnr_values, ...
    'VariableNames', {'Image_No', 'Noise_Level', 'Mean_Filter', 'Median_Filter', 'Adaptive_Median', 'Spatial_Adaptive_Filter', 'Proposed_Method', 'Proposed_v1_Method'});

disp('MSE Values:');
disp(mse_table);

disp('PSNR Values:');
disp(psnr_table);

writetable(mse_table, 'mse_results.csv');
writetable(psnr_table, 'psnr_results.csv');



