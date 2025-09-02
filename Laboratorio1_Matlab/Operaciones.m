% --- Crear carpeta para guardar resultados ---
output_folder = 'Resultados';
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% --- Cargar la imagen ---
img = imread('romboide-sucio.png');

%% --- Cambiar el tamaño de la imagen ---
resized_img = imresize(img, [400 400]); % 400x400 píxeles
imshow(resized_img);
title('Imagen Redimensionada');
imwrite(resized_img, fullfile(output_folder, 'resized_img.png'));

%% --- Obtener dimensiones de la imagen ---
[h, w, ~] = size(img);
center = [w/2, h/2];

% --- Rotar la imagen ---
rotated_img = imrotate(img, 45, 'bilinear', 'crop'); % Rotar 45°
imshow(rotated_img);
title('Imagen Rotada 45°');
imwrite(rotated_img, fullfile(output_folder, 'rotated_img.png'));

%% --- Operaciones aritméticas ---
img1 = imread('romboide-sucio.png');
img2 = imread('romboide-color.jpg');

% Asegurar que tengan el mismo tamaño
img2 = imresize(img2, [size(img1,1) size(img1,2)]);

sum_img  = imadd(img1, img2);
diff_img = imsubtract(img1, img2);
mult_img = immultiply(img1, img2);
div_img  = imdivide(im2double(img1), im2double(img2));

imwrite(sum_img,  fullfile(output_folder, 'suma.png'));
imwrite(diff_img, fullfile(output_folder, 'resta.png'));
imwrite(mult_img, fullfile(output_folder, 'multiplicacion.png'));
imwrite(mat2gray(div_img), fullfile(output_folder, 'division.png')); % normalización

%% --- Operaciones lógicas ---
img1_gray = rgb2gray(img1);
img2_gray = rgb2gray(img2);

img1_bin = imbinarize(img1_gray, 0.5);
img2_bin = imbinarize(img2_gray, 0.5);

and_img   = img1_bin & img2_bin;
or_img    = img1_bin | img2_bin;
not_img1  = ~img1_bin;
not_img2  = ~img2_bin;

imwrite(and_img,   fullfile(output_folder, 'and.png'));
imwrite(or_img,    fullfile(output_folder, 'or.png'));
imwrite(not_img1,  fullfile(output_folder, 'not_img1.png'));
imwrite(not_img2,  fullfile(output_folder, 'not_img2.png'));

%% --- Interpolación ---
resized_bilinear = imresize(img, [400 400], 'bilinear');
resized_nearest  = imresize(img, [400 400], 'nearest');

imwrite(resized_bilinear, fullfile(output_folder, 'interpolacion_bilineal.png'));
imwrite(resized_nearest,  fullfile(output_folder, 'interpolacion_vecino.png'));
