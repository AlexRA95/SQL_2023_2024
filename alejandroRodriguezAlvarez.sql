DROP DATABASE IF EXISTS GESTIÓN_BANCARIA;
CREATE DATABASE GESTIÓN_BANCARIA CHARACTER SET utf8mb4;
USE GESTIÓN_BANCARIA;

CREATE TABLE CLIENTE (
IDCLIENTE INT AUTO_INCREMENT PRIMARY KEY,
DNI VARCHAR (9) NOT NULL UNIQUE,
APELLIDO1 VARCHAR (30) NOT NULL,
APELLIDO2 VARCHAR (30),
NOMBRE VARCHAR (30) NOT NULL,
DOMICILIO VARCHAR (100),
TELÉFONO VARCHAR (20) NOT NULL
) AUTO_INCREMENT = 1001;

CREATE TABLE CUENTA (
IDCLIENTE INT,
IDCUENTA VARCHAR(5) PRIMARY KEY,
SALDO DECIMAL (15,2),
MONEDA VARCHAR (20),
FOREIGN KEY(IDCLIENTE) REFERENCES CLIENTE (IDCLIENTE)
ON UPDATE CASCADE ON DELETE CASCADE
);


/*EJ 1*/
INSERT INTO cliente(dni,apellido1,apellido2,nombre,domicilio,TELÉFONO)values
	('78456321L', 'Martín' ,'Sancho', 'Vera' ,'Calle Ramón y Cajal 23, Mérida', 659784520),
    ('23458796P', 'Pérez', 'Gutiérrez', 'Jorge', 'Calle Santa Eulalia 25, Mérida', 659826321),
    ('56721348K', 'Pérez', 'García', 'Fernando', 'Calle Severo Ochoa 14, Mérida', 698425175),
    ('98632154J', 'García', 'Prieto', 'Alicia', 'Calle Colón 50, Mérida', 632514845),
    ('28546312F', 'Montero', 'Torres', 'Silvia', 'Calle Trajano 47, Mérida', 686975412),
    ('78412562P', 'Fernández', 'Silva', 'Rosa', 'Calle Mayor 12, Calamonte', 600500100),
    ('12347852T', 'Martín', 'Silva', 'Borja', 'Avenida Reina Sofía 23, Mérida', 65698974)
;

SELECT * FROM CLIENTE;

/*EJ 2*/
INSERT IGNORE INTO CUENTA values
	(1001, 'C1001', 1500.00, 'EUR'),
    (1002, 'C1002', 2300.50 ,'USD'),
    (1003, 'C1003', 1800.00, 'EUR'),
    (1004, 'C1004', 3500.75, 'EUR'),
    (1005, 'C1005', 125.00 ,'EUR'),
    (1006, 'C1006' ,1900.00 ,'USD'),
    (1007, 'C1007' ,2600.50, 'EUR'),
    (1008, 'C1008', 125.00, 'EUR')
;

SELECT * FROM CUENTA;

/*EJ 3*/
CREATE TABLE cuentas_dolares(
	IDCLIENTE INT,
	IDCUENTA VARCHAR(5),
	SALDO DECIMAL (15,2)
);

INSERT INTO cuentas_dolares  
	SELECT idcliente,idcuenta,saldo
	FROM CUENTA;
    
SELECT * FROM cuentas_dolares;


/*Ej 4*/
SET AUTOCOMMIT=0;
START TRANSACTION;
UPDATE cuenta
SET saldo=saldo-500
WHERE idcliente=(
	SELECT idcliente
    FROM cliente
    WHERE nombre='Vera' and apellido1='Martín'
);


/*EJ 5*/
ROLLBACK;
SET AUTOCOMMIT=1;


/*EJ 6*/
SET sql_safe_updates=0;
UPDATE cuenta
SET moneda='EUR', saldo=saldo*0.94
WHERE moneda='USD';
SET sql_safe_updates=1;
SELECT * FROM CUENTA;

/*EJ 7*/
SET AUTOCOMMIT=0;
START TRANSACTION ;
SET sql_safe_updates=0;
UPDATE cuenta
SET saldo=saldo+100
WHERE saldo>3000;

savepoint pre50;

UPDATE cuenta
SET saldo=saldo+50
WHERE saldo<200;
SELECT * FROM CUENTA;


