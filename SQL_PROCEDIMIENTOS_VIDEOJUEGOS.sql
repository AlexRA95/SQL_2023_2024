USE videojuegos;

/*EJ 1*/
DROP PROCEDURE IF EXISTS mobas;
DELIMITER $
CREATE PROCEDURE mobas()
BEGIN
SELECT *
FROM juego
WHERE id_genero=(
	SELECT id_genero
    FROM genero
    WHERE nombre_genero='MOBA'
);
END $
DELIMITER ;

CALL mobas();


/*EJ 2*/
DROP PROCEDURE IF EXISTS createSuperCell;
DELIMITER $
CREATE PROCEDURE createSuperCell()
BEGIN
SELECT j.*
FROM juego j
JOIN desarrollador_juego dj
ON dj.id_juego=j.id_juego
WHERE dj.id_desarrollador=(
	SELECT id_desarrollador
    FROM desarrollador
    WHERE nombre_desarrollador='Supercell'
);
END $
DELIMITER ;

CALL createSuperCell;

/*EJ 3*/
DROP PROCEDURE IF EXISTS platPlayStation;
DELIMITER $
CREATE PROCEDURE platPlayStation()
BEGIN

SELECT j.nombre_juego, g.nombre_genero
FROM juego j
JOIN desarrollador_juego dj
ON dj.id_juego=j.id_juego
JOIN plataforma_juego pj
ON pj.id_desarrollador_juego=dj.id_des_juego
JOIN genero g
ON g.id_genero=j.id_genero
WHERE pj.id_plataforma=(
	SELECT id_plataforma
    FROM plataforma
    WHERE nombre_plataforma='PlayStation'
);

END $
DELIMITER ;

CALL platPlayStation;

/*EJ 4*/
DROP PROCEDURE IF EXISTS release2022;
DELIMITER $
CREATE PROCEDURE release2022()
BEGIN

SELECT count(distinct j.id_juego) into @total
FROM juego j
JOIN desarrollador_juego dj
ON dj.id_juego=j.id_juego
JOIN plataforma_juego pj
ON pj.id_desarrollador_juego=dj.id_des_juego
WHERE anio_lanzamiento=2022;

END $
DELIMITER ;

CALL release2022;
SELECT @total;

/*EJ 5*/
DROP PROCEDURE IF EXISTS percent2022;
DELIMITER $
CREATE PROCEDURE percent2022()
BEGIN

SELECT (100*@total/COUNT(distinct id_desarrollador_juego)) as porciento
FROM plataforma_juego;

END $
DELIMITER ;

CALL percent2022;

/*EJ 6*/
DROP PROCEDURE IF EXISTS entrada_entrada_salida;
DELIMITER $
CREATE PROCEDURE entrada_entrada_salida(in ent1 varchar(255),in ent2 varchar(255),out sali varchar(255))
BEGIN

SET sali=concat(ent1,ent2);

END $
DELIMITER ;
CALL entrada_entrada_salida("hola"," que tal",@salida);
SELECT @salida;

/*EJ 7*/
DROP PROCEDURE IF EXISTS cuantos_hay_genero;
DELIMITER $
CREATE PROCEDURE cuantos_hay_genero(in gen varchar(255),out salida varchar(255))
BEGIN

	SELECT count(id_juego) into salida
    FROM juego j
		JOIN genero g
			ON g.id_genero=j.id_genero
	WHERE g.nombre_genero=gen;

END $
DELIMITER ;
CALL cuantos_hay_genero("MOBA",@salida);
SELECT @salida;

/*EJ 8*/
DROP PROCEDURE IF EXISTS nombre_juego_genero;
DELIMITER $
CREATE PROCEDURE nombre_juego_genero(in nombre varchar(255),out salida varchar(255))
BEGIN

	SELECT concat_ws(" ,",j.nombre_juego,g.nombre_genero) into salida
    FROM juego j
		JOIN genero g
			ON g.id_genero=j.id_genero
		WHERE j.nombre_juego=nombre;

END $
DELIMITER ;
CALL nombre_juego_genero("Sekiro: Shadows Die Twice",@salida);
SELECT @salida;

