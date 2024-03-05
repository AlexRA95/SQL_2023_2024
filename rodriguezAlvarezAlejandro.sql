USE universidad;

/*EJ 1*/
SELECT pe.nif, concat_ws(" " ,pe.nombre, pe.apellido1, pe.apellido2) AS nombre_completo, MONTH(fecha_nacimiento) AS 'Mes nacimiento', YEAR(fecha_nacimiento) AS 'Año de nacimiento'
FROM persona pe 
	LEFT JOIN profesor pr
		ON pr.id_profesor=pe.id
WHERE pr.id_profesor IS NULL AND YEAR(fecha_nacimiento)='1999'
ORDER BY nombre_completo, YEAR(fecha_nacimiento);

/*EJ 2*/
SELECT pr.*,pe.*
FROM profesor pr
	LEFT JOIN persona pe
		ON pr.id_profesor=pe.id
WHERE pe.telefono IS NULL AND pe.nif LIKE ('%K');

/*EJ 3*/
SELECT concat_ws(" " ,pe.nombre, pe.apellido1, pe.apellido2) AS nombre_completo, asi.nombre, CONCAT_WS("-", ce.anyo_inicio, ce.anyo_fin) AS curso_escolar
FROM alumno_se_matricula_asignatura alm
	LEFT JOIN persona pe
		ON alm.id_alumno=pe.id
	LEFT JOIN curso_escolar ce
		ON ce.id=alm.id_curso_escolar
	LEFT JOIN asignatura asi
		ON asi.id=alm.id_asignatura
WHERE pe.nif='26902806M';

/*EJ 4*/
SELECT pe.*
FROM alumno_se_matricula_asignatura alm
	LEFT JOIN persona pe
		ON alm.id_alumno=pe.id
	LEFT JOIN asignaturaat asi
		ON asi.id=alm.id_asignatura 
	LEFT JOIN grado gr
		ON gr.id=asi.id_grado
WHERE pe.sexo='M' AND gr.nombre='Grado en Ingeniería Informática (Plan 2015)'
GROUP BY pe.id;

/*EJ 5*/
SELECT concat_ws(" " ,pe.nombre, pe.apellido1, pe.apellido2) AS nombre_completo
FROM persona pe
	RIGHT JOIN profesor pr
		ON pe.id=pr.id_profesor
WHERE pr.id_departamento IS NULL;

/*EJ 6*/
SELECT de.nombre, asi.nombre
FROM profesor pr
	LEFT JOIN departamento de
		ON de.id=pr.id_departamento
	LEFT JOIN asignatura asi
		ON asi.id_profesor=pr.id_profesor
	LEFT JOIN alumno_se_matricula_asignatura alm
		ON alm.id_asignatura=asi.id
WHERE alm.id_asignatura IS NULL AND asi.nombre IS NOT NULL;


/*EJ 7*/
SELECT de.nombre, pe.apellido1, pe.apellido2, pe.nombre
FROM profesor pr
	RIGHT JOIN departamento de
		ON pr.id_departamento=de.id
	LEFT JOIN persona pe
		ON pr.id_profesor=pe.id
ORDER BY de.nombre, pe.apellido1, pe.apellido2, pe.nombre;

/*EJ 8*/
SELECT de.nombre, COUNT(pr.id_profesor)
FROM departamento de
	LEFT JOIN profesor pr
		ON pr.id_departamento=de.id
GROUP BY de.id
ORDER BY COUNT(pr.id_profesor) DESC;

/*EJ 9*/
SELECT ce.anyo_inicio, ce.anyo_fin, COUNT(alm.id_alumno)
FROM alumno_se_matricula_asignatura alm
	RIGHT JOIN curso_escolar ce
		ON ce.id=alm.id_curso_escolar
GROUP BY ce.id;

/*EJ 10*/
SELECT gr.nombre, COUNT(asi.id)
FROM grado gr
	LEFT JOIN asignatura asi
		ON asi.id_grado=gr.id
GROUP BY gr.id
HAVING COUNT(asi.id)>40;

/*EJ 11*/
SELECT gr.nombre, asi.tipo ,SUM(asi.creditos) AS creditos_totales
FROM grado gr
	RIGHT JOIN asignatura asi
		ON asi.id_grado=gr.id
GROUP BY asi.tipo, gr.id
ORDER BY SUM(asi.creditos) desc;

/*EJ 12*/
SELECT concat_ws(" " ,pe.nombre, pe.apellido1, pe.apellido2) AS nombre_completo, asi.nombre, asi.creditos, gr.nombre
FROM profesor pr
	LEFT JOIN asignatura asi
		ON asi.id_profesor=pr.id_profesor
	LEFT JOIN persona pe
		ON pe.id=pr.id_profesor
	LEFT JOIN departamento de
		ON de.id=pr.id_departamento
	LEFT JOIN grado gr
		ON asi.id_grado=gr.id
WHERE de.nombre='Informática';

/*EJ 13*/
SELECT gr.nombre, COUNT(asi.id_profesor) AS numero_profesores
FROM asignatura asi
	LEFT JOIN grado gr
		ON gr.id=asi.id_grado
GROUP BY asi.id_grado
HAVING COUNT(asi.id_profesor)>=2;

/*EJ 14*/
SELECT asi.*, COUNT(alm.id_alumno) AS numero_alumnos
FROM asignatura asi
	LEFT JOIN alumno_se_matricula_asignatura alm
		ON alm.id_asignatura=asi.id
GROUP BY asi.id
ORDER BY COUNT(alm.id_alumno) DESC
LIMIT 1;