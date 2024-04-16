USE empleados;


/*EJ 1*/
SELECT DISTINCT apellido1
FROM empleado;

/*EJ 2*/
SELECT DISTINCT id_departamento
FROM empleado
WHERE id_departamento IS NOT NULL;

/*EJ 3*/
SELECT LOWER(CONCAT_WS(' ',nombre, apellido1, apellido2)) AS 'Nombre completo'
FROM empleado;

/*EJ 4*/
SELECT id_departamento, SUBSTR(nif FROM 1 FOR 8) AS 'Numeros NIF', SUBSTR(nif FROM 9 FOR 1) AS 'Letras'
FROM empleado;

/*EJ 5*/
SELECT nombre, presupuesto-gastos AS 'Presupuesto actual'
FROM departamento;

/*EJ 6*/
SELECT nombre, presupuesto-gastos AS 'Presupuesto actual'
FROM departamento
ORDER BY presupuesto-gastos ASC;

/*EJ 7*/
SELECT nombre, apellido1, apellido2
FROM empleado
ORDER BY apellido1, apellido2, nombre;

/*EJ 8*/
SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto DESC
LIMIT 3 OFFSET 1;

/*EJ 9*/
SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto
LIMIT 3 OFFSET 1;

/*EJ 10*/
SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto
LIMIT 2 OFFSET 4;

/*EJ 11*/
SELECT *
FROM empleado
LIMIT 5 OFFSET 2;

/*EJ 12*/
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto>150000;

/*EJ 13*/
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto>200000 OR presupuesto<100000;

SELECT nombre, presupuesto
FROM departamento
WHERE NOT presupuesto<200000 OR NOT presupuesto>100000;

/*EJ 14*/
SELECT nombre, presupuesto, gastos
FROM departamento
WHERE gastos>presupuesto;

/*EJ 15*/
SELECT *
FROM empleado
WHERE apellido2 IS NULL;

/*EJ 16*/
SELECT *
FROM empleado
WHERE apellido2 IS NOT NULL;

/*EJ 17*/
SELECT UPPER(CONCAT_WS(' ', nombre, apellido1, apellido2)) AS nombre_completo, nif, id_departamento
FROM empleado
WHERE apellido2 IN ('Diaz', 'Moreno', 'Gil') AND id_departamento=1
ORDER BY nombre_completo;

/*LEFT JOIN & RIGHT JOIN*/
/*EJ 1*/
SELECT em.*, de.*
FROM empleado em
LEFT JOIN departamento de
	ON de.id=em.id_departamento;
    
/*EJ 2*/
SELECT em.*, de.*
FROM empleado em
LEFT JOIN departamento de
	ON de.id=em.id_departamento
WHERE em.id_departamento IS NULL;

/*EJ 3*/
SELECT em.*, de.*
FROM empleado em
RIGHT JOIN departamento de
	ON de.id=em.id_departamento
WHERE em.id_departamento IS NULL;

/*EJ 4*/
SELECT *
FROM empleado em
LEFT JOIN departamento de
	ON de.id=em.id_departamento
UNION

SELECT *
FROM empleado em
RIGHT JOIN departamento de
	ON de.id=em.id_departamento
    ORDER BY 8;
    
/*EJ 5*/
SELECT *
FROM empleado em
LEFT JOIN departamento de
	ON de.id=em.id_departamento
WHERE em.id_departamento IS NULL
UNION

SELECT *
FROM empleado em
RIGHT JOIN departamento de
	ON de.id=em.id_departamento
WHERE em.id_departamento IS NULL ;


/*GROUP BY*/
/*EJ 1*/
SELECT SUM(presupuesto)
FROM departamento;

/*EJ 2*/
SELECT AVG(presupuesto)
FROM departamento;

/*EJ 3*/
SELECT MIN(presupuesto)
FROM departamento;

/*EJ 4*/
SELECT nombre, presupuesto
FROM DEPARTAMENTO
ORDER BY presupuesto
LIMIT 1 OFFSET 1;

/*EJ 5*/
SELECT MAX(presupuesto)
FROM departamento;

/*EJ 6*/
SELECT nombre, presupuesto
FROM DEPARTAMENTO
ORDER BY presupuesto DESC
LIMIT 1 OFFSET 1;

/*EJ 7*/
SELECT COUNT(*)
FROM empleado;

/*EJ 8*/
SELECT COUNT(apellido2)
FROM empleado;

/*EJ 9*/
SELECT d.nombre, COUNT(e.id)
FROM empleado e
	RIGHT JOIN departamento d
		ON e.id_departamento=d.id
GROUP BY d.id;

/*EJ 10*/
SELECT d.nombre, COUNT(e.id)
FROM empleado e
	LEFT JOIN departamento d
		ON e.id_departamento=d.id
GROUP BY e.id_departamento
	HAVING COUNT(e.id)>=2;
    
/*EJ 11*/
SELECT d.nombre, COUNT(e.id)
FROM empleado e
	LEFT JOIN departamento d
		ON e.id_departamento=d.id
GROUP BY e.id_departamento;

/*EJ 12*/
SELECT d.nombre, COUNT(e.id)
FROM empleado e
	LEFT JOIN departamento d
		ON e.id_departamento=d.id
WHERE presupuesto>=200000
GROUP BY e.id_departamento
	HAVING COUNT(e.id)>=2;