/*EJ 9*/
DROP PROCEDURE IF EXISTS juegos_plataforma_entre_fechas;
DELIMITER $
CREATE PROCEDURE juegos_plataforma_entre_fechas(in plataforma varchar(255),in anoInicio int, in anoFin int, out salida int)
BEGIN

	SELECT count(*) into salida
    FROM plataforma_juego pj
		JOIN plataforma p ON p.id_plataforma=pj.id_plataforma
        WHERE (anio_lanzamiento<anoFIN OR anio_lanzamiento>anoInicio) AND nombre_plataforma=plataforma;

END $
DELIMITER ;
CALL juegos_plataforma_entre_fechas("PC",2014,2022,@salida);
SELECT @salida;

/*EJ 10*/
DROP PROCEDURE IF EXISTS juegos_desarrollador;
DELIMITER $
CREATE PROCEDURE juegos_desarrollador(in developer varchar(255), out salida int)
BEGIN

	SELECT count(*) into salida
		FROM juego j
			JOIN desarrollador_juego dj ON dj.id_juego=j.id_juego
			JOIN desarrollador d ON d.id_desarrollador=dj.id_desarrollador
	WHERE nombre_desarrollador=developer;

END $
DELIMITER ;
CALL juegos_desarrollador("FromSoftware",@salida);
SELECT @salida;

/*EJ 11*/
DROP PROCEDURE IF EXISTS nuevo_nombre_developer;
DELIMITER $
CREATE PROCEDURE nuevo_nombre_developer(in idDev int, in newName varchar(255))
BEGIN

	UPDATE desarrollador
    SET nombre_desarrollador=newName
    WHERE id_desarrollador=idDev;

END $
DELIMITER ;
CALL nuevo_nombre_developer(7,"Monolith Soft");
SELECT * FROM desarrollador;

/*EJ 12*/
DROP PROCEDURE IF EXISTS que_trimestre;
DELIMITER $
CREATE PROCEDURE que_trimestre(in num int, out trimestre varchar(255))
BEGIN
		if num between 1 and 4 THEN
			set trimestre="1º trimestre";
        elseif num between 5 and 8 THEN 
			set trimestre="2º trimestre";
		elseif num between 9 and 12 THEN 
			set trimestre="3º trimestre";
		else
			set trimestre="ERROR";
		end if;
END $
DELIMITER ;
CALL que_trimestre(12,@salida);
SELECT @salida;

/*EJ 13*/
DROP PROCEDURE IF EXISTS cuantos_juegos_dev_plat;
DELIMITER $
CREATE PROCEDURE cuantos_juegos_dev_plat(in dev varchar(255), in plat varchar(255),out salida varchar(255))
BEGIN
	DECLARE  test int;

	SELECT count(*) into test
		FROM desarrollador_juego dj
			JOIN plataforma_juego pj ON dj.id_des_juego=pj.id_desarrollador_juego
		WHERE pj.id_plataforma=(
			SELECT id_plataforma 
            FROM plataforma
            WHERE nombre_plataforma=plat
        ) AND dj.id_desarrollador=(
			SELECT id_desarrollador
            FROM desarrollador
            WHERE nombre_desarrollador=dev
        );
        if test=0 then set salida='No hay desarrollado ninguno';
        else set salida=concat('El desarrollador ',dev, ' ha publicado ', test, ' juegos para la plataforma ', plat);
        end if;

END $
DELIMITER ;
CALL cuantos_juegos_dev_plat('Supercell','Mobile',@salida);
SELECT @salida;

/*EJ 14*/
DROP PROCEDURE IF EXISTS pegi;
DELIMITER $
CREATE PROCEDURE pegi(in juego varchar(255), out salida varchar(255))
BEGIN
	DECLARE test varchar(255);
	
	SELECT nombre_genero into test
		FROM genero g
			JOIN juego j ON j.id_genero=g.id_genero
	WHERE nombre_juego=juego;
    
    CASE test
        WHEN 'Estrategia' THEN SET salida = 'Edad recomendada --> 7';
        WHEN 'MOBA' THEN SET salida = 'Edad recomendada --> 13';
        WHEN 'ARPG' THEN SET salida = 'Edad recomendada --> 16';
        WHEN 'Mundo abierto' THEN SET salida = 'Edad recomendada --> 18';
    END CASE;

