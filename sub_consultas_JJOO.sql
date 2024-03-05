USE juegos_olimpicos;

/*EJ 1*/
SELECT anio_juegos
FROM juegos
WHERE id=(
	SELECT id_juegos
    FROM ciudad_juegos
    WHERE id_ciudad=(
		SELECT id
        FROM ciudad
        WHERE nombre_ciudad='Barcelona'
    )
);

/*EJ 2*/
SELECT p.*, rn.nombre_region
FROM persona p JOIN region_persona r
ON p.id=r.id_persona
JOIN region_noc rn
ON r.id_region=rn.id
WHERE peso=(
	SELECT MAX(peso)
    FROM persona
);

/*Ej 3*/
SELECT ju.nombre_juegos, ju.anio_juegos
FROM juegos ju JOIN (
	SELECT id_juegos, COUNT(distinct id_ciudad)
    FROM ciudad_juegos
    GROUP BY id_juegos
    HAVING COUNT( distinct id_ciudad)>2
) AS j
ON j.id_juegos=ju.id;

/*EJ 4*/
SELECT nombre_completo, altura
FROM persona
WHERE altura>(
	SELECT AVG(altura)
    FROM persona
    WHERE genero='F'
) AND genero='F'
ORDER BY altura desc, nombre_completo;

/*EJ 5*/
SELECT nombre_completo, altura,(
	SELECT AVG(altura)
    FROM persona
    WHERE genero='F'
) AS 'Altura media'
FROM persona
WHERE altura>(
	SELECT AVG(altura)
    FROM persona
    WHERE genero='F'
) AND genero='F'
ORDER BY altura desc, nombre_completo;

/*EJ 6*/
SELECT p.nombre_completo, p.genero, de.nombre_deporte
FROM persona p
JOIN competidor_juegos cj
ON cj.id_persona=p.id
JOIN competidor_evento ce
ON cj.id=ce.id_competidor
JOIN evento e
ON e.id=ce.id_evento
JOIN deporte de
ON e.id_deporte=de.id
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rn
ON rn.id=rp.id_region
JOIN juegos ju
ON ju.id=cj.id_juegos
JOIN medalla me
ON me.id=ce.id_medalla
WHERE rn.noc='ESP' AND ju.nombre_juegos='2016 verano' AND me.nombre_medalla='Oro';

/*EJ 7*/
SELECT (
	SELECT COUNT(temporada)
    FROM juegos
    WHERE temporada='Verano'
) AS 'Juegos Verano',(
	SELECT COUNT(temporada)
    FROM juegos
    WHERE temporada='Invierno'
) AS 'Juegos invierno';

/*EJ 8*/
SELECT p.nombre_completo, me.nombre_medalla, e.nombre_evento
FROM persona p
JOIN competidor_juegos cj
ON cj.id_persona=p.id
JOIN competidor_evento ce
ON cj.id=ce.id_competidor
JOIN evento e
ON e.id=ce.id_evento
JOIN deporte de
ON e.id_deporte=de.id
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rn
ON rn.id=rp.id_region
JOIN juegos ju
ON ju.id=cj.id_juegos
JOIN medalla me
ON me.id=ce.id_medalla
WHERE p.nombre_completo='Mireia Belmonte Garca' AND ju.nombre_juegos='2016 verano';

/*EJ 9*/
SELECT nombre_completo
FROM persona p
JOIN (
	SELECT id_persona, COUNT(id_region)
    FROM region_persona
    GROUP BY id_persona
    HAVING COUNT(id_region)>=4
) AS sub
ON sub.id_persona=p.id;

/*EJ 10*/
SELECT p.nombre_completo, rn.nombre_region
FROM persona p
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rn
ON rn.id=rp.id_region
JOIN competidor_juegos cj
ON cj.id_persona=p.id
JOIN juegos ju
ON ju.id=cj.id_juegos
WHERE ju.nombre_juegos='1928 invierno' AND cj.edad='23';

/*EJ 11*/
SELECT AVG(cj.edad) AS 'Media de edad'
FROM competidor_juegos cj
JOIN juegos j
ON cj.id_juegos=j.id
JOIN persona p
ON cj.id_persona=p.id
JOIN region_persona rp
ON rp.id_persona=p.id
WHERE j.nombre_juegos='1992 verano' AND rp.id_region=(
	SELECT id
    FROM region_noc
    WHERE nombre_region='España'
);

