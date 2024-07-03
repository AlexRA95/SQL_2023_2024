USE videojuegos;

/*EJ 30*/
DROP FUNCTION IF EXISTS ej30;
DELIMITER $
CREATE FUNCTION ej30(fecha1 date, fecha2 date)
RETURNS DATE
DETERMINISTIC
BEGIN
	IF (fecha1>fecha2) THEN
		RETURN fecha1;
	ELSE RETURN fecha2;
    END IF;
END $
DELIMITER ;

SELECT ej30('1111-12-25', '2024-05-03') as fecha_mayor;

/*EJ 31*/
DROP FUNCTION IF EXISTS ej31;
DELIMITER $
CREATE FUNCTION ej31(juego varchar(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE salida varchar(255);
	SELECT g.nombre_genero into salida
    FROM juego j
		JOIN genero g ON j.id_genero=g.id_genero
	WHERE j.nombre_juego=juego;
    
    RETURN salida;

END $
DELIMITER ;

SELECT ej31('League of Legends') as genero;

/*EJ 32*/
DROP FUNCTION IF EXISTS ej32;
DELIMITER $
CREATE FUNCTION ej32(juego varchar(255))
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE resul int;
	SELECT count(distinct id_plataforma) into resul
    FROM genero g
		JOIN juego j
			ON j.id_genero=g.id_genero
		JOIN desarrollador_juego dj
			ON dj.id_juego=j.id_juego
		JOIN plataforma_juego pj
			ON pj.id_desarrollador_juego=dj.id_des_juego
		WHERE j.nombre_juego=juego;
        
        RETURN resul;
END $
DELIMITER ;

SELECT ej32('League of Legends') as num_plataforma;


/*EJ 33*/
DROP FUNCTION IF EXISTS ej33_1;
DELIMITER $
CREATE FUNCTION ej33_1(juego varchar(255))
RETURNS VARCHAR(255) 
DETERMINISTIC
BEGIN
	IF(ej32(juego)=1) THEN
		RETURN 'UNA';
	ELSEIF (ej32(juego)>1)THEN
		RETURN 'MUCHAS';
    END IF;
END $
DELIMITER ;


DROP PROCEDURE IF EXISTS ej33_2;
DELIMITER $
CREATE PROCEDURE ej33_2()
BEGIN

	SELECT nombre_juego, ej33_1(nombre_juego) as cantidad_plataformas
    FROM juego;

END $
DELIMITER ;

CALL ej33_2;

/*EJ 34*/
DROP FUNCTION IF EXISTS ej34;
DELIMITER $
CREATE FUNCTION ej34(plat varchar(255))
RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE total int;
    DECLARE unic int;
    
    SELECT count(*) into total
		FROM juego j
		JOIN desarrollador_juego dj
			ON dj.id_juego=j.id_juego
		JOIN plataforma_juego pj
			ON pj.id_desarrollador_juego=dj.id_des_juego
		JOIN plataforma p
			ON p.id_plataforma=pj.id_plataforma;
    
   SELECT count(*) into unic
		FROM juego j
		JOIN desarrollador_juego dj
			ON dj.id_juego=j.id_juego
		JOIN plataforma_juego pj
			ON pj.id_desarrollador_juego=dj.id_des_juego
		JOIN plataforma p
			ON p.id_plataforma=pj.id_plataforma
		WHERE nombre_plataforma=plat;
        
        RETURN (100*unic)/total;
    
END $
DELIMITER ;

SELECT ej34('PC') as porcentaje_plataforma;


/*EJ 35*/
DROP FUNCTION IF EXISTS ej35_1;
DELIMITER $
CREATE FUNCTION ej35_1(genero varchar(255))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE edad_recomendada int;
    
		SET edad_recomendada= CASE 
		WHEN genero='Estrategia' THEN '7'
		WHEN genero= 'MOBA' THEN '13'
		WHEN genero= 'ARPG' THEN '16'
        WHEN genero= 'Mundo abierto' THEN '18'
    END;
    
    RETURN edad_recomendada;

END $
DELIMITER ;


DROP PROCEDURE IF EXISTS ej35_2;
DELIMITER $
CREATE PROCEDURE ej35_2()
BEGIN
	SELECT j.*, ej35_1(g.nombre_genero)
    FROM juego j
		JOIN genero g
			ON j.id_genero=g.id_genero;

END $
DELIMITER ;

CALL ej35_2;