END $
DELIMITER ;
CALL pegi('League of Legends',@salida);
SELECT @salida;

/*EJ 15*/
DROP PROCEDURE IF EXISTS anio_plat_num_juegos;
DELIMITER $
CREATE PROCEDURE anio_plat_num_juegos(in plat varchar(255),in anio int, out salida varchar(255))
BEGIN
	DECLARE test int;
	
	SELECT count(*) into test
		FROM plataforma_juego pj
	WHERE anio_lanzamiento<anio AND id_plataforma=(
		SELECT id_plataforma
        FROM plataforma
        WHERE nombre_plataforma=plat
    );
    
    if test=0 then set salida='No hay juego para la plataforma ' + plat +' antes del año ' + anio;
        else set salida=test;
        end if;
END $
DELIMITER ;
CALL anio_plat_num_juegos('Mobile',2022,@salida);
SELECT @salida;

/*EJ 16*/
DROP PROCEDURE IF EXISTS cant_plat;
DELIMITER $
CREATE PROCEDURE cant_plat(in juego varchar(255), out salida varchar(255))
BEGIN
DECLARE test int;
	SELECT count(*) into test
    FROM juego j
		JOIN desarrollador_juego dj 
			ON j.id_juego=dj.id_juego
		JOIN plataforma_juego pj 
			ON pj.id_desarrollador_juego=dj.id_des_juego
		WHERE j.nombre_juego='Sekiro: Shadows Die Twice';
        
        CASE test
        WHEN 1 THEN SET salida = 'Pocas';
        WHEN 2 THEN SET salida = 'Algunas';
        WHEN 3 THEN SET salida = 'Muchas';
        ELSE SET salida = 'No ha salido en ninguna plataforma';
    END CASE;
END $
DELIMITER ;
CALL cant_plat('Sekiro: Shadows Die Twice',@salida);
SELECT @salida as 'Plataforma';

/*EJ 17*/
SET SQL_SAFE_UPDATES = 0;
DROP PROCEDURE IF EXISTS add_edad_reco;
DELIMITER $
CREATE PROCEDURE add_edad_reco(in juego varchar(255))
BEGIN
	DECLARE test varchar(255);
    DECLARE salida int;
	
	SELECT nombre_genero into test
		FROM genero g
			JOIN juego j ON j.id_genero=g.id_genero
	WHERE nombre_juego=juego;
    
    CASE test
        WHEN 'Estrategia' THEN SET salida = '7';
        WHEN 'MOBA' THEN SET salida = '13';
        WHEN 'ARPG' THEN SET salida = '16';
        WHEN 'Mundo abierto' THEN SET salida = '18';
    END CASE;
    
    UPDATE juego
    SET edad_recomendada=salida
    WHERE nombre_juego=juego;

END $
DELIMITER ;
CALL add_edad_reco('Hearthstone');
CALL add_edad_reco('Clash Royale');
CALL add_edad_reco('Brawl Stars');
CALL add_edad_reco('Elden Ring');
CALL add_edad_reco('Sekiro: Shadows Die Twice');
CALL add_edad_reco('Horizon Forbidden West');
CALL add_edad_reco('The legend of Zelda: Breath of the wild');
SELECT * FROM juego;
SET SQL_SAFE_UPDATES = 1;


/*EJ 18*/
DROP PROCEDURE IF EXISTS rango_edad;
DELIMITER $
CREATE PROCEDURE rango_edad()
BEGIN
	
    SELECT nombre_juego,edad_recomendada, IF(edad_recomendada>=18,'Adultos','Otros')
    FROM juego;

END $
DELIMITER ;
CALL rango_edad();