/*EJ 12*/
SELECT me.nombre_medalla, COUNT(*) AS Recuento
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN medalla me
ON me.id=ce.id_medalla
JOIN persona p
ON p.id=cj.id_persona
WHERE p.nombre_completo='Ruth Beita Vila' AND id_medalla<>(
	SELECT id
    FROM medalla
    WHERE nombre_medalla='NA'
)
GROUP BY ce.id_medalla;

/*EJ 13*/
SELECT me.nombre_medalla, e.nombre_evento,COUNT(*) AS Recuento
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN medalla me
ON me.id=ce.id_medalla
JOIN persona p
ON p.id=cj.id_persona
JOIN evento e
ON e.id=ce.id_evento
WHERE p.nombre_completo='Serena Jamika Williams' AND id_medalla<>(
	SELECT id
    FROM medalla
    WHERE nombre_medalla='NA'
)
GROUP BY ce.id_medalla, ce.id_evento;

/*EJ 14*/
SELECT j.anio_juegos, ciu.nombre_ciudad, p.nombre_completo
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN evento e
ON e.id=ce.id_evento
JOIN juegos j
ON j.id=cj.id_juegos
JOIN ciudad_juegos cij
ON cij.id_juegos=j.id
JOIN ciudad ciu
ON ciu.id=cij.id_ciudad
JOIN persona p
ON p.id=cj.id_persona
JOIN medalla me
ON me.id=ce.id_medalla
WHERE e.nombre_evento='Tennis Mixed Doubles' AND id_medalla<>(
	SELECT id
    FROM medalla
    WHERE nombre_medalla='NA'
)
ORDER BY j.anio_juegos DESC, ce.id_medalla;

/*EJ 15*/
SELECT rnoc.nombre_region, COUNT( distinct ce.id_evento) as num_medallas
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN persona p
ON cj.id_persona=p.id
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rnoc
ON rnoc.id=rp.id_region
JOIN juegos j
ON j.id=cj.id_juegos
WHERE id_medalla<>(
	SELECT id
    FROM medalla
    WHERE nombre_medalla='NA'
) AND j.nombre_juegos='2016 verano'
GROUP BY rp.id_region
ORDER BY num_medallas desc;

/*EJ 16*/
SELECT p.nombre_completo
FROM competidor_juegos cj
JOIN persona p
ON cj.id_persona=p.id
GROUP BY cj.id_persona
HAVING COUNT(cj.id_juegos)>7;

/*EJ 17*/
SELECT p.nombre_completo
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN persona p
ON cj.id_persona=p.id
JOIN juegos j
ON j.id=cj.id_juegos
WHERE id_medalla<>(
	SELECT id
    FROM medalla
    WHERE nombre_medalla='NA'
) AND j.nombre_juegos='2016 verano'
GROUP BY cj.id_persona
HAVING COUNT(id_medalla)>=5
ORDER BY COUNT(id_medalla) desc;

/*EJ 18*/
SELECT rnoc.nombre_region, AVG(cj.edad)
FROM competidor_juegos cj
JOIN persona p
ON cj.id_persona=p.id
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rnoc
ON rnoc.id=rp.id_region
JOIN juegos j
ON j.id=cj.id_juegos
WHERE rnoc.nombre_region='Australia' AND j.nombre_juegos='1948 verano';

/*EJ 19*/
SELECT p.nombre_completo, COUNT(ce.id_medalla)
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN persona p
ON cj.id_persona=p.id
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rnoc
ON rnoc.id=rp.id_region
JOIN juegos j
ON j.id=cj.id_juegos
WHERE rnoc.nombre_region='España'AND id_medalla<>(
	SELECT id
    FROM medalla
    WHERE nombre_medalla='NA'
)
GROUP BY ce.id_medalla,ce.id_competidor
ORDER BY p.nombre_completo;

/*Ej 20*/
SELECT AVG(cj.edad)
FROM competidor_juegos cj
JOIN competidor_evento ce
ON ce.id_competidor=cj.id
JOIN evento e
ON e.id=ce.id_evento
WHERE e.id_deporte=(
	SELECT id
    FROM deporte
    WHERE nombre_deporte='Tiro con arco'
);

/*EJ 21*/
SELECT p.nombre_completo, sub.media, rnoc.nombre_region
FROM persona p
JOIN region_persona rp
ON rp.id_persona=p.id
JOIN region_noc rnoc
ON rnoc.id=rp.id_region
JOIN (
	SELECT id_region AS region, MAX(p.altura) as media
    FROM region_persona rp
    JOIN persona p
	ON rp.id_persona=p.id
    GROUP BY region
) AS sub
ON sub.region=rp.id_region
WHERE p.altura>=sub.media
ORDER BY rnoc.nombre_region;