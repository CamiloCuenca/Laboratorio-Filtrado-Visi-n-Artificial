clc;
clear all;

%% --- Crear carpeta para guardar resultados ---
output_folder = 'Resultados';
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

%% --- Cargar la imagen en escala de grises ---
image = imread('romboide-color.jpg');
if size(image,3) == 3
    image = rgb2gray(image); % Convertir a gris si está en color
end

figure('Name','Procesamiento de Imagen Médica');

% Mostrar imagen original
subplot(2,3,1);
imshow(image);
title('Imagen Original');
imwrite(image, fullfile(output_folder, 'original.png'));

% Preprocesamiento: binarización con umbral
binary_image = imbinarize(image, 127/255); % Normalizamos a [0,1]
imwrite(binary_image, fullfile(output_folder, 'binarizada.png'));

% Crear kernel (elemento estructurante)
se = strel('square', 7);

% Operación de apertura (elimina ruido)
opening = imopen(binary_image, se);
subplot(2,3,2);
imshow(opening);
title('Apertura');
imwrite(opening, fullfile(output_folder, 'apertura.png'));

% Operación de cierre (rellena huecos)
closing = imclose(opening, se);
subplot(2,3,3);
imshow(closing);
title('Cierre');
imwrite(closing, fullfile(output_folder, 'cierre.png'));

% Detección de contornos
[B,L] = bwboundaries(closing, 'noholes');
contour_image = label2rgb(L, @jet, [.5 .5 .5]);

subplot(2,3,4);
imshow(contour_image);
title('Contornos detectados');
imwrite(contour_image, fullfile(output_folder, 'contornos.png'));

% Extraer características geométricas (área y perímetro)
stats = regionprops(closing, 'Area', 'Perimeter');
areas = [stats.Area];
perimeters = [stats.Perimeter];

disp('Áreas de los objetos detectados:');
disp(areas);
disp('Perímetros de los objetos detectados:');
disp(perimeters);

% Mostrar imagen final
subplot(2,3,5);
imshow(closing);
title('Resultados finales');
imwrite(closing, fullfile(output_folder, 'final.png'));

% Gráfica de áreas y perímetros
subplot(2,3,6);
plot(areas, 'b-o','DisplayName','Áreas'); hold on;
plot(perimeters, 'r-s','DisplayName','Perímetros');
legend;
title('Características de los objetos');
xlabel('Objeto indexado');
ylabel('Valor');

% Guardar gráfica como imagen
saveas(gcf, fullfile(output_folder, 'grafica_caracteristicas.png'));