/*Ej 8*/
ROLLBACK TO pre50;
SELECT * FROM CUENTA;
SET sql_safe_updates=1;
SET AUTOCOMMIT=1;

/*Ej 9*/
SELECT * FROM CLIENTE;
DELETE ignore FROM cliente
WHERE (nombre='Jorge' or nombre='Fernando') and apellido1='Pérez';

SELECT * FROM CLIENTE;

/*Ej 10*/
CREATE OR REPLACE VIEW informacion_cliente AS
	SELECT cl.dni, concat_WS(' ', cl.nombre,cl.apellido1,cl.apellido2) as nombre_completo, cu.saldo,cu.moneda
    FROM cliente cl
		JOIN cuenta cu
			ON cu.idcliente=cl.idcliente;
;

SELECT * FROM informacion_cliente;

/*EJ 11*/
DROP FUNCTION IF EXISTS calcular_capital;
DELIMITER $
CREATE FUNCTION calcular_capital()
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
 DECLARE total int;
 SET total=0;
 
 SELECT SUM(saldo) into total
 FROM cuenta;
 
 return total;
END $
DELIMITER ;

SELECT calcular_capital();

/*EJ 12*/
DROP PROCEDURE IF EXISTS porcentaje_capital;
DELIMITER $
CREATE PROCEDURE porcentaje_capital(inout dnic VARCHAR(9),out salida VARCHAR(255))
BEGIN
 
	DECLARE pcliente decimal(6,2);
    DECLARE percent decimal(6,2);
    SELECT saldo into pcliente
    FROM cuenta 
    WHERE idcliente=(
		SELECT idcliente
        FROM cliente
        WHERE dni='78456321L'
    );
    
    SET percent= (pcliente*100)/calcular_capital();
    
		IF (percent<10.00) THEN 
			SET salida= 'Cliente básico';
		ELSEIF (percent<25.00) THEN
			SET salida='Cliente medio';
		ELSEIF (percent>25.00) THEN 
			SET salida=  'Cliente VIP';
		ELSE
			SET SALIDA= 'Cliente no encontrado';
		END IF;
        
        SET dnic=concat(percent,'%');
            
END $
DELIMITER ;
SET @dni='78456321L';
CALL porcentaje_capital(@dni,@salida);
SELECT @dni, @salida;


/*Ej 13*/
DROP TABLE IF EXISTS tabla_multiplicar;
CREATE TABLE tabla_multiplicar(
	ID int AUTO_INCREMENT PRIMARY KEY,
    multiplicando int,
    multiplicado int,
    resultado int
)AUTO_INCREMENT = 1;
DROP FUNCTION IF EXISTS MULTIPLICAR;
DELIMITER $
CREATE FUNCTION MULTIPLICAR(num int)
RETURNS boolean
DETERMINISTIC
BEGIN
	DECLARE cont int;
    SET cont=0;
    
	DELETE FROM tabla_multiplicar;
    
    
    if (num <2 or num>10) THEN 
		return false;
	ELSE 
	multi:REPEAT
    
	INSERT INTO tabla_multiplicar(multiplicando,multiplicado,resultado) values
    (num,cont,num*cont);
    SET cont =cont+1;
    UNTIL cont>10
    END REPEAT;
	END IF;
    return true;
    

END $
DELIMITER ;

SELECT MULTIPLICAR(5);
SELECT * FROM tabla_multiplicar;

/*EJ 14*/
/*Las busquedas de esta manera no son eficiente ya que dni al no ser una clave primaria, no cuenta como un indice de busqueda para la base de datos, por lo que acaba buscando en todas las columnas para 
encontrar la que es igual a la que pasamos por paramentros. 
En este caso, si creamos un indice de los DNI por los 4 primeros digitos, la velocidad de busqueda aumentará ya que a partir de ahí, los dni de cada cliente son únicos y así aumentará la velocidad de busqueda */
CREATE INDEX dniINX ON cliente(dni(54));

/*Ej 15*/
/*Esta busqueda tampoco sería eficiente ya que telefono no es una clave primaria, por lo tanto no cuenta como indice de busqueda. Para hacerla más eficiente, habría que crear un indice de busqueda
de telefono por los 4 primeros digitos, ya que en este caso, desde ahí todos los numeros de telefono son unicos, por lo tanto se iría directamente al numero de telefono que se busca.*/
CREATE INDEX tlfINX ON cliente(teléfono(4));