/*EJ 19*/
DROP PROCEDURE IF EXISTS antiguedad;
DELIMITER $
CREATE PROCEDURE antiguedad()
BEGIN
	
	SELECT j.nombre_juego,d.nombre_desarrollador, p.nombre_plataforma, pj.anio_lanzamiento,
    CASE
		WHEN anio_lanzamiento <= 2015 then 'Antiguo'
        WHEN anio_lanzamiento <= 2020  then 'Moderno'
        ELSE 'Nuevo'
	END 'Antiguedad'
    FROM juego j
		JOIN desarrollador_juego dj ON dj.id_juego=j.id_juego
        JOIN desarrollador d ON dj.id_desarrollador=d.id_desarrollador
        JOIN plataforma_juego pj ON pj.id_desarrollador_juego=dj.id_des_juego
        JOIN plataforma p ON p.id_plataforma=pj.id_plataforma;

END $
DELIMITER ;
CALL antiguedad();

/*EJ 20*/
DROP PROCEDURE IF EXISTS des_gen;
DELIMITER $
CREATE PROCEDURE des_gen(in des varchar(255), in gen varchar(255), out salida varchar(255))
BEGIN

	SELECT IF(count(*)<>0, concat_ws(" ", "El desarrollador",des,"ha creado", count(*), "juegos del genero", gen ), concat_ws(" ", "El desarrollador",des,"no ha desarrollador ningun juegos del genero", gen )) INTO salida
    FROM juego j
		JOIN genero g ON j.id_genero=g.id_genero
		JOIN desarrollador_juego dj ON dj.id_juego=j.id_juego
        JOIN desarrollador d ON dj.id_desarrollador=d.id_desarrollador
	WHERE d.nombre_desarrollador=des AND g.nombre_genero=gen;
    
END $
DELIMITER ;
CALL des_gen("FromSoftware", "ARPG", @salida);
SELECT @salida;


/*EJ 21*/
DROP PROCEDURE IF EXISTS get_edad_reco;
DELIMITER $
CREATE PROCEDURE get_edad_reco()
BEGIN

	SELECT nombre_juego, IFNULL(edad_recomendada,'99')
    FROM juego;
    
END $
DELIMITER ;
CALL get_edad_reco();

/*EJ 22*/
SET SQL_SAFE_UPDATES = 0;
DROP PROCEDURE IF EXISTS set_edad_reco;
DELIMITER $
CREATE PROCEDURE set_edad_reco(in juego varchar(255))
BEGIN

	DECLARE test varchar(255);
    DECLARE salida int;
	
	SELECT nombre_genero into test
		FROM genero g
			JOIN juego j ON j.id_genero=g.id_genero
	WHERE nombre_juego=juego;
    
    
    UPDATE juego
    SET edad_recomendada= CASE 
		WHEN test='Estrategia' THEN '7'
		WHEN test= 'MOBA' THEN '13'
		WHEN test= 'ARPG' THEN '16'
        WHEN test= 'Mundo abierto' THEN '18'
    END
    WHERE nombre_juego=juego;
    
END $
DELIMITER ;
CALL set_edad_reco("Elden Ring");
SELECT * FROM juego;
SET SQL_SAFE_UPDATES = 1;

/*EJ 23*/
SET SQL_SAFE_UPDATES = 0;
DROP PROCEDURE IF EXISTS set_exact_edad_reco;
DELIMITER $
CREATE PROCEDURE set_exact_edad_reco(in juego varchar(255), in edad varchar(255))
BEGIN
    
    UPDATE juego
    SET edad_recomendada=IFNULL(edad_recomendada,edad)
    WHERE nombre_juego=juego;
    
END $
DELIMITER ;
CALL set_exact_edad_reco("Elden Ring",99);
SELECT * FROM juego;
SET SQL_SAFE_UPDATES = 1;

/*EJ 24*/
DROP PROCEDURE IF EXISTS same_gen;
DELIMITER $
CREATE PROCEDURE same_gen(in gen varchar(255))
BEGIN
    
    	SELECT j.nombre_juego, NULLIF(g.nombre_genero,gen) 
		FROM juego j
		JOIN genero g ON j.id_genero=g.id_genero;
    
END $
DELIMITER ;
CALL same_gen("ARPG");