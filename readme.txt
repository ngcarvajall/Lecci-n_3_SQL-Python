# Laboratorio Módulo 4 - Lección 04: SQL

## Descripción del Laboratorio

Este laboratorio se enfoca en la práctica de consultas SQL utilizando una base de datos con varias tablas relacionadas. A lo largo del ejercicio, se realizarán consultas sobre las tablas `aemet`, `avisos`, `cielo`, `municipios`, `lugares` y `categorias` para comprender las relaciones entre ellas y extraer información relevante.

## Objetivo del Laboratorio

- Practicar consultas SQL utilizando `SELECT`, `JOIN`, `WHERE`, `GROUP BY` y otras cláusulas comunes.
- Explorar la base de datos para obtener información específica sobre las condiciones meteorológicas, municipios y lugares.
- Realizar análisis básicos y comprobaciones de integridad de datos.

## Requisitos Previos

1. Conocimientos básicos de SQL.
2. Familiaridad con las estructuras de bases de datos relacionales.
3. Instalación de un entorno de base de datos compatible con SQL (por ejemplo, DBeaver, PostgreSQL).

## Estructura de la Base de Datos

La base de datos utilizada en este laboratorio está compuesta por las siguientes tablas y relaciones:

- **aemet**: Contiene información sobre las condiciones meteorológicas, vinculada a `municipios`, `cielo`, y `avisos`.
- **avisos**: Registra alertas o avisos meteorológicos.
- **cielo**: Define las condiciones del cielo (por ejemplo, despejado, nublado).
- **municipios**: Contiene los datos de identificación y localización de municipios.
- **lugares**: Lugares específicos relacionados con municipios y categorías de sitios.
- **categorias**: Clasificación de los lugares (por ejemplo, restaurantes, parques).

## Ejercicios Propuestos

1. **Consulta Simple de AEMET**
   - **Consulta**: Extraer todas las entradas de la tabla `aemet` para la fecha más reciente.
   - **Respuesta Esperada**: Datos meteorológicos del día más reciente registrado.

2. **Join entre `aemet` y `municipios`**
   - **Consulta**: Obtener la temperatura y nombre del municipio, realizando un `JOIN` entre las tablas `aemet` y `municipios`.
   - **Respuesta Esperada**: Lista de temperaturas con el nombre del municipio correspondiente.

3. **Análisis de Precipitación**
   - **Consulta**: Contar cuántos registros de `aemet` tienen una probabilidad de precipitación mayor al 50%.
   - **Respuesta Esperada**: Número total de registros con alta probabilidad de lluvia.

4. **Relación entre `lugares` y `categorias`**
   - **Consulta**: Mostrar el nombre del lugar y su categoría utilizando un `JOIN` entre `lugares` y `categorias`.
   - **Respuesta Esperada**: Nombre del lugar junto a su categoría.

5. **Condiciones del Cielo**
   - **Consulta**: Obtener los municipios donde el cielo está completamente despejado (`id_cielo` correspondiente).
   - **Respuesta Esperada**: Nombres de municipios con cielo despejado.

## Instrucciones para Ejecutar

1. Cargar la base de datos proporcionada en el entorno de SQL.
2. Ejecutar las consultas propuestas en el editor de SQL.
3. Verificar que las respuestas coincidan con las soluciones esperadas.
4. Si es necesario, ajustar las consultas para corregir errores.

## Notas Adicionales

- Las consultas deben ser escritas utilizando las convenciones estándar de SQL.
- Se recomienda revisar la estructura de las tablas con `DESCRIBE` o `SHOW COLUMNS` para familiarizarse con los nombres de las columnas.

## Conclusión

Este laboratorio te ayudará a reforzar tus conocimientos en SQL, mejorar tu capacidad para trabajar con bases de datos relacionales y realizar análisis básicos sobre datos meteorológicos y geográficos.
