USE jardineria_vistas;

/*
EXPLAIN
SELECT nombre_contacto, telefono
FROM cliente
WHERE pais='France';
*/
/*
CREATE INDEX idx_pais ON cliente(pais);
*/

/*EJ 1*/
SHOW INDEX FROM producto;

/*Ej 2*/
EXPLAIN
SELECT *
FROM producto
WHERE codigo_producto='OR-114';

EXPLAIN
SELECT *
FROM producto
WHERE nombre='Evonimus Pulchellus';

/*
	ENTRE ESTAS 2 COLSUTAS, LA QUE MENOS COMPARACIONES REALIZA ES LA 1, YA QUE EN ESA BUSCAMOS MEDIANTE UNA CLAVE PRIMARIA
    QUE FUNCIONA COMO UN INDEX. POR LO TANTO REALIZA MENOS COMPARACIONES QUE LA 2 YA QUE BUSCA POR UN PARAMETRO QUE NO 
    FUNCIONA COMO UN INDICE.
*/

/*EJ 3*/
CREATE INDEX idx_fecha ON pago(fecha_pago);
EXPLAIN
SELECT AVG(total)
FROM pago
WHERE YEAR(fecha_pago)=2000;

EXPLAIN
SELECT AVG(total)
FROM pago
WHERE fecha_pago>='2000-01-01' and fecha_pago<='2000-12-31';

/*EJ 4*/
CREATE INDEX idx_nombre_cliente ON cliente(nombre_cliente);
SHOW INDEX FROM cliente;
EXPLAIN
SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente=pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE 'A%';

/*EJ 5*/
EXPLAIN
SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente=pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A%';

EXPLAIN
SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente=pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A';

/*EJ 6*/
CREATE INDEX idx_nombre_completo ON cliente(apellido_contacto,nombre_contacto);

/*6.1----Se ha examinado solo 1 fila*/
EXPLAIN
SELECT *
FROM cliente
WHERE nombre_contacto='Javier' AND apellido_contacto='Villar';

/*6.2----Se ha examinado solo 1 fila*/
EXPLAIN
SELECT *
FROM cliente
WHERE apellido_contacto='Villar';

/*6.3 ----Se han examinado todas las filas ya que el indice empiza por el apellido.*/
EXPLAIN
SELECT *
FROM cliente
WHERE nombre_contacto='Javier';


/*EJ 7*/
/*7.1*/
SELECT count(distinct nombre_cliente)
FROM cliente;

/*7.2*/
SELECT distinct LEFT(nombre_cliente,11)
FROM cliente;

/*7.3*/
CREATE INDEX idx_nom_cliente ON cliente(nombre_cliente(11));

/*7.4*/
EXPLAIN
SELECT *
FROM cliente
WHERE nombre_cliente LIKE('Gerudo%');

EXPLAIN
SELECT *
FROM cliente
WHERE nombre_cliente LIKE('G%');