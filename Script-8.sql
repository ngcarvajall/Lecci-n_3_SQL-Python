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

SELECT l."name", l.id_municipio, distance 
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
        END) AS viento_leve,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 21 AND 40 THEN 1 
        END) AS viento_moderado,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 41 AND 70 THEN 1 
        END) AS viento_fuerte,
    COUNT(CASE 
            WHEN racha_max_kmh BETWEEN 71 AND 120 THEN 1 
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

CREATE VIEW local_categorias as
SELECT fsq_id , count(id_category) AS categorias_totales
FROM lugares l 
GROUP BY fsq_id
HAVING count(id_category) >1 ;

-- 2.3. Crea una vista que muestre el municipio con la temperatura más alta de cada día
CREATE VIEW temperatura_maxima AS
SELECT a.fecha, m.nombre AS nombre_municipio, a.temperatura
FROM aemet a 
NATURAL JOIN municipios m 
WHERE a.temperatura = (
		SELECT max(temperatura)
		FROM aemet a2
		WHERE a2.fecha = a.fecha
		);

/** SELECT fecha, MAX(temperatura) AS temperatura_max
FROM aemet a 
GROUP BY fecha;
**/


-- 2.4. Crea una vista con los municipios en los que haya una probabilidad de precipitación mayor del 100% durante mínimo 7 horas.
SELECT *
FROM aemet a 
WHERE CAST (prob_precip_ AS integer) = 95;

/**
 * creo que el case para crear la condicion, ya que al tener nulos no puedo trabajar con int.
 * uso la expresion regular para que verifique que debe de haber al inicio un numero, entre 1 y 9, seguido de uno o mas y que luego termine.
 */
SELECT *
FROM aemet a 
WHERE 
    CASE 
        WHEN prob_precip_ ~ '^[0-9]+$' THEN CAST(prob_precip_ AS INTEGER)
        ELSE NULL
    END > 95;

/**SELECT 
    a.id_municipio,
    m.nombre AS municipio,
    COUNT(*) AS dias_con_prob_95
FROM 
    aemet a
JOIN 
    municipios m ON a.id_municipio = m.id_municipio
WHERE 
    CASE 
        WHEN prob_precip_ ~ '^[0-9]+$' THEN CAST(prob_precip_ AS INTEGER)
        ELSE NULL
    END = 95
GROUP BY 
    a.id_municipio, m.nombre
HAVING 
    COUNT(*) >= 7;
**/
-- 2.5. Obtén una lista con los parques de los municipios que tengan algún castillo.
CREATE VIEW ParqueCastillo AS
SELECT l.name
FROM municipios m 
INNER JOIN lugares l 
		ON l.id_municipio = m.id_municipio 
INNER JOIN categorias c  
		ON l.id_category = c.id_categoria 
WHERE c.category LIKE 'Castle' AND c.category LIKE 'Park'

SELECT *
FROM categorias c 
--3.1. Crea una tabla temporal que muestre cuántos días han pasado desde que se obtuvo la información de la tabla AEMET.

--3.2. Crea una tabla temporal que muestre los locales que tienen más de una categoría asociada e indica el conteo de las mismas

-- 3.3. Crea una tabla temporal que muestre los tipos de cielo para los cuales la probabilidad de precipitación mínima de los promedios de cada día es 5.

-- 3.4. Crea una tabla temporal que muestre el tipo de cielo más y menos repetido por municipio.
   
-- 4.1. Necesitamos comprobar si hay algún municipio en el cual no tenga ningún local registrado.
SELECT 
    nombre AS municipio
FROM 
    municipios m
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM lugares l
        WHERE l.id_municipio = m.id_municipio
    );

-- 4.2. Averigua si hay alguna fecha en la que el cielo se encuente "Muy nuboso con tormenta".
SELECT * FROM (SELECT a.fecha, c.cielo AS estado_del_cielo
FROM cielo c 
INNER JOIN aemet a 
ON c.id_cielo = a.id_cielo) AS estado_dia
WHERE estado_del_cielo LIKE 'Muy nuboso con tormenta';
-- 4.3. Encuentra los días en los que los avisos sean diferentes a "Sin riesgo".
SELECT fecha, avisos, id_municipio FROM (
SELECT *
FROM avisos a 
INNER JOIN aemet a2 
ON a.id_avisos = a2.id_avisos) AS info_meteorologica
WHERE avisos = 'Riesgo'
;

-- 4.4. Selecciona el municipio con mayor número de locales.
SELECT * FROM (SELECT m.nombre, count(fsq_id) AS total_locales
FROM municipios m 
NATURAL JOIN lugares l 
GROUP BY m.nombre ) AS numero_locales_municipio
ORDER BY total_locales DESC 
LIMIT 1;
-- 4.5. Obtén los municipios muya media de sensación térmica sea mayor que la media total.
SELECT nombre, promedio_sens FROM (SELECT avg(sen_termica_c) AS promedio_sens, m.nombre
FROM municipios m 
INNER JOIN aemet a
ON m.id_municipio = a.id_municipio 
GROUP BY m.id_municipio) AS avg_sens_termi_mun
WHERE promedio_sens > (SELECT avg(a2.sen_termica_c) AS promedio_temp
						FROM aemet a2) ;
-- 4.6. Selecciona los municipios con más de dos fuentes.

-- 4.7. Localiza la dirección de todos los estudios de cine que estén abiertod en el municipio de "Madrid".

-- 4.8. Encuentra la máxima temperatura para cada tipo de cielo.

-- 4.9. Muestra el número de locales por categoría que muy probablemente se encuentren abiertos.