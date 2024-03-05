USE empleados;

/*EJ 1*/
SELECT *
FROM empleado
WHERE id_departamento=(
	SELECT id
    FROM departamento
    WHERE nombre='Sistemas'
);

/*EJ 2*/
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto=(
	SELECT MAX(presupuesto)
    FROM departamento
);

/*EJ 3*/
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto=(
	SELECT MIN(presupuesto)
    FROM departamento
);

/*EJ 4*/
SELECT nombre
FROM departamento 
WHERE id IN (
	SELECT id_departamento
    FROM empleado
);

SELECT nombre
FROM departamento d
WHERE  EXISTS(
	SELECT id_departamento
    FROM empleado e
    WHERE d.id=e.id_departamento
);

SELECT nombre
FROM departamento 
WHERE id = ANY (
	SELECT id_departamento
    FROM empleado
);

SELECT nombre
FROM departamento d JOIN (
	SELECT DISTINCT id_departamento as id
    FROM empleado
) AS e
ON e.id=d.id;

/*EJ 5*/
SELECT nombre
FROM departamento
WHERE id NOT IN (
	SELECT id_departamento
    FROM empleado
    WHERE id_departamento IS NOT NULL
);

SELECT nombre
FROM departamento d
WHERE NOT EXISTS(
	SELECT id_departamento
    FROM empleado e
    WHERE d.id=e.id_departamento
);

SELECT nombre
FROM departamento d
WHERE id <> ALL (
	SELECT id_departamento
    FROM empleado
    WHERE id_departamento IS NOT NULL
);

SELECT d.nombre
FROM departamento d LEFT JOIN(
	SELECT id_departamento as id
    FROM empleado
) AS e
ON e.id=d.id
WHERE e.id IS NULL;

/*EJ 6*/
SELECT e.*
FROM empleado e
WHERE id_departamento=(
	SELECT id
    FROM departamento
    WHERE presupuesto=(
		SELECT MAX(presupuesto)
        FROM departamento
    )
);

/*EJ 7*/
SELECT e.*
FROM empleado e
WHERE nombre LIKE('M%') 
AND id_departamento=(
	SELECT id
    FROM departamento
    WHERE gastos>(
		SELECT AVG(gastos)
        FROM departamento
    )
);

/*EJ 8*/
SELECT e.*
FROM empleado e
WHERE apellido1 IN(
	SELECT apellido1
    FROM empleado
    GROUP BY apellido1
    HAVING COUNT(apellido1)>1
)
ORDER BY apellido1;

/*EJ 9*/
SELECT d.nombre, (
	SELECT COUNT(e.nombre)
    FROM empleado e
    WHERE e.id_departamento=d.id
    GROUP BY id_departamento
) AS num_empleados
FROM departamento d;

/*EJ 10*/
SELECT nombre
FROM departamento
WHERE id IN(
	SELECT id_departamento
    FROM empleado
    GROUP BY id_departamento
    HAVING COUNT(nombre)>(
		SELECT COUNT(nombre)
        FROM empleado
        WHERE id_departamento=(
			SELECT id
            FROM departamento
            WHERE nombre='Contabilidad'
        )
        GROUP BY id_departamento
    )
);

/*EJ 11*/
SELECT e.*
FROM empleado e JOIN (
	SELECT id
    FROM empleado
    WHERE id_departamento=(
		SELECT id
        FROM departamento
        WHERE gastos>(
			SELECT AVG(gastos)
            FROM departamento
        )
    )
) AS j
ON j.id=e.id;