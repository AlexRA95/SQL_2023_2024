USE ventas;

/*EJ 1*/
SELECT p.*
FROM pedido p
WHERE id_cliente=(
	SELECT id
    FROM cliente
    WHERE nombre='Adela' AND apellido1='Salas' AND apellido2='Díaz'
);

/*Ej 2*/
SELECT COUNT(id)
FROM pedido p
WHERE id_comercial=(
	SELECT id
    FROM comercial
    WHERE nombre='Daniel' AND apellido1='Sáez' AND apellido2='Vega'
)
GROUP BY id_comercial;

/*EJ 3*/
SELECT  c.*
FROM cliente c
WHERE id=(
	SELECT id_cliente
    FROM pedido
    WHERE YEAR(fecha)=2019 AND total=(
		SELECT MAX(total)
        FROM pedido
        WHERE YEAR(fecha)=2019
    )
);

/*EJ 4*/
SELECT fecha, total
FROM pedido
WHERE total=(
	SELECT MIN(total)
	FROM pedido
	WHERE id_cliente=(
		SELECT id
		FROM cliente
		WHERE nombre='Pepe' AND apellido1='Ruiz' AND apellido2='Santana' 
	)
) AND id_cliente=(
		SELECT id
		FROM cliente
		WHERE nombre='Pepe' AND apellido1='Ruiz' AND apellido2='Santana' 
	);

/*EJ 5*/
SELECT *
FROM cliente c JOIN (
	SELECT *
    FROM pedido 
    WHERE YEAR(fecha)=2017 AND total>=(
		SELECT AVG(total)
        FROM pedido
        WHERE YEAR(fecha)=2017
    )
) AS r
ON r.id_cliente=c.id;


/*EJ 6*/
SELECT *
FROM cliente
WHERE id NOT IN (
	SELECT id_cliente
    FROM pedido
);
/*CONTINUAR??*/

/*EJ 7*/
SELECT *
FROM pedido
WHERE total=(
	SELECT MAX(total)
    FROM pedido
);

/*EJ 8*/
SELECT SUM(total)*r.comision AS 'Comision total', r.nomCom
FROM pedido p JOIN (
	SELECT id, comision, CONCAT_WS(' ', nombre, apellido1, apellido2) as nomCom
    FROM comercial c
    WHERE c.nombre='Juan' AND c.apellido1='Gómez' AND c.apellido2='López'
) as r
ON p.id_comercial=r.id
GROUP BY id_comercial;