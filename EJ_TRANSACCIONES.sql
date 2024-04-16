SET AUTOCOMMIT = 1;
SELECT @@AUTOCOMMIT;
DROP DATABASE IF EXISTS test;
CREATE DATABASE test CHARACTER SET utf8mb4;
USE test;
CREATE TABLE producto (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE
);
INSERT INTO producto (id, nombre) VALUES (1, 'Primero');
INSERT INTO producto (id, nombre) VALUES (2, 'Segundo');
INSERT INTO producto (id, nombre) VALUES (3, 'Tercero');


/*EJ 1*/
SELECT * FROM producto;

/*EJ 2*/
ROLLBACK;

/*EJ 3*/
START TRANSACTION;
INSERT INTO producto (id, nombre) VALUES (4, 'Cuarto');
ROLLBACK;

/*EJ 4*/
INSERT INTO producto (id, nombre) VALUES (5, 'Quinto');
ROLLBACK;

/*EJ 5*/
SELECT * FROM producto; /*Como hay autocommit, la transación se ha comiteado nada más hacerse pq no se ha declarado que se abriera*/

/*EJ 6*/
SET AUTOCOMMIT = 0;
SELECT @@AUTOCOMMIT;

DELETE FROM producto;

/*ej 7*/
INSERT INTO producto (id, nombre) VALUES (6, 'Sexto');
INSERT INTO producto (id, nombre) VALUES (7, 'Septimo');

/*EJ 8*/
ROLLBACK;
SELECT * FROM producto; /*Todo vuelve al estado anterior a quitar el autocommit*/

/*EJ 9*/
CREATE TABLE fabricante(
	id INT UNSIGNED,
    nombre VARCHAR(20)
);

INSERT INTO fabricante VALUES(1,'algo');

SELECT * FROM fabricante;
ROLLBACK;

/*EJ 10*/
/*La tabla fabricante existe pero está vacía ya que el rollback afecta a los insert, update y delete pero no a los create*/


/*
SELECT @@transaction_isolation;
SELECT @@session.transaction_isolation;
SELECT @@global.transaction_isolation;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
*/