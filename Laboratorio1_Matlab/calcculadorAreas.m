clc;
clear all;

%% --- Crear carpeta para guardar resultados ---
output_folder = 'Resultados';
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

%% --- Lista de imágenes a procesar ---
imagenes = { ...
    'original.png', ...
    'binarizada.png', ...
    'apertura.png', ...
    'cierre.png', ...
    'contornos.png', ...
    'final.png'};

%% --- Inicializar tabla de resultados ---
resultados = table();

%% --- Procesar cada imagen ---
for i = 1:length(imagenes)
    img_path = fullfile(output_folder, imagenes{i});
    
    if exist(img_path, 'file')
        % Leer imagen
        img = imread(img_path);
        
        % Asegurarse que esté en escala de grises o binaria
        if size(img,3) == 3
            img = rgb2gray(img);
        end
        
        % Si ya es binaria (logical), no binarizar de nuevo
        if islogical(img)
            bin_img = img;
        else
            bin_img = imbinarize(img);
        end
        
        % Extraer propiedades geométricas
        stats = regionprops(bin_img, 'Area', 'Perimeter');
        
        % Guardar resultados en tabla
        for j = 1:length(stats)
            nueva_fila = {imagenes{i}, j, stats(j).Area, stats(j).Perimeter};
            resultados = [resultados; cell2table(nueva_fila)];
        end
    else
        warning('⚠️ No se encontró la imagen: %s', img_path);
    end
end

%% --- Nombrar columnas ---
resultados.Properties.VariableNames = {'Imagen','Objeto','Area','Perimetro'};

%% --- Guardar en Excel ---
excel_file = fullfile(output_folder, 'Resultados_Areas_Perimetros.xlsx');
writetable(resultados, excel_file);

disp('✅ Resultados guardados en:');
disp(excel_file);
