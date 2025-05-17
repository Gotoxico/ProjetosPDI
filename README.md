# ProjetosPDI

This project was developed as part of the **Digital Image Processing** course, in collaboration with **Kauan dos Santos Loche**.

The project is divided into three modules:

## 📁 Modules

### 1. `Aula03ConversorHSVtoRGBViceVersa`
A simple converter between HSV and RGB color models.

### 2. `Aula04AInterpolacaoNearestNeighborEBilinear`
Contains functions for image upscaling using the **Nearest Neighbor** and **Bilinear Interpolation** techniques.

### 3. `ProjetoPrincipalPDI`
This is the main project module, which includes the following functionalities:

- 🔄 Conversion from color to grayscale  
- 🖤 Negative transformation of grayscale images  
- 🌈 Negative transformation of color images  
- 🧪 Channel separation of color images  
- 🧂 Application of salt-and-pepper noise on grayscale images  
- 🧮 Application of a convolutional N8 filter using mean or median  
- 🧊 Noise filtering based on the mean of 10 images  
- 🗡️ Sobel magnitude calculation  
- ⚫ Binarization  
- 📊 Histogram equalization of grayscale images  
- 📉 Dynamic range compression  
- 💥 Laplacian N4 filter  
- 🚦 Thresholding (limiarização)  
- ➕ Image addition (primarily to enhance high frequencies)  

---

## ⚠️ Known Issues

- **HSV <-> RGB Conversion**  
  The output generally matches Microsoft Paint’s color converter, but occasionally, some parameters differ by 2 or 3 units for reasons yet unknown.

- **Negative of Grayscale**  
  When this function is used, the buffer may act unexpectedly and continue applying the result to other operations.  
  ✅ *Recommendation: Test this function and restart the application afterwards.*

- **Sobel Magnitude with `aula05-a.bmp`**  
  Before applying the Sobel magnitude function to this image, it **must** be converted to grayscale.  
  This is due to the Canvas’s static nature, which affects the algorithm.

---

## 🛠️ Technologies
- Free Pascal / Lazarus IDE  
- Custom image processing algorithms  

---

## 👥 Authors
- Kauan dos Santos Loche  
- Rodrigo Isao Goto
