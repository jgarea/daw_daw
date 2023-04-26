ALTER TABLE cat_tipo14 DROP CONSTRAINT IF EXISTS fk_cat_tipo13; 
ALTER TABLE cat_tipo14 DROP CONSTRAINT IF EXISTS fk_cat_tipo14_destino;
ALTER TABLE cat_tipo14 DROP CONSTRAINT IF EXISTS fk_cat_tipo13_2;
ALTER TABLE cat_tipo14 DROP CONSTRAINT IF EXISTS fk_cat_tipo14_reforma;
ALTER TABLE cat_tipo13 DROP CONSTRAINT IF EXISTS fk_cat_tipo11;

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
ALTER TABLE cat_tipo11 ADD COLUMN id serial;

DELETE FROM cat_tipo11 WHERE Id NOT IN (
SELECT
            min(id)
FROM  cat_tipo11
GROUP BY refcat);

ALTER TABLE cat_tipo11 DROP COLUMN id;

ALTER TABLE cat_tipo11 ADD PRIMARY KEY (refcat);

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
ALTER TABLE cat_tipo13 DROP COLUMN id;



DROP TABLE IF EXISTS cat_tipo14;

CREATE TABLE IF NOT EXISTS cat_tipo14 (
  	tipo INTEGER,
	prov INTEGER,
	mun INTEGER,
	refcat VARCHAR(14),
	orden INTEGER,
	cargo VARCHAR(4),
	uc VARCHAR(4),
	bloque VARCHAR(4),
	escalera VARCHAR(2),
	planta VARCHAR(10),
	puerta VARCHAR(10),
	destino VARCHAR(3),
	tipo_refor VARCHAR(1),
	anyo_refor INTEGER,
	anyo_ant INTEGER,
	local_interior VARCHAR(1),
	sup_total INTEGER,
	sup_porche_terraza INTEGER,
	sup_otras_plantas INTEGER,
	tipologia VARCHAR(5),
	modo_reparto VARCHAR(3)

);

COPY cat_tipo14 FROM 'D:\GENILDA\PRACTICA3\resultado\CAT_tipo14.csv' DELIMITER ';' CSV HEADER;

--ALTER TABLE cat_tipo14 DROP CONSTRAINT IF EXISTS fk_cat_tipo13;


ALTER TABLE cat_tipo14 ADD COLUMN id serial;

ALTER TABLE cat_tipo14 ADD PRIMARY KEY (id);

--ALTER TABLE cat_tipo14 ADD COLUMN refcatFK VARCHAR(14);
--ALTER TABLE cat_tipo14 ADD COLUMN ucFK VARCHAR(4);

--UPDATE cat_tipo14
--SET refcatFK = cat_tipo13.refcat, ucFK = cat_tipo13.uc
--FROM cat_tipo13
--WHERE cat_tipo14.refcat = cat_tipo13.refcat AND cat_tipo14.uc = cat_tipo13.uc;

--ALTER TABLE cat_tipo14 ADD CONSTRAINT fk_cat_tipo13 FOREIGN KEY (refcatFK, ucFK) REFERENCES cat_tipo13(refcat, uc);



--SELECT * FROM cat_tipo14 LIMIT 100;
DROP TABLE IF EXISTS cat_tipo_reforma;

CREATE TABLE IF NOT EXISTS cat_tipo_reforma (
  cod char(1) PRIMARY KEY,
  descripcion VARCHAR(200) 
);

INSERT INTO cat_tipo_reforma(cod,descripcion) VALUES('R','Rehabilitación integral');
INSERT INTO cat_tipo_reforma(cod,descripcion) values('O','Reforma total');
INSERT INTO cat_tipo_reforma(cod,descripcion) values('E','Reforma media');
INSERT INTO cat_tipo_reforma(cod,descripcion) values('I','Reforma mínima');

DROP TABLE IF EXISTS cat_cod_destino_construccion;

--Tamano de 10 como dice el enunciado
CREATE TABLE IF NOT EXISTS cat_cod_destino_construccion (
  cod_destino char(10) PRIMARY KEY, 
  descripcion VARCHAR(200) 
);

---
--SELECT * FROM cat_cod_destino_construccion
---
COPY cat_cod_destino_construccion FROM 'D:\GENILDA\PRACTICA3\P03.02\documentacion\Destinos.csv' DELIMITER ';' CSV HEADER;

--ALTER TABLE cat_tipo14 ADD CONSTRAINT fk_cat_tipo14_destino FOREIGN KEY (destino) REFERENCES cat_cod_destino_construccion(cod_destino);

ALTER TABLE cat_tipo13 ADD COLUMN id INTEGER;

ALTER TABLE cat_tipo13 ADD CONSTRAINT fk_cat_tipo11 FOREIGN KEY (refcat) REFERENCES cat_tipo11(refcat);
--ALTER TABLE cat_tipo13 ADD CONSTRAINT fk_cat_tipo13_2 FOREIGN KEY (id) REFERENCES cat_tipo14(id);
ALTER TABLE cat_tipo14 ADD CONSTRAINT fk_cat_tipo13 FOREIGN KEY (refcat, uc) REFERENCES cat_tipo13(refcat, uc);

ALTER TABLE cat_tipo14 ADD CONSTRAINT fk_cat_tipo14_destino FOREIGN KEY (destino) REFERENCES cat_cod_destino_construccion(cod_destino);
ALTER TABLE cat_tipo14 ADD CONSTRAINT fk_cat_tipo14_reforma FOREIGN KEY (tipo_refor) REFERENCES cat_tipo_reforma(cod);