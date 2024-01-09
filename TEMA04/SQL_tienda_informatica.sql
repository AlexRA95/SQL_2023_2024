DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  id_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


/*EJ 1*/
SELECT nombre
FROM producto;

/*EJ 2*/
SELECT nombre, precio
FROM producto;

/*EJ 3*/
SELECT *
FROM producto;

/*EJ 4*/
SELECT nombre, precio AS 'precio en €', precio+(precio*0.09) AS 'precio en $'
FROM producto;

/*EJ 5*/
SELECT nombre AS 'Nombre de producto', precio AS 'Euros', precio+(precio*0.09) AS 'Dólares'
FROM producto;

/*EJ 6*/
SELECT UPPER(nombre), precio
FROM producto;

/*EJ 7*/
SELECT LOWER(nombre), precio
FROM producto;

/*EJ 8*/
SELECT nombre, UPPER(SUBSTR(nombre,1,2))
FROM producto;

/*EJ 9*/
SELECT nombre, ROUND(precio) 
FROM producto;

/*EJ 10*/
SELECT nombre, CEILING(precio) 
FROM producto;

/*EJ 11*/
SELECT producto.id_fabricante
FROM fabricante, producto
WHERE producto.id_fabricante=fabricante.id;

/*EJ 12*/
SELECT DISTINCT producto.id_fabricante
FROM fabricante, producto
WHERE producto.id_fabricante=fabricante.id;

/*EJ 13*/
SELECT  fabricante.id, fabricante.nombre
FROM fabricante, producto
WHERE producto.id_fabricante=fabricante.id
ORDER BY fabricante.id;

/*EJ 14*/
SELECT  fabricante.id, fabricante.nombre
FROM fabricante, producto
WHERE producto.id_fabricante=fabricante.id
ORDER BY fabricante.id DESC;

/*EJ 15*/
SELECT  nombre
FROM producto
ORDER BY nombre, precio DESC;

/*EJ 16*/
SELECT *
FROM fabricante
LIMIT 5 OFFSET 0;

/*EJ 17*/
SELECT *
FROM fabricante
LIMIT 2 OFFSET 3;

/*EJ 18*/
SELECT nombre, precio
FROM producto
ORDER BY precio
LIMIT 1 OFFSET 0;

/*EJ 19*/
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1 OFFSET 0;

/*EJ 20*/
SELECT nombre
FROM producto
WHERE id_fabricante=2;

/*EJ 21*/
SELECT nombre
FROM producto
WHERE precio<=120;

/*EJ 22*/
SELECT nombre
FROM producto
WHERE precio>=400;

/*EJ 23*/
SELECT nombre
FROM producto
WHERE NOT precio>=400;

/*EJ 24*/
SELECT *
FROM producto
WHERE  precio<=300 AND precio>=80;

/*EJ 25*/
SELECT *
FROM producto
WHERE  precio<=200 AND precio>=60;

/*EJ 26*/
SELECT *
FROM producto
WHERE  precio>=200 AND id_fabricante=6;

/*EJ 27*/
SELECT *
FROM producto
WHERE  id_fabricante=1 OR id_fabricante=3 OR id_fabricante=5;

/*EJ 28*/
SELECT *
FROM producto
WHERE  id_fabricante IN (1,3,5);

/*EJ 29*/
SELECT nombre, precio, precio*100 AS 'Precio en centimos'
FROM producto;

/*EJ 30*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE 'S%';

/*EJ 31*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%e';

/*EJ 32*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%w%';

/*EJ 33*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '____' OR LENGTH(nombre)=4;

/*EJ 34*/
SELECT nombre
FROM producto
WHERE nombre LIKE ('%portatil%');

/*EJ 35*/
SELECT nombre
FROM producto
WHERE nombre LIKE ('%monitor%')  AND precio<215;

/*EJ 36*/
SELECT nombre, precio
FROM producto
WHERE  precio>=180
ORDER BY precio DESC, nombre;