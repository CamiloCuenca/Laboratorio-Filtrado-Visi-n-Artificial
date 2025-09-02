clc;
clear all;

%% --- Crear carpeta para guardar resultados ---
output_folder = 'Resultados';
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

%% --- Cargar imagen ---
img = imread('romboide-color.jpg'); % Cambia por tu imagen
img_gray = rgb2gray(img); % Convertir a escala de grises

figure;
imshow(img_gray);
title('Imagen Original en Escala de Grises');
imwrite(img_gray, fullfile(output_folder, 'img_gray.png'));

%% --- Filtro Promedio (Media) ---
filtro_promedio = fspecial('average', [5 5]); % Máscara 5x5
img_promedio = imfilter(img_gray, filtro_promedio);

figure;
imshow(img_promedio);
title('Filtro Promedio (Suavizado)');
imwrite(img_promedio, fullfile(output_folder, 'filtro_promedio.png'));

%% --- Filtro Gaussiano ---
filtro_gauss = fspecial('gaussian', [5 5], 1); % sigma=1
img_gauss = imfilter(img_gray, filtro_gauss);

figure;
imshow(img_gauss);
title('Filtro Gaussiano (Suavizado)');
imwrite(img_gauss, fullfile(output_folder, 'filtro_gaussiano.png'));

%% --- Filtro Mediana ---
img_mediana = medfilt2(img_gray, [5 5]);

figure;
imshow(img_mediana);
title('Filtro de Mediana (Reduce Ruido Sal y Pimienta)');
imwrite(img_mediana, fullfile(output_folder, 'filtro_mediana.png'));

%% --- Filtro de Sobel (Detección de Bordes) ---
filtro_sobel = fspecial('sobel');
img_sobel_x = imfilter(double(img_gray), filtro_sobel);
img_sobel_y = imfilter(double(img_gray), filtro_sobel');

% Magnitud del gradiente
img_sobel = sqrt(img_sobel_x.^2 + img_sobel_y.^2);

figure;
imshow(uint8(img_sobel));
title('Filtro Sobel (Bordes)');
imwrite(uint8(img_sobel), fullfile(output_folder, 'filtro_sobel.png'));

%% --- Filtro Laplaciano (Realce de Bordes) ---
filtro_lap = fspecial('laplacian', 0.2);
img_lap = imfilter(double(img_gray), filtro_lap);

figure;
imshow(uint8(img_lap + double(img_gray)));
title('Filtro Laplaciano (Realce de Bordes)');
imwrite(uint8(img_lap + double(img_gray)), fullfile(output_folder, 'filtro_laplaciano.png'));

%% --- Filtro High-Boost (Realce de Detalles) ---
A = 1.5; % Factor de realce
img_suavizada = imfilter(double(img_gray), filtro_gauss);
img_highboost = double(img_gray) - img_suavizada;
img_highboost = double(img_gray) + A * img_highboost;

figure;
imshow(uint8(img_highboost));
title('Filtro High-Boost (Realce)');
imwrite(uint8(img_highboost), fullfile(output_folder, 'filtro_highboost.png'));
