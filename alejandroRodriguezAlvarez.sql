USE jardineria;

/*ej 1*/
SELECT o.linea_direccion1, o.linea_direccion2
FROM oficina o
JOIN empleado em ON em.codigo_oficina=o.codigo_oficina
JOIN cliente cl ON cl.codigo_empleado_rep_ventas=em.codigo_empleado
WHERE cl.ciudad='Fuenlabrada';

/*ej 2*/
SELECT distinct cl.nombre_cliente
FROM cliente cl
JOIN pedido pe ON pe.codigo_cliente=cl.codigo_cliente
WHERE pe.fecha_esperada<pe.fecha_entrega;

/*EJ 3*/
SELECT AVG(precio_proveedor), AVG(precio_venta)
FROM producto
WHERE gama='Ornamentales';

/*EJ 4*/
SELECT *
FROM producto 
WHERE cantidad_en_stock=(
	SELECT MIN(cantidad_en_stock)
    FROM producto
);

/*EJ 5*/
SELECT proveedor,COUNT(codigo_producto)
FROM producto
GROUP BY proveedor
HAVING COUNT(codigo_producto)>10;

/*EJ 6*/
SELECT CONCAT_WS(' ',em2.nombre,em2.apellido1,em2.apellido2) AS nombre_empleado, CONCAT_WS(' ',em1.nombre,em1.apellido1,em1.apellido2) AS nombre_jefe
FROM empleado em1
RIGHT JOIN empleado em2 ON em2.codigo_jefe=em1.codigo_empleado
ORDER BY nombre_jefe;

/*EJ 7*/
SELECT codigo_empleado, CONCAT_WS(' ',nombre,apellido1,apellido2) AS nombre_completo, codigo_oficina
FROM empleado
WHERE codigo_empleado NOT IN (
	SELECT  distinct codigo_empleado_rep_ventas
    FROM cliente
)
ORDER BY codigo_empleado;

/*EJ 8*/
SELECT p.*
FROM producto p
JOIN (
	SELECT gama, AVG(precio_venta) as media
    FROM producto
    GROUP BY gama
) AS sub ON sub.gama=p.gama
WHERE p.precio_venta>sub.media
ORDER BY p.gama, p.nombre;

/*EJ 9*/
SELECT g.gama, COUNT(p.codigo_producto)
FROM gama_producto g
LEFT JOIN producto p ON g.gama=p.gama
GROUP BY g.gama;

/*EJ 10*/
SELECT codigo_pedido, SUM(cantidad) as total_unidades
FROM detalle_pedido
GROUP BY codigo_pedido;

/*EJ 11*/
SELECT cl.nombre_cliente, pr.nombre, COUNT(*)
FROM cliente cl
JOIN pedido p ON p.codigo_cliente=cl.codigo_cliente
JOIN detalle_pedido dp ON dp.codigo_pedido=p.codigo_pedido
JOIN producto pr ON pr.codigo_producto=dp.codigo_producto
GROUP BY cl.codigo_cliente, pr.codigo_producto
HAVING COUNT(*)>1;

/*EJ 12*/
SELECT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente=p.codigo_cliente
GROUP BY c.codigo_cliente
HAVING COUNT(p.codigo_pedido)=(
	SELECT COUNT(p.codigo_pedido)
    FROM cliente c
	JOIN pedido p ON c.codigo_cliente=p.codigo_cliente
    WHERE c.nombre_cliente='Flores Marivi'
	GROUP BY c.codigo_cliente
);

/*EJ 13*/
SELECT *
FROM producto
WHERE gama='Ornamentales' AND precio_venta-precio_proveedor=(
	SELECT MAX(precio_venta-precio_proveedor)
	FROM producto
    WHERE gama='Ornamentales'
	GROUP BY gama
);

/*EJ 14*/
/*Esta consulta saca todos los datos de los clientes los cuales su ciudad no tiene ninguna oficina*/
SELECT *
FROM cliente
WHERE ciudad NOT IN (
	SELECT ciudad
    FROM oficina
);

/*EJ 15*/
SELECT *
FROM cliente c
WHERE NOT EXISTS (
	SELECT ciudad
    FROM oficina o
    WHERE c.ciudad=o.ciudad
);

