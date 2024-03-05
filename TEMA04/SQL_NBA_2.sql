USE NBA;

/*GROUP BY*/
/*EJ 1*/
SELECT COUNT(codigo)
FROM jugadores
GROUP BY nombre_equipo;

/*EJ 2*/
SELECT nombre_equipo
FROM jugadores
GROUP BY nombre_equipo
HAVING COUNT(codigo)>=15;

/*EJ 3*/
SELECT j.nombre, SUM(e.puntos_por_partido)
FROM jugadores j
	LEFT JOIN estadisticas e
		ON j.codigo=e.jugador
GROUP BY j.codigo
ORDER BY j.nombre;

/*EJ 4*/
SELECT j.codigo, j.nombre, MAX(e.puntos_por_partido)
FROM jugadores j
	LEFT JOIN estadisticas e
		ON j.codigo=e.jugador
GROUP BY j.codigo
ORDER BY MAX(e.puntos_por_partido) DESC
LIMIT 1;

/*EJ 5*/
SELECT p.codigo, p.equipo_local, p.equipo_visitante, (p.puntos_local-p.puntos_visitante) AS 'diferencia'
FROM partidos p
	LEFT JOIN equipos e
    ON e.nombre=p.equipo_local OR e.nombre=p.equipo_visitante
WHERE p.temporada='03/04'
GROUP BY p.codigo;

/*EJ 6*/
SELECT TRUNCATE(AVG(peso), 2)
FROM jugadores j
GROUP BY posicion;

/*EJ 7*/
SELECT j.nombre_equipo, SUM(e.asistencias_por_partido), SUM(e.rebotes_por_partido)
FROM estadisticas e
        LEFT JOIN jugadores j
			ON j.codigo=e.jugador
WHERE e.temporada='98/99'
GROUP BY j.nombre_equipo;

/*EJ 8*/
SELECT j.nombre, AVG(e.puntos_por_partido), AVG(e.asistencias_por_partido), AVG(e.rebotes_por_partido)
FROM jugadores j
        LEFT JOIN estadisticas e
			ON j.codigo=e.jugador
		LEFT JOIN equipos eq
			ON eq.nombre=j.nombre_equipo
WHERE eq.ciudad='Boston'
GROUP BY j.codigo;

/*EJ 9*/
SELECT e.nombre
FROM equipos e
	LEFT JOIN partidos p
		ON e.nombre=p.equipo_local OR e.nombre=p.equipo_visitante
WHERE p.temporada='02/03' AND p.codigo IS NULL
GROUP BY e.nombre; 

/*EJ 10*/
SELECT j.nombre_equipo, TRUNCATE(SUM(e.tapones_por_partido),3)
FROM jugadores j
	LEFT JOIN estadisticas e
		ON j.codigo=e.jugador
WHERE e.temporada='05/06'
GROUP BY j.nombre_equipo
ORDER BY SUM(e.tapones_por_partido) DESC
LIMIT 1;