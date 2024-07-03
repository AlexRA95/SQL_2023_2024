USE videojuegos;

/*EJ 25*/
DROP PROCEDURE IF EXISTS ej25;
DELIMITER $
CREATE PROCEDURE ej25(in num int)
BEGIN
	Declare resul VARCHAR(250);
    DECLARE cont int;
    DECLARE test int;
    SET resul='';
    SET cont=0;
    SET test=0;
    
    salir: WHILE cont<=num DO
    SET test=test+cont;
	SET cont=cont+1;
	END WHILE salir;
    SELECT test;
END $
DELIMITER ;

CALL ej25(5);

/*EJ 26*/
DROP PROCEDURE IF EXISTS ej26;
DELIMITER $
CREATE PROCEDURE ej26(in num int)
BEGIN
    DECLARE cont int;
    DECLARE test double;
    SET cont=2;
    SET test=0.0;
    
    
    salir: REPEAT 
    IF (num=0) THEN
		LEAVE salir;
	END IF;
		SET test=test+(1/cont);
		SET cont=cont+1;
        UNTIL cont=num+2
    END REPEAT;
    
    SELECT test;
END $
DELIMITER ;

CALL ej26(2);

/*EJ 27*/
DROP PROCEDURE IF EXISTS ej27;
DELIMITER $
CREATE PROCEDURE ej27(in num int, out salida int)
BEGIN
	DECLARE cont int;
    DECLARE test int;
    SET cont=2;
    SET test=0;
    
    salir: REPEAT
		IF((num=1) OR (num=2)) THEN
			SET test=1;
            SET cont=num;
        ELSEIF (num%cont=0) THEN 
			SET test=0;
            SET cont=num;
		ELSE SET test=1;
        END IF;
        SET cont=cont+1;
        UNTIL cont>=num
    END REPEAT;
    SELECT test into salida;
    
END $
DELIMITER ;

CALL ej27(7, @salida);
SELECT @salida;


/*EJ 28*/
DROP PROCEDURE IF EXISTS ej28;
DELIMITER $
CREATE PROCEDURE ej28(in fin int)
BEGIN
	DECLARE cont int;
    DECLARE primos int;
    DECLARE test int;
    DECLARE suma int;
    SET primos=0;
    SET cont=1;
    SET test=0;
    SET suma=0;
    
    salir: REPEAT
		Call ej27(cont, test);
		IF(test=1) THEN
			Set suma=suma+cont;
            SET primos=primos+1;
		END IF;
        SET cont=cont+1;
        UNTIL primos>=fin
    END REPEAT;
    SELECT suma;
    
END $
DELIMITER ;
CALL ej28(5);


/*EJ 29*/
DROP PROCEDURE IF EXISTS ej29;
DELIMITER $
CREATE PROCEDURE ej29(in num int, out total int)
BEGIN
	DECLARE cont int;
    DECLARE test int;
    SET cont=0;
    SET test=0;
    DROP TABLE IF EXISTS primos;
	CREATE TABLE primos(
		id int primary key auto_increment,
        numero int
    );
    
    salir : LOOP
    CALL ej27(cont,test);
    IF (test=1)THEN
		INSERT INTO primos(numero) values
		(cont);
    END IF;
    IF (cont=num) THEN
		LEAVE salir;
    END IF;
    SET cont=cont+1;
    END LOOP;
    
    SELECT count(*) into total
    FROM primos;

END $
DELIMITER ;

CALL ej29(10,@salida);
SELECT @salida;
SELECT * FROM primos;