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

SELECT (100*@total/COUNT(*)) as porciento
FROM plataforma_juego;

END $
DELIMITER ;

CALL percent2022;
