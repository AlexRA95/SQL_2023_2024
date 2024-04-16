USE tienda;

/*EJ 1*/
INSERT INTO fabricante VALUES
(NOT NULL, 'Nvidia');

SELECT *
FROM fabricante;

/*EJ 2*/
INSERT INTO fabricante(nombre) VALUES
('Amd');

SELECT *
FROM fabricante;

/*EJ 3*/
INSERT INTO producto(id,nombre,precio,id_fabricante)
VALUES(NOT NULL, 'Tablet del chino', '560.00','9');

SELECT *
FROM producto;

/*EJ 4*/
INSERT INTO producto(nombre,precio,id_fabricante)
VALUES('Ordenador de aliexpres', '842.75','6');

SELECT *
FROM producto;

SELECT *
FROM fabricante;

/*EJ 5*/
DROP TABLE IF EXISTS fabricante_producto;
CREATE TABLE fabricante_producto (
    nombre_fabricante VARCHAR(100) NOT NULL,
    nombre_producto VARCHAR(100) NOT NULL,
    precio DOUBLE NOT NULL
);

INSERT INTO fabricante_producto(nombre_fabricante,nombre_producto,precio)
SELECT f.nombre , p.nombre,p.precio
FROM producto p 
JOIN fabricante f ON f.id=p.id_fabricante;

SELECT *
FROM fabricante_producto;

/*EJ 6*/
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

DELETE FROM fabricante
WHERE nombre='Asus';

/*EJ 7*/
DELETE FROM fabricante
WHERE nombre='Xiaomi';

/*EJ 8*/
UPDATE fabricante 
SET id=20
WHERE nombre='Lenovo';

/*EJ 9*/
UPDATE fabricante 
SET id=30
WHERE nombre='Huawei';

/*EJ 10*/
UPDATE producto
SET precio=precio+5;

/*EJ 11*/
DELETE FROM producto
WHERE nombre LIKE('%Impresora%') AND precio<200;