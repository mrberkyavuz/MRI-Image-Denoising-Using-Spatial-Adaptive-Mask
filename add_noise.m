input_dir = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI';
output_dir = 'C:\Users\Berk\Desktop\Business\KOU 24-25 Guz\Image Processing\Project\datasets\MRI_Noisy';

if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

images = dir(fullfile(input_dir, '*.png'));

for k = 1:length(images)
    img_path = fullfile(input_dir, images(k).name);
    img = imread(img_path);
    noisy_img = imnoise(img, 'salt & pepper', 0.1);
    save_path = fullfile(output_dir, sprintf('noisy_%s', images(k).name));
    imwrite(noisy_img, save_path);
end

disp('Completed');

