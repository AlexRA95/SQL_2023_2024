DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;

CREATE TABLE cliente (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  categoria INT UNSIGNED
);

CREATE TABLE comercial (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  comision FLOAT
);

CREATE TABLE pedido (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  total DOUBLE NOT NULL,
  fecha DATE,
  id_cliente INT UNSIGNED NOT NULL,
  id_comercial INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

/*JOINS*/
/*EJ 1*/
SELECT DISTINCT cl.id, CONCAT_WS(' ', cl.nombre, cl.apellido1, cl.apellido2) AS Nombre
FROM   pedido p JOIN cliente cl
ON cl.id=p.id_cliente
ORDER BY CONCAT_WS(' ', cl.nombre, cl.apellido1, cl.apellido2);

/*EJ 2*/
SELECT DISTINCT p.*, cl.* 
FROM   pedido p JOIN cliente cl
ON cl.id=p.id_cliente
ORDER BY  cl.apellido1;

/*EJ 3*/
SELECT co.*, p.*
FROM pedido p JOIN comercial co
ON p.id_comercial=co.id
ORDER BY co.nombre;

/*EJ 4*/
SELECT cl.*, co.*,p.*
FROM pedido p 
JOIN comercial co
	ON p.id_comercial=co.id
JOIN cliente cl
	ON  p.id_cliente=cl.id;
    
/*EJ 5*/
SELECT DISTINCT p.*, cl.* 
FROM   pedido p 
JOIN cliente cl
	ON cl.id=p.id_cliente  
WHERE YEAR(p.fecha)=2017 AND p.total BETWEEN 300 AND 1000;
    
/*EJ 6*/
SELECT co.nombre, co.apellido1, co.apellido2
FROM pedido p
JOIN comercial co
	ON p.id_comercial=co.id
JOIN cliente cl
	ON p.id_cliente=cl.id  
WHERE cl.id=6;
    
/*EJ 7*/
SELECT cl.nombre, cl.apellido1, cl.apellido2
FROM pedido p
JOIN comercial co
	ON p.id_comercial=co.id  
JOIN cliente cl
	ON p.id_cliente=cl.id
WHERE co.id=1;
    
/*EJ 8*/
SELECT co.nombre, p.total, p.fecha, cl.ciudad
FROM pedido p 
JOIN cliente cl
	ON p.id_cliente=cl.id  
JOIN comercial co
	ON p.id_comercial=co.id
WHERE cl.ciudad IN ('granada', 'huelva');
    
/*EJ 9*/
SELECT P.*
FROM pedido p 
JOIN cliente cl
	ON p.id_cliente=cl.id  
WHERE cl.categoria=300 AND cl.apellido2 IS NULL;
    
/*EJ 10*/
SELECT p.total, co.nombre
FROM pedido p 
JOIN comercial co
	ON p.id_comercial=co.id
WHERE MONTH(p.fecha)=9 AND YEAR(p.fecha)=2016;

/*LEFT & RIGHT JOIN*/
/*EJ 1*/
SELECT cl.*, pe.*
FROM cliente cl
LEFT JOIN pedido pe
	ON pe.id_cliente=cl.id
ORDER BY cl.nombre, cl.apellido1, cl.apellido2;

/*EJ 2*/
SELECT co.*, pe.*
FROM comercial co
LEFT JOIN pedido pe
	ON pe.id_comercial=co.id
ORDER BY co.nombre, co.apellido1, co.apellido2;

/*EJ 3*/
SELECT cl.*, pe.*
FROM cliente cl
LEFT JOIN pedido pe
	ON pe.id_cliente=cl.id
WHERE pe.id_cliente IS NULL;

/*EJ 4*/
SELECT co.*, pe.*
FROM comercial co
LEFT JOIN pedido pe
	ON pe.id_comercial=co.id
WHERE pe.id_comercial IS NULL;

/*EJ 5*/
SELECT cl.nombre, cl.apellido1, cl.apellido2, IF(pe.id_cliente IS NOT NULL, 'CLIENTE', 'COMERCIAL') AS 'QUE_ES'
FROM cliente cl
LEFT JOIN pedido pe
	ON pe.id_cliente=cl.id
WHERE pe.id_cliente IS NULL

UNION

SELECT co.nombre, co.apellido1, co.apellido2, IF(pe.id_cliente IS NULL, 'CLIENTE', 'COMERCIAL') AS 'QUE_ES'
FROM comercial co
LEFT JOIN pedido pe
	ON pe.id_comercial=co.id
WHERE pe.id_comercial IS NULL
ORDER BY 1,2,3;

/*EJ 6*/
SELECT cl.* , pe.*, co.nombre, co.apellido1, co.apellido2
FROM pedido pe
	 RIGHT JOIN cliente cl
    ON cl.id=pe.id_cliente
    LEFT JOIN comercial co
    ON co.id=pe.id_comercial
ORDER BY cl.nombre, cl.apellido1, cl.apellido2;

/*GROUP BY*/
/*EJ 1*/
SELECT  SUM(total)
FROM pedido;
    
/*EJ 2*/
SELECT  AVG(total)
FROM pedido;

/*EJ 3*/
SELECT COUNT(DISTINCT id_comercial)
FROM pedido;

/*EJ 4*/
SELECT COUNT(id)
FROM cliente;

/*EJ 5*/
SELECT  MAX(total)
FROM pedido;

/*EJ 6*/
SELECT  MIN(total)
FROM pedido;

/*EJ 7*/
SELECT c.ciudad, MAX(p.total)
FROM cliente c
	LEFT JOIN pedido p
		ON c.id=p.id_cliente
GROUP BY c.ciudad;

/*EJ 8*/
SELECT c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total)
FROM pedido p
	LEFT JOIN cliente c
		ON c.id=p.id_cliente
GROUP BY p.id_cliente,p.fecha;

/*EJ 9*/
SELECT c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total)
FROM pedido p
	LEFT JOIN cliente c
		ON c.id=p.id_cliente
GROUP BY p.id_cliente,p.fecha
HAVING MAX(p.total)>=2000;

/*EJ 10*/
SELECT p.id_comercial, c.nombre, c.apellido1, MAX(p.total)
FROM pedido p
	LEFT JOIN comercial c
		ON c.id=p.id_comercial
WHERE fecha LIKE('2016-08-17')
GROUP BY p.id_comercial;

/*EJ 11*/
SELECT c.id, c.nombre, c.apellido1 ,COUNT(p.id)
FROM cliente c
	LEFT JOIN pedido p
		ON p.id_cliente=c.id
GROUP BY c.id;

/*EJ 12*/
SELECT c.id, c.nombre, c.apellido1 ,COUNT(p.id)
FROM cliente c
	LEFT JOIN pedido p
		ON p.id_cliente=c.id AND YEAR(p.fecha)=2017
GROUP BY c.id;

/*EJ 13*/
SELECT c.id, c.nombre, c.apellido1 , IFNULL(MAX(p.total) ,'0') AS 'Total'
FROM cliente c
	LEFT JOIN pedido p
		ON p.id_cliente=c.id 
GROUP BY c.id;

/*EJ 14*/
SELECT MAX(p.total)
FROM pedido p
GROUP BY YEAR(p.fecha);

/*EJ 15*/
SELECT COUNT(p.id)
FROM pedido p
GROUP BY YEAR(p.fecha);