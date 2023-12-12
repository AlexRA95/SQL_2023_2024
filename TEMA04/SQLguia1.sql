CREATE DATABASE IF NOT EXISTS examenes;

USE examenes;

/*ALTER TABLE examen
MODIFY COLUMN fechas DATE;*/

CREATE TABLE IF NOT EXISTS examen (
    numeroExamen INT PRIMARY KEY,
    numeroPreguntas INT,
    fechas DATE
);

/*INSERT INTO examen 
	VALUES (1, 5, '2023-11-7');*/

CREATE TABLE IF NOT EXISTS alumno (
    numeroMatricula INT PRIMARY KEY,
    nombre VARCHAR(255),
    grupo VARCHAR(255)
);

/*INSERT INTO alumno
	VALUES(1, 'Pepe', '2A');*/

CREATE TABLE IF NOT EXISTS hacen (
    numeroExamen INT,
    numeroMatricula INT,
    nota INT,
    PRIMARY KEY (numeroExamen , numeroMatricula),
    FOREIGN KEY (numeroExamen)
        REFERENCES examen (numeroExamen),
    FOREIGN KEY (numeroMatricula)
        REFERENCES alumno (numeroMatricula)
);

/*INSERT INTO hacen
	VALUES(1, 1, 6);*/

CREATE TABLE IF NOT EXISTS practica (
    idPractica INT PRIMARY KEY,
    titulo VARCHAR(255),
    dificultad VARCHAR(255)
);

/*INSERT INTO practica
	VALUES(1, 'Practica de algo', 'Alta');*/

CREATE TABLE IF NOT EXISTS profesor (
    dni VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(255)
);

INSERT INTO profesor
	VALUES('10325439A', 'Jose');

/*ALTER TABLE realizan
MODIFY COLUMN fecha DATE;*/

CREATE TABLE IF NOT EXISTS realizan (
    numeroMatricula_Alumno INT,
    codigo_Practica INT,
    fecha DATE,
    nota INT,
    PRIMARY KEY (numeroMatricula_Alumno , codigo_Practica),
    FOREIGN KEY (numeroMatricula_Alumno)
        REFERENCES alumno (numeroMatricula),
    FOREIGN KEY (codigo_Practica)
        REFERENCES practica (idPractica)
);

/*INSERT INTO realizan
	VALUES(1, 1, '2023-12-01', 5);*/

/*ALTER TABLE disenan
MODIFY COLUMN fecha DATE;*/

CREATE TABLE IF NOT EXISTS disenan (
    codigo_Practica INT,
    dni_Profesor VARCHAR(9),
    fecha DATE,
    PRIMARY KEY (codigo_Practica , dni_Profesor),
    FOREIGN KEY (codigo_Practica)
        REFERENCES practica (idPractica),
    FOREIGN KEY (dni_Profesor)
        REFERENCES profesor (dni)
);

/*INSERT INTO disenan
	VALUES(1, '10325439A', '2023-08-12' );*/
