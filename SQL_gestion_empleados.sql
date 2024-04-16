DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

-- Ejercicio Empleados 1
ALTER TABLE departamento MODIFY COLUMN gastos DOUBLE UNSIGNED NOT NULL DEFAULT (0);
-- Si insertamos directamente las 3 columnas que nos pide el ejercicio, aparece error porque el campo gastos no puede estar vacío pero no tiene un valor DEFAULT asignado. 
-- ALTER TABLE para asignarlo o indicamos en la instrucción INSERT el valor gastos.
INSERT INTO departamento (id, nombre, presupuesto) VALUES (8, 'Ventas', 200000);
SELECT * FROM departamento;

-- Ejercicio Empleados 2
INSERT INTO departamento (nombre, presupuesto) VALUES ('Marketing', 180000);

-- Ejercicio Empleados 3
INSERT INTO departamento (id, nombre, presupuesto, gastos) VALUES (10, 'Logística', 250000, 15000);

-- Ejercicio Empleados 4
INSERT INTO empleado (id, nif, nombre, apellido1, apellido2, id_departamento) VALUES (14, '98027364T', 'Laura', 'González', 'Rodríguez', 8);
SELECT * FROM empleado;

-- Ejercicio Empleados 5
INSERT INTO empleado (nif, nombre, apellido1, apellido2, id_departamento) VALUES ('17382917S', 'Carlos', 'Martínez', 'Gómez', 9);

-- Ejercicio Empleados 6
CREATE TABLE departamento_backup LIKE departamento;
SELECT * FROM departamento_backup;
INSERT INTO departamento_backup SELECT * FROM departamento;

-- Ejercicio Empleados 7
CREATE TABLE sistemas (nif VARCHAR(9) NOT NULL UNIQUE, nombre VARCHAR(100) NOT NULL UNIQUE, apellido1 VARCHAR(100) NOT NULL, apellido2 VARCHAR(100));
INSERT INTO sistemas 
SELECT nif, nombre, apellido1, apellido2
FROM empleado
WHERE id_departamento =2;
SELECT * FROM sistemas;

-- Ejercicio Empleados 8
INSERT IGNORE INTO empleado
VALUES 	
(NOT NULL, '28457963P', 'Mónica', 'Jiménez', 'Martín', 9),
(NOT NULL, '85463215L', 'Ramón', 'Solís', 'Pérez', 7),
(NOT NULL, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
SELECT * FROM empleado;

-- Ejercicio Empleados 9
DROP TABLE IF EXISTS publicidad;
DROP TABLE IF EXISTS desarrollo;
CREATE TABLE desarrollo (nif_empleado VARCHAR(9) NOT NULL UNIQUE, nombre_empleado VARCHAR(100) NOT NULL UNIQUE, ap1_empleado VARCHAR(100) NOT NULL, ap2_empleado VARCHAR(100), ppto_dep DOUBLE NOT NULL, gasto DOUBLE NOT NULL);
INSERT INTO desarrollo (nif_empleado, nombre_empleado, ap1_empleado, ap2_empleado, ppto_dep, gasto)
SELECT empleado.nif, empleado.nombre, empleado.apellido1, empleado.apellido2, departamento.presupuesto, departamento.gastos 
FROM empleado, departamento
WHERE empleado.id_departamento = 1;
SELECT * FROM publicidad;


