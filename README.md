# An Improved Image Denoising Using Spatial Adaptive Mask Filter for Medical Images

This MATLAB project implements a **Spatial Adaptive Mask Filter** to reduce salt and pepper noise in medical images, particularly MRI images. The proposed algorithm improves image quality by adapting the filtering process to the local characteristics of the image, ensuring noise removal while preserving critical details like edges.

---

## Methodology

The project compares six filtering approaches for denoising medical images:
1. **Noisy Input**: Original image with salt and pepper noise.
2. **Mean Filter**: Uses the mean value of neighboring pixels for smoothing.
3. **Median Filter**: Replaces each pixel with the median of its neighborhood.
4. **Adaptive Median Filter**: Dynamically adjusts the filtering mask size.
5. **Spatial Adaptive Mask Filter**: Uses a multi-threshold mechanism to determine the mask size based on the number of noisy pixels in a block.
6. **Proposed System**: A refined version of the Spatial Adaptive Mask Filter that further enhances noise removal and preserves details.

---

## Features

- **Adaptive Filtering**: Dynamically adjusts the mask size (3×3, 5×5, or 7×7) based on the local noise density.
- **Noise Classification**: Identifies noisy pixels (0 and 255) and applies targeted filtering.
- **Multi-Threshold Mechanism**: Determines the optimal window size for each pixel.
- **Improved PSNR and MSE**: Demonstrates better Peak Signal-to-Noise Ratio (PSNR) and Mean Square Error (MSE) compared to other methods.

---

## Results

Six outputs are generated for comparison:
1. **Noisy Input Image**
2. **Mean Filter Output**
3. **Median Filter Output**
4. **Adaptive Median Filter Output**
5. **Spatial Adaptive Mask Filter Output**
6. **Proposed System Output**

### Sample Outputs (MRI Images)

| **Image Type**                  | **Description**                      |
|---------------------------------|--------------------------------------|
| **Noisy Input**                 | Original image with salt and pepper noise |
| **Mean Filter Output**          | Smoothens noise but blurs edges      |
| **Median Filter Output**        | Reduces noise while preserving edges |
| **Adaptive Median Filter Output** | Dynamically adjusts mask size for noise removal |
| **Spatial Adaptive Mask Filter Output** | Employs multi-threshold for adaptive noise reduction |
| **Proposed System Output**      | Enhances detail preservation and noise removal |

---

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repository-name
   ```
2. **Prepare Dataset**:
   - Place noisy MRI images in the `datasets/MRI_Noisy` folder.

3. **Run the Script**:
   - Open MATLAB and execute the provided script:
     ```matlab
     run AdaptiveMedianFilter.m
     ```
4. **View Results**:
   - Processed images are saved in the `datasets/Proposed_Filtered` folder.

---

## Requirements

- MATLAB (R2018 or later)
- Image Processing Toolbox

---
