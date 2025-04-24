# ProjetosPDI
Project developed inside the Course of Digital Image Processing, in partnership with Kauan dos Santos Loche. It is separated in three modules, the first one (Aula03ConversorHSVtoRGBVIceVersa) is only a converter from HSV to RGB and vice-versa, the second one (Aula04AInterpolacaoNearestNeighborEBilinear) has only the functions to interpolate (upscalle) an image using the two techniques described at the title, but the third one (ProjetoPrincipalPDI) has this list of functions:
- Converting colorful to grayscale;
- Negative of grayscale;
- Negative of coloful;
- Separation of channels on a coloful picture;
- Applying of salt and pepper noise on grayscale;
- Applying of a convolutional filter N8 using mean or median;
- Filtering of noise based on the mean of 10 images;
- Sobel`s magnitude;
- Binering;
- Equalization of an image through grayscale histogram equalization;
- Dynamic compression;
- Laplacian N4;
- Limiaring;
- Adding of images (Mostly to enhance high frequencies).

Known issues:
- On the HSV to RGB and vice versa converter, most of the times the results are aligned with Microsoft`s Paint own converter, but sometimes, and at times the developing team could not identify, it diverges by 2 or even 3 scales in some parameter;
- Whenever the function Negative of grayscale is used the buffer goes crazy and starts resending the result of that operation to other operations (Recommended to test Negative of grayscale and restart the application);
- When using image (aula05-a.bmp) to test Sobel`s magnitude it is mandatory to put it in grayscale first, due to the nature of the Canvas not being dynamic affecting the algorithm.
