use neptuno;

/*EJ 1*/
SELECT *
FROM cliente
WHERE region IS NULL;

/*EJ 2*/
SELECT *
FROM empleado
WHERE pais!='EE.UU.';

/*EJ 3*/
SELECT *
FROM producto
WHERE UnidadesEnExistencia=0;

/*EJ 4*/
