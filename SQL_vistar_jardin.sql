USE jardineria_vistas;

/*EJ 1*/
CREATE OR REPLACE VIEW listado_pagos AS
SELECT CONCAT_WS(' ',cl.nombre_contacto, cl.apellido_contacto) AS nombre_completo, cl.telefono, cl.ciudad, cl.pais, pa.fecha_pago, pa.total, pa.id_transaccion
FROM cliente cl
LEFT JOIN pago pa ON pa.codigo_cliente=cl.codigo_cliente;

SELECT * FROM listado_pagos;

/*EJ 2*/
CREATE OR REPLACE VIEW listado_pedidos_clientes AS
SELECT CONCAT_WS(' ',cl.nombre_contacto, cl.apellido_contacto) AS nombre_completo, cl.telefono, cl.ciudad, cl.pais, pe.codigo_pedido, pe.fecha_pedido, pe.fecha_esperada, pe.fecha_entrega, SUM(sub.total_producto) AS total_pedido
FROM  cliente cl
JOIN pedido pe ON pe.codigo_cliente=cl.codigo_cliente
JOIN detalle_pedido dp ON dp.codigo_pedido=pe.codigo_pedido
JOIN (
	SELECT dp.codigo_pedido AS pedido, (dp.cantidad*dp.precio_unidad) AS total_producto
    FROM detalle_pedido dp
) AS sub
ON sub.pedido=pe.codigo_pedido
GROUP BY sub.pedido;

SELECT *
FROM listado_pedidos_clientes;


/*EJ 3*/
SELECT nombre_completo
FROM listado_pagos
WHERE ciudad='madrid' AND id_transaccion IS NOT NULL;

/*EJ 4*/
SELECT *
FROM listado_pedidos_clientes
WHERE fecha_entrega IS NULL;

/*EJ 5*/
SELECT nombre_completo, COUNT(codigo_pedido)
FROM listado_pedidos_clientes
GROUP BY nombre_completo;

/*EJ 6*/
SELECT nombre_completo, total_pedido
FROM listado_pedidos_clientes
WHERE total_pedido=(
	SELECT MAX(total_pedido)
    FROM listado_pedidos_clientes
 ) 
    OR total_pedido=(
	SELECT MIN(total_pedido)
    FROM listado_pedidos_clientes
);

/*EJ 7*/
RENAME TABLE listado_pagos TO listado_de_pagos;
SELECT * FROM listado_de_pagos;

/*EJ 8*/
DROP VIEW IF EXISTS listado_de_pagos;
DROP VIEW IF EXISTS listado_pedidos_clientes;