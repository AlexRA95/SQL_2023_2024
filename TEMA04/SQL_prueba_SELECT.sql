DROP DATABASE IF EXISTS instituto;
CREATE DATABASE instituto CHARACTER SET utf8mb4;
USE instituto;

CREATE TABLE alumno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    fecha_nacimiento DATE NOT NULL,
    es_repetidor ENUM('sí', 'no') NOT NULL,
    teléfono VARCHAR(9)
);

INSERT INTO alumno VALUES(1, 'María', 'Sánchez', 'Pérez', '1990-12-01', 'no', NULL);
INSERT INTO alumno VALUES(2, 'Juan', 'Sáez', 'Vega', '1998-04-02', 'no', 618253876);
INSERT INTO alumno VALUES(3, 'Pepe', 'Ramírez', 'Gea', '1988-01-03', 'no', NULL);
INSERT INTO alumno VALUES(4, 'Lucía', 'Sánchez', 'Ortega', '1993-06-13', 'sí', 678516294);
INSERT INTO alumno VALUES(5, 'Paco', 'Martínez', 'López', '1995-11-24', 'no', 692735409);
INSERT INTO alumno VALUES(6, 'Irene', 'Gutiérrez', 'Sánchez', '1991-03-28', 'sí', NULL);
INSERT INTO alumno VALUES(7, 'Cristina', 'Fernández', 'Ramírez', '1996-09-17','no', 628349590);
INSERT INTO alumno VALUES(8, 'Antonio', 'Carretero', null, '1994-05-20', 'sí', 612345633);
INSERT INTO alumno VALUES(9, 'Manuel', 'Domínguez', 'Hernández', '1999-07-08', 'no', NULL);
INSERT INTO alumno VALUES(10, 'Daniel', 'Moreno', 'Ruiz', '1998-02-03', 'no', NULL);

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE ventas (
 id INT AUTO_INCREMENT PRIMARY KEY,
 cantidad_comprada INT UNSIGNED NOT NULL,
 precio_por_elemento DECIMAL(7,2) NOT NULL
 );

INSERT INTO ventas VALUES (1, 2, 1.50);
INSERT INTO ventas VALUES (2, 5, 1.75);
INSERT INTO ventas VALUES (3, 7, 2.00);
INSERT INTO ventas VALUES (4, 9, 3.50);
INSERT INTO ventas VALUES (5, 6, 9.99);


SELECT LOWER(CONCAT_WS(' ', nombre, apellido1, apellido2))  
FROM instituto.alumno;

SELECT UPPER(CONCAT_WS(' ', nombre, apellido1, apellido2))  
FROM instituto.alumno;

SELECT CONCAT( IFNULL(SUBSTR(nombre,1, 3),''), IFNULL(SUBSTR(apellido1,1, 3), '') , IFNULL(SUBSTR(apellido2,1, 3),'') ) AS 'Correo Temporal'
FROM instituto.alumno;

SELECT *
FROM instituto.alumno
WHERE id=1;

SELECT *
FROM instituto.alumno
WHERE teléfono=692735409;

SELECT *
FROM instituto.alumno
WHERE es_repetidor IN ('sí');


SELECT *
FROM instituto.alumno
WHERE es_repetidor IN ('no');

SELECT *
FROM instituto.alumno
WHERE fecha_nacimiento<'1993-01-01';

SELECT *
FROM instituto.alumno
WHERE fecha_nacimiento>'1993-01-01';

SELECT *
FROM instituto.alumno
WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '1998-12-31';

SELECT *
FROM instituto.alumno
WHERE fecha_nacimiento NOT BETWEEN '1998-01-01' AND '1998-12-31';

SELECT CONCAT_WS(' ',nombre, apellido1, apellido2) AS 'Nombre',
 REVERSE(CONCAT_WS(' ', apellido2, apellido1,nombre)) AS 'Nombre inverso' 
FROM instituto.alumno;

SELECT UPPER(CONCAT_WS(' ',nombre, apellido1, apellido2))  AS 'Nombre en mayuscula',
 LOWER(REVERSE(CONCAT_WS(' ', apellido2, apellido1,nombre)))  AS 'Nombre inverso en minuscula' 
FROM instituto.alumno;

SELECT CONCAT_WS(' ',nombre, apellido1, apellido2) AS 'Nombre',
 CHAR_LENGTH(CONCAT_WS(' ',nombre, apellido1, apellido2)) AS 'nCaracteres',
 LENGTH(CONCAT_WS(' ',nombre, apellido1, apellido2)) AS 'nBits'
FROM instituto.alumno;

SELECT 
    CONCAT_WS(' ', nombre, apellido1, apellido2) AS 'Nombre',
    LOWER(CONCAT(nombre,'.',apellido1,'@iesalbarregas.org')) AS 'Correo electronico',
    IFNULL(CONCAT(REVERSE(apellido2),YEAR(fecha_nacimiento)),YEAR(fecha_nacimiento)) AS 'Contraseña correo'
FROM
    instituto.alumno;
    
SELECT fecha_nacimiento, DAY(fecha_nacimiento) AS 'DÍA', MONTH(fecha_nacimiento) AS 'MES', YEAR(fecha_nacimiento) AS 'AÑO'
FROM alumno;

SELECT fecha_nacimiento, SUBSTR(fecha_nacimiento FROM 9 FOR 2 ) AS 'DÍA', SUBSTR(fecha_nacimiento FROM 6 FOR 2) AS 'MES', SUBSTR(fecha_nacimiento FROM 1 FOR 4) AS 'AÑO'
FROM alumno;

SET lc_time_names='es_ES';

SELECT fecha_nacimiento, DAYNAME(fecha_nacimiento) AS 'Dia', MONTHNAME(fecha_nacimiento)
FROM alumno;

SELECT fecha_nacimiento, DATE_FORMAT(fecha_nacimiento, '%e/%b/%y') AS 'Fecha_españa'
FROM alumno;

SELECT fecha_nacimiento, DATEDIFF(CURDATE() ,fecha_nacimiento) AS 'Días diferencia'
FROM alumno;

SELECT fecha_nacimiento, FLOOR(DATEDIFF(CURDATE() ,fecha_nacimiento)/365.25) AS 'Edad'
FROM alumno;
