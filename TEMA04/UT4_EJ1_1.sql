CREATE DATABASE IF NOT EXISTS alumnoProfe;
USE alumnoProfe;

DROP TABLE IF EXISTS recibe;
DROP TABLE IF EXISTS asignatura;
DROP TABLE IF EXISTS profesor;
DROP TABLE IF EXISTS alumno;

CREATE TABLE alumno(
	idAlumno INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE NOT NULL ,
    telefono VARCHAR (12) NOT NULL UNIQUE,
    CONSTRAINT kk CHECK (telefono LIKE '+34%'),
    CONSTRAINT aa CHECK (fechaNacimiento > '1920-01-01')
);

CREATE TABLE profesor(
	nif VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    especialidad VARCHAR(100) NOT NULL ,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    CONSTRAINT especialidadProfe CHECK (especialidad IN ('Informatica','Sistemas y aplicaciones'))
);

CREATE TABLE asignatura(
	idAsignatura INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    nifProfesor VARCHAR(15),
    FOREIGN KEY (nifProfesor) REFERENCES profesor(nif) 
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE recibe(
	idAlumno INT,
    idAsignatura INT,
    curso VARCHAR(255) CHECK ( curso IN ('DAW', 'DAM')),
    PRIMARY KEY (idAlumno, idAsignatura, curso),
    FOREIGN KEY (idAlumno) REFERENCES alumno(idAlumno)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idAsignatura) REFERENCES asignatura(idAsignatura)
    ON DELETE CASCADE ON UPDATE CASCADE
    

);