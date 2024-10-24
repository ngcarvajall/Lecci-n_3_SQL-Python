/**
Ejercicios de prueba Lab
 
SELECT "name" , distance 
FROM lugares l 
WHERE distance >100

SELECT m.nombre, avg( a.temperatura) 
FROM aemet a 
JOIN municipios m ON a.id_municipio = m.id_municipio 
GROUP BY m.nombre 

SELECT m.nombre, c.cielo
FROM aemet a
JOIN municipios m ON a.id_municipio = m.id_municipio
JOIN cielo c ON a.id_cielo = c.id_cielo;

SELECT COUNT(*)
FROM aemet
WHERE id_avisos IS NOT NULL;

SELECT *
FROM lugares l
WHERE id_category = 4;
**/

-- 1.1. Calcula el promedio más bajo y más alto de temperatura.
SELECT avg(temperatura), fecha 
FROM aemet a 
GROUP BY fecha;

-- 1.2. Obtén los municipios en los cuales coincidan las medias de la sensación térmica y de la temperatura. 
SELECT avg(sen_termica_c) AS media_sensacion, avg(temperatura) AS media_temperatura, m."nombre"m, m."id_municipio"
FROM aemet a 
NATURAL JOIN municipios m 
GROUP BY m.id_municipio 
HAVING avg(sen_termica_c) = avg(temperatura);

-- 1.3. Obtén el local más cercano de cada municipio

SELECT l."name", l.id_municipio
FROM lugares l
INNER JOIN (
    SELECT MIN(l1.distance) AS distancia_minima, l1.id_municipio
    FROM lugares l1
    GROUP BY l1.id_municipio
) subquery ON l.id_municipio = subquery.id_municipio 
AND l.distance = subquery.distancia_minima;

-- 1.4. Localiza los municipios que posean algún localizador a una distancia mayor de 2000 y que posean al menos 25 locales.
SELECT id_municipio ,count(fsq_id) AS conteo_locales
FROM lugares l 
WHERE distance > 2000
GROUP BY id_municipio 
HAVING count(fsq_id) > 25; 

-- 1.5. Teniendo en cuenta que el viento se considera leve con una velocidad media de entre 6 y 20 km/h, moderado con una media de entre 21 y 40 km/h, fuerte con media de entre 41 y 70 km/h y muy fuerte entre 71 y 120 km/h. 
--Calcula cuántas rachas de cada tipo tenemos en cada uno de los días. 
--Este ejercicio debes solucionarlo con la sentencia CASE de SQL (no la hemos visto en clase, por lo que tendrás que buscar la documentación). 

SELECT 
    fecha,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 6 AND 20 THEN 1 
            ELSE NULL 
        END) AS viento_leve,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 21 AND 40 THEN 1 
            ELSE NULL 
        END) AS viento_moderado,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 41 AND 70 THEN 1 
            ELSE NULL 
        END) AS viento_fuerte,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 71 AND 120 THEN 1 
            ELSE NULL 
        END) AS viento_muy_fuerte
FROM aemet
GROUP BY fecha
ORDER BY fecha;

-- Ejercicios 2. Vistas

-- 2.1. Crea una vista que muestre la información de los locales que tengan incluido el código postal en su dirección. 
CREATE VIEW lugares_con_codigo AS 
SELECT * 
FROM lugares l
WHERE address LIKE '28%';

-- 2.2 Crea una vista con los locales que tienen más de una categoría asociada.

CREATE VIEW local_categorias
SELECT fsq_id , count(id_category) AS categorias_totales
FROM lugares l 
GROUP BY fsq_id
HAVING count(id_category) >1 ;

-- CREATE VIEW locales_multiples_categorias AS
SELECT fsq_id, name
FROM lugares
WHERE fsq_id IN (
    SELECT fsq_id
    FROM lugares
    GROUP BY fsq_id
    HAVING COUNT(id_category) > 1
);

-- 2.3. Crea una vista que muestre el municipio con la temperatura más alta de cada día

-- 2.4. Crea una vista con los municipios en los que haya una probabilidad de precipitación mayor del 100% durante mínimo 7 horas.

-- 2.5. Obtén una lista con los parques de los municipios que tengan algún castillo.