USE tienda;



/*EJ 1*/
SELECT 
    nombre
FROM
    producto;

/*EJ 2*/
SELECT nombre, precio
FROM producto;

/*EJ 3*/
SELECT 
    *
FROM
    producto;

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
SELECT nombre, UPPER(SUBSTR(nombre,1,2)) AS 'Código'
FROM fabricante;

/*EJ 9*/
SELECT nombre, ROUND(precio) AS 'Precio redondeado'
FROM producto;

/*EJ 10*/
SELECT nombre, CEILING(precio) AS 'Precio al alza'
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
ORDER BY fabricante.nombre;

/*EJ 14*/
SELECT  fabricante.id, fabricante.nombre
FROM fabricante, producto
WHERE producto.id_fabricante=fabricante.id
ORDER BY fabricante.nombre DESC;

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



/*JOINS*/
/*EJ 1*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante AS f JOIN producto AS p
ON p.id_fabricante=f.id;

/*EJ 2*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante AS f JOIN producto AS p
ON p.id_fabricante=f.id
ORDER BY f.nombre;

/*EJ 3*/
SELECT p.id, p.nombre, f.id, f.nombre
FROM fabricante AS f JOIN producto AS p
ON p.id_fabricante=f.id;

/*EJ 4*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante AS f JOIN producto AS p
ON p.id_fabricante=f.id
ORDER BY p.precio
LIMIT 1 OFFSET 1;

/*EJ 5*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante AS f JOIN producto AS p
ON p.id_fabricante=f.id
ORDER BY p.precio DESC
LIMIT 1 OFFSET 1;

/*EJ 6*/
SELECT *
FROM fabricante AS f JOIN producto AS p
ON p.id_fabricante=f.id AND f.id=1;

/*EJ 7*/
SELECT *
FROM fabricante f JOIN producto p
ON p.precio>200 AND f.nombre='Crucial';

/*EJ 8*/
SELECT *
FROM fabricante f JOIN producto p
ON p.id_fabricante=f.id AND f.id IN (1,3);

/*EJ 9*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f JOIN producto p
ON p.id_fabricante=f.id AND f.nombre LIKE('%e');

/*EJ 10*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f JOIN producto p
ON p.id_fabricante=f.id AND f.nombre LIKE('%w%');

/*EJ 11*/
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f JOIN producto p
ON p.precio>=180 AND p.id_fabricante=f.id
ORDER BY p.precio ASC, p.nombre DESC;

/*EJ 12*/
SELECT DISTINCT f.id, f.nombre
FROM fabricante f JOIN producto p
ON p.id_fabricante=f.id;

/*LEFT JOIN & RIGHT JOIN*/
/*EJ 1*/
SELECT fa.*, pr.*
FROM fabricante fa 
LEFT JOIN producto pr
ON fa.id=pr.id_fabricante;

/*EJ 2*/
SELECT fa.*, pr.*
FROM fabricante fa 
LEFT JOIN producto pr
ON fa.id=pr.id_fabricante
WHERE pr.id_fabricante IS NULL;


/*GROUP BY & HAVING*/
/*EJ 1*/
SELECT COUNT(*) AS 'Nº PRODUCTO'
FROM producto p;

/*EJ 2*/
SELECT COUNT(*) AS 'Nº FABRICANTES'
FROM fabricante;

/*EJ 3*/
SELECT COUNT(DISTINCT id_fabricante) AS 'Nº ID UNICOS'
FROM producto;

/*EJ 4*/
SELECT AVG(precio) AS 'PRECIO MEDIO'
FROM producto;

/*EJ 5*/
SELECT MIN(precio) AS 'PRECIO MINIMO'
FROM producto;

/*EJ 6*/
SELECT MAX(precio) AS 'PRECIO MAXIMO'
FROM producto;

/*EJ 7*/
SELECT SUM(precio) AS 'PRECIO TOTAL'
FROM producto;

/*EJ 8*/
SELECT COUNT(*) AS 'Nº Productos ASUS'
FROM producto p 
	JOIN fabricante f
		ON f.id=p.id_fabricante
WHERE f.nombre LIKE('ASUS');

/*EJ 9*/
SELECT AVG(precio) AS 'Precio medio ASUS'
FROM producto p 
	JOIN fabricante f
		ON f.id=p.id_fabricante
WHERE f.nombre LIKE('ASUS');

/*EJ 10*/
SELECT MIN(precio) AS 'Precio medio ASUS'
FROM producto p 
	JOIN fabricante f
		ON f.id=p.id_fabricante
WHERE f.nombre LIKE('ASUS');

/*EJ 11*/
SELECT MAX(precio) AS 'Precio medio ASUS'
FROM producto p 
	JOIN fabricante f
		ON f.id=p.id_fabricante
WHERE f.nombre LIKE('ASUS');

/*EJ 12*/
SELECT SUM(precio) AS 'Precio medio ASUS'
FROM producto p 
	JOIN fabricante f
		ON f.id=p.id_fabricante
WHERE f.nombre LIKE('ASUS');

/*EJ 13*/
SELECT MAX(precio), MIN(precio), AVG(precio),COUNT(*)
FROM producto p 
	JOIN fabricante f
		ON f.id=p.id_fabricante
WHERE f.nombre LIKE('CRUCIAL');

/*EJ 14*/
SELECT f.nombre, COUNT(id_fabricante)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY f.id
ORDER BY COUNT(id_fabricante) DESC;

/*EJ 15*/
SELECT f.nombre, MAX(precio), MIN(precio), AVG(precio)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY f.id;

/*EJ 16*/
SELECT f.id, MAX(precio), MIN(precio), AVG(precio), COUNT(id_fabricante)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY f.id
	HAVING AVG(precio)>200;
    
/*EJ 17*/
SELECT f.nombre, MAX(precio), MIN(precio), AVG(precio), COUNT(id_fabricante)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY f.id
	HAVING AVG(precio)>200;
    
/*EJ 18*/
SELECT count(*)
FROM producto p
WHERE precio>=180;

/*EJ 19*/
SELECT p.id_fabricante, f.nombre, COUNT(*)
FROM fabricante f
	RIGHT JOIN producto p
		ON f.id=p.id_fabricante
WHERE precio>=180
GROUP BY p.id_fabricante;

/*EJ 20*/
SELECT p.id_fabricante, AVG(precio)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY p.id_fabricante;

/*EJ 21*/
SELECT f.nombre, AVG(precio)
FROM fabricante f
	RIGHT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY p.id_fabricante;

/*EJ 22*/
SELECT f.nombre
FROM fabricante f
	RIGHT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY p.id_fabricante
HAVING AVG(precio)>=150;

/*EJ 23*/
SELECT f.nombre
FROM fabricante f
	RIGHT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY p.id_fabricante
HAVING COUNT(*)>=2;

/*EJ 24*/
SELECT f.nombre, COUNT(*)
FROM fabricante f
	RIGHT JOIN producto p
		ON f.id=p.id_fabricante
WHERE precio>=220        
GROUP BY p.id_fabricante;

/*EJ 25*/
SELECT f.id AS 'id_fabricante', f.nombre, COUNT(p.precio)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante AND p.precio>=220
GROUP BY f.id;

/*EJ 26*/
SELECT p.id_fabricante, f.nombre, SUM(precio)
FROM fabricante f
	LEFT JOIN producto p
		ON f.id=p.id_fabricante
GROUP BY f.id
HAVING SUM(precio)>1000;

