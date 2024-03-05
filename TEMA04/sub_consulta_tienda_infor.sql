USE tienda;

/*EJ 1*/
SELECT *
FROM producto
WHERE id_fabricante=(
	SELECT id
	FROM fabricante
	WHERE nombre='Lenovo'
);

/*EJ 2*/
SELECT *
FROM producto
WHERE precio=(
	SELECT MAX(precio)
	FROM producto
	WHERE id_fabricante=(
		SELECT id
		FROM fabricante
		WHERE nombre='Lenovo'));
        
/*EJ 3*/
SELECT nombre
FROM producto
WHERE precio=(
	SELECT MAX(precio) 
	FROM producto
	WHERE id_fabricante=(
		SELECT id
		FROM fabricante
		WHERE nombre='Lenovo')
);

/*EJ 4*/
SELECT nombre
FROM producto
WHERE precio=(
	SELECT MIN(precio)
    FROM producto
    WHERE id_fabricante=(
		SELECT id
        FROM fabricante
        WHERE nombre="Hewlett-Packard")
);

/*EJ 5*/
SELECT *
FROM producto
WHERE precio>=(
	SELECT MAX(precio)
    FROM producto
    WHERE id_fabricante=(
		SELECT id
        FROM fabricante
        WHERE nombre="Lenovo"
        )
);

/*EJ 6*/
SELECT *
FROM producto
WHERE precio>(
	SELECT AVG(precio)
    FROM producto
    WHERE id_fabricante=(
		SELECT id
		FROM fabricante
		WHERE nombre="Asus"
    ) 
) AND
	id_fabricante=(
		SELECT id
		FROM fabricante
		WHERE nombre="Asus"
);

/*EJ 7*/
SELECT *
FROM producto
WHERE precio=(
	SELECT MAX(precio)
    FROM producto
);

/*EJ 8*/
SELECT *
FROM producto
WHERE precio=(
	SELECT MIN(precio)
    FROM producto
);

/*EJ 9*/
SELECT nombre
FROM fabricante
WHERE id = ANY
(
SELECT id_fabricante
FROM producto
);

/*EJ 10*/
SELECT nombre
FROM fabricante
WHERE id != ALL
(
SELECT id_fabricante
FROM producto
);

/*EJ 11*/
SELECT nombre
FROM fabricante
WHERE id IN (
	SELECT id_fabricante
    FROM producto
);

/*EJ 12*/
SELECT nombre
FROM fabricante
WHERE id NOT IN (
	SELECT id_fabricante
    FROM producto
);

/*EJ 13*/
SELECT nombre
FROM fabricante f
WHERE EXISTS (
	SELECT id_fabricante
    FROM producto p
    WHERE f.id=p.id_fabricante
);

/*EJ 14*/
SELECT nombre
FROM fabricante f
WHERE NOT EXISTS (
	SELECT id_fabricante
    FROM producto p
    WHERE f.id=p.id_fabricante
);

/*EJ 15*/
SELECT f.nombre, m.maxPrecio, (
	SELECT nombre
    FROM producto
	WHERE precio = m.maxPrecio
) AS nombre_producto
FROM fabricante f JOIN (
	SELECT id_fabricante, MAX(precio) AS maxPrecio
    FROM producto
    GROUP BY id_fabricante
) AS m
ON m.id_fabricante=f.id;

/*EJ 16*/
SELECT p.*, m.precioMedio
FROM producto p JOIN (
	SELECT id_fabricante, AVG(precio) AS precioMedio
    FROM producto
    GROUP BY id_fabricante
) AS m
ON p.id_fabricante=m.id_fabricante
WHERE precio>=m.precioMedio;

/*EJ 17*/
SELECT nombre
FROM producto
WHERE precio=(
	SELECT MAX(precio)
    FROM producto
    WHERE id_fabricante=(
		SELECT id
        FROM fabricante
        WHERE nombre="Lenovo"
    )
);

/*EJ 18*/
SELECT f.nombre, COUNT(p.id)
FROM  fabricante f
JOIN producto p
ON f.id=p.id_fabricante
GROUP BY p.id_fabricante
HAVING COUNT(p.id)>=(
	SELECT COUNT(p.id)
    FROM producto p
    WHERE id_fabricante=(
		SELECT id
        FROM fabricante
        WHERE nombre="Lenovo"
    )
    GROUP BY p.id_fabricante
);