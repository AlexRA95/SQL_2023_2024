USE NBA;

/*EJ 1*/
SELECT j.nombre, e.nombre, e.conferencia, e.division
FROM jugadores j JOIN equipos e
ON j.nombre_equipo=e.nombre
WHERE j.altura=(
	SELECT MAX(altura)
    FROM jugadores
);

/*EJ 2*/
SELECT AVG(puntos_por_partido)
FROM estadisticas
WHERE temporada='04/05' AND jugador= ANY(
	SELECT codigo
    FROM jugadores j JOIN estadisticas e
    ON j.codigo=e.jugador
    WHERE asistencias_por_partido>10
);

/*EJ 3*/
SELECT nombre
FROM jugadores
WHERE nombre_equipo= ANY(
	SELECT nombre
    FROM equipos
    WHERE conferencia='West'
);

/*EJ 4*/
SELECT j.nombre, e.nombre
FROM jugadores j JOIN (
	SELECT nombre
    FROM equipos
) AS e
ON j.nombre_equipo=e.nombre;