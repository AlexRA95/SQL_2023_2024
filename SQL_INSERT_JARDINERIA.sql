USE jardineria_vistas;

SELECT * FROM oficina;
SELECT * FROM empleado;
SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;
SELECT * FROM producto;


/*EJ 1*/
INSERT INTO oficina VALUES 
	('ALM-ES','Almeria','España','Almeria','04001','+34 98 765 4321', 'algún sitio', null)
;

/*EJ 2*/ 
INSERT INTO empleado VALUES 
	(32,'Marcos','José','Ortega de la vera', '9999','algo@algo.com', 'ALM-ES', null, 'Representante Ventas')
;

/*EJ 3*/
INSERT INTO cliente VALUES
	(39,'Tutti Frutti S.A','Paco','Sanz','987654321', '987654321', 'C/Inventada 123', null, 'Almeria', 'Almeria', 'Spain' , '04001', '32', '900000.00')
;

/*EJ 4*/
INSERT INTO pedido VALUES
(129,'2024-04-05','2024-04-06',null, 'Pendiente',NULL, 39)
;

INSERT INTO detalle_pedido VALUES
(129,11679,99,89.99,77),
(129,'AR-001',99,89.99,77);

/*ej 5*/
UPDATE cliente
SET codigo_cliente=77
WHERE nombre_contacto='Paco' AND apellido_contacto='Sanz';

/*EJ 6*/
DELETE FROM cliente
WHERE nombre_contacto='Paco' AND apellido_contacto='Sanz';

/*ej 7*/
DELETE FROM cliente
WHERE codigo_cliente NOT IN (
	SELECT distinct codigo_cliente
    FROM pedido
);

/*EJ 8*/
UPDATE producto
SET precio_venta=precio_venta*1.20 AND precio_proveedor=precio_proveedor*1.20
WHERE codigo_producto NOT IN (
	SELECT distinct codigo_producto
    FROM detalle_pedido
);

/*EJ 9*/
DELETE FROM pago
WHERE codigo_cliente=(
	SELECT codigo_cliente
    FROM cliente
    WHERE limite_credito=(
		SELECT MIN(limite_credito)
        FROM cliente
    )
);

/*EJ 10*/
UPDATE cliente
SET limite_credito=0
WHERE codigo_cliente=4;
