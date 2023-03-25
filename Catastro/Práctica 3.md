# Práctica 3
## Unimos los dos ficheros .CAT
Para ello en el cmd nos vamos a la ruta donde está los .CAT con 
```cmd
copy nombreFichero1.CAT+nombreFichero2.CAT nombreFicheroResultante.CAT 
```

## Unión de tablas
* Tipo 11: Registro de Finca. Existirá uno por cada parcela catastral implicada.
* Tipo 13: Registro de Unidad Constructiva. Existirá uno por cada unidad constructiva en cada
parcela catastral.
* Tipo 14: Registro de Construcción. Existirá uno por cada construcción de cada unidad constructiva en cada parcela catastral 

Usamos el siguiente SQL para crear las tablas:
``` sql
-- Si la base de datos ya existe, eliminarla
--DROP DATABASE IF EXISTS catastro;

--CREATE DATABASE catastro;

DROP TABLE IF EXISTS cat_tipo11;
CREATE TABLE IF NOT EXISTS cat_tipo11 (
  --id SERIAL,
  tipo INTEGER,
  prov INTEGER,
  mun INTEGER,
  refcat VARCHAR(14),
  provine INTEGER,
  provincia VARCHAR(25),
  mundgc INTEGER,
  munine INTEGER,
  municipio VARCHAR(40),
  entidad VARCHAR(30),
  codvia INTEGER,
  tipovia VARCHAR(5),
  nomvia VARCHAR(25),
  ndp INTEGER,
  letra char(1),
  ndp2 INTEGER,
  letra2 char(1),
  km INTEGER,
  bloque VARCHAR(4),
  direccione VARCHAR(25),
  cp INTEGER,
  distrito VARCHAR(2),
  munorigen INTEGER,
  zonaconcentracion INTEGER,
  poligono INTEGER,
  parcela INTEGER,
  paraje VARCHAR(5),
  nomparaje VARCHAR(30),
  superficie BIGINT,
  supconstruida INTEGER,
  supconssr INTEGER,
  supconsbr INTEGER,
  supcubiert INTEGER,
  x	BIGINT,
  y BIGINT,
  refcatbice VARCHAR(20),
  nombrebice VARCHAR(65),
  srs VARCHAR(10)
);

COPY cat_tipo11 FROM 'D:\GENILDA\PRACTICA3\resultado\CAT_tipo11.csv' DELIMITER ';' CSV HEADER;

--select * from cat_tipo11

ALTER TABLE cat_tipo11 ADD COLUMN id serial;

DELETE FROM cat_tipo11 WHERE Id NOT IN (
SELECT
            min(id)
FROM  cat_tipo11
GROUP BY refcat);

--	Se eliminarán los atributos del tipo SERIAL definidos en las tablas Tipo11 y Tipo14.
ALTER TABLE cat_tipo11 DROP COLUMN id;

--select * from cat_tipo11


DROP TABLE IF EXISTS cat_tipo13;



CREATE TABLE IF NOT EXISTS cat_tipo13 (
  tipo	INTEGER,
  prov	INTEGER,
  mun	INTEGER,
  clase	VARCHAR(2),
  refcat VARCHAR(14),
  uc VARCHAR(4)	,
  provine	INTEGER,
  provincia	VARCHAR(25),
  mundgc	INTEGER,
  munine	INTEGER,
  municipio	VARCHAR(40),
  entidad	VARCHAR(30),
  codvia	INTEGER,
  tipovia	VARCHAR(5),
  nombrevia	VARCHAR(25),
  ndp	INTEGER,
  letra	VARCHAR(1),
  ndp2	INTEGER,
  letra2	VARCHAR(1),
  km	INTEGER,
  direccionne	VARCHAR(25),
  anyoconstr	INTEGER,
  exactituda	VARCHAR(1),
  superficie	INTEGER,
  longitudfa	INTEGER

);


COPY cat_tipo13 FROM 'D:\GENILDA\PRACTICA3\resultado\CAT_tipo13.csv' DELIMITER ';' CSV HEADER;




ALTER TABLE cat_tipo13 ADD COLUMN id serial;

DELETE FROM cat_tipo13 WHERE Id NOT IN (
SELECT
            min (id)
FROM  cat_tipo13
GROUP BY (refcat,uc));

--	Tipo 13 posee una clave primaria compuesta por los atributos referencia catastral y unidad constructiva
ALTER TABLE cat_tipo13 ADD PRIMARY KEY (refcat, uc);



DROP TABLE IF EXISTS cat_tipo14;

CREATE TABLE IF NOT EXISTS cat_tipo14 (
  cod VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL
);

DROP TABLE IF EXISTS cat_tipo_reforma;

CREATE TABLE IF NOT EXISTS cat_tipo_reforma (
  cod char(1),
  descripcion VARCHAR(200) 
);

DROP TABLE IF EXISTS cat_cod_destino_construccion;

--Tamano de 10 como dice el enunciado
CREATE TABLE IF NOT EXISTS cat_cod_destino_construccion (
  cod_destino char(10), 
  descripcion VARCHAR(200) 
);

---
--SELECT * FROM cat_cod_destino_construccion
---
COPY cat_cod_destino_construccion FROM 'D:\GENILDA\PRACTICA3\P03.02\documentacion\Destinos.csv' DELIMITER ';' CSV HEADER;
```