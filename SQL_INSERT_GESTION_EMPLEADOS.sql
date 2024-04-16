USE empleados;

/*EJ 1*/
INSERT IGNORE INTO departamento(id,nombre,presupuesto)
VALUES(NOT NULL, 'Pruebas','12500.25');

SELECT *
FROM departamento;

/*EJ 2*/
INSERT IGNORE INTO departamento(nombre,presupuesto)
VALUES('Pruebas 2','7520.25');

SELECT *
FROM departamento;

/*EJ 3*/
INSERT INTO departamento(id,nombre,presupuesto,gastos)
VALUES(NOT NULL, 'Pruebas 3','7453.85','0');

SELECT *
FROM departamento;

/*EJ 4*/
INSERT INTO empleado(id,nif,nombre,apellido1,apellido2,id_departamento)
VALUES(NOT NULL,'9214328E','Paco','Sanz', NOT NULL, '10');

SELECT *
FROM empleado;

/*EJ 5*/
INSERT INTO empleado(nif,nombre,apellido1,apellido2,id_departamento)
VALUES('12345679A','Valdeande','Mágico', NOT NULL, '10');

SELECT *
FROM empleado;

/*EJ 6*/
CREATE TABLE departamento_backup (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

INSERT INTO departamento_backup
SELECT *
FROM departamento;

SELECT * 
FROM departamento_backup;

/*Ej 7*/
CREATE TABLE sistemas (
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100)
);

INSERT INTO sistemas
SELECT nif,nombre,apellido1,apellido2
FROM empleado
WHERE id_departamento=(
	SELECT id
    FROM departamento
    WHERE nombre='Sistemas'
);

SELECT *
FROM sistemas;

/*EJ 8*/
INSERT IGNORE INTO empleado(nif,nombre,apellido1,apellido2,id_departamento) VALUES
('28457963P','Monica','Jimenez','Martin','9'),
('85463215L','Ramón ','Solís ','Pérez','7'),
('71651431Z','Pepe ','Ruíz ','Santana','3');

SELECT * 
FROM empleado;

/*EJ 9*/
SELECT * 
FROM empleado;

SELECT * 
FROM departamento;

DELETE FROM departamento
WHERE nombre='Proyectos';

/*EJ 10*/
DELETE FROM departamento
WHERE nombre='Desarrollo';

/*EJ 11*/
UPDATE departamento
SET id=30
WHERE nombre='Recursos Humanos';

/*EJ 12*/
UPDATE departamento
SET id=40
WHERE nombre='Publicidad';

/*EJ 13*/
UPDATE departamento
SET presupuesto=presupuesto+50000 
WHERE presupuesto<20000 ;
