DROP TABLE municipios 

SELECT *
FROM municipios m 

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