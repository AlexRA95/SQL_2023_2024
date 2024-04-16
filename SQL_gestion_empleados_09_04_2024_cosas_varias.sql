USE empleados;

/*ej 1*/
ALTER TABLE empleado
ADD sueldo DOUBLE(10,2);

/*EJ 2*/
START TRANSACTION;
UPDATE empleado 
SET SUELDO=52000.00
WHERE id_departamento=1;
UPDATE empleado 
SET SUELDO=48000.00
WHERE id_departamento=2;
UPDATE empleado 
SET SUELDO=36000.00
WHERE id_departamento=3;
UPDATE empleado 
SET SUELDO=42000.00
WHERE id_departamento=4;
UPDATE empleado 
SET SUELDO=60000.00
WHERE id_departamento=5;
UPDATE empleado 
SET SUELDO=35000.00
WHERE id_departamento=6;
UPDATE empleado 
SET SUELDO=38000.00
WHERE id_departamento=7;

COMMIT;

/*EJ 3*/
START TRANSACTION;
UPDATE empleado 
SET SUELDO=sueldo+1000
WHERE id_departamento=1 OR id_departamento=2;
SAVEPOINT pre_recursos_humanos;
UPDATE empleado 
SET SUELDO=sueldo+500
WHERE id_departamento=3;


/*EJ 4*/
ROLLBACK TO pre_recursos_humanos;
COMMIT;

/*EJ 5*/
START TRANSACTION;
DELETE FROM empleado
WHERE nombre='Pepe' AND apellido1='Ruiz' AND apellido2='Santana';
DELETE FROM empleado
WHERE nombre='Juan' AND apellido1='Gómez' AND apellido2='López';
SAVEPOINT diego_in;
DELETE FROM empleado
WHERE nombre='Diego' AND apellido1='Flores' AND apellido2='Salas';

/*EJ 6*/
RELEASE SAVEPOINT diego_in;
ROLLBACK TO diego_in;
COMMIT;