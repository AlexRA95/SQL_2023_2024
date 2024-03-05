CREATE DATABASE IF NOT EXISTS pubs;

USE pubs;

DROP TABLE IF EXISTS pub_empleado;
DROP TABLE IF EXISTS titular;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS existencias;
DROP TABLE IF EXISTS pub;
DROP TABLE IF EXISTS localidad;

CREATE TABLE localidad(
	idLocalidad INT PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL
);


CREATE TABLE pub(
	idPub INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    licenciaFiscal VARCHAR(255) NOT NULL UNIQUE,
    domicilio VARCHAR(255),
    fechaApertura DATE NOT NULL,
    horario VARCHAR(255) CHECK (horario IN ('HOR1','HOR2','HOR3')),
    idLocalidad INT,
    FOREIGN KEY (idLocalidad) REFERENCES localidad(idLocalidad)
);


CREATE TABLE titular (
    dniTitular VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255) ,
    idPub INT,
    FOREIGN KEY (idPub)
        REFERENCES pub (idPub)
);

CREATE TABLE empleado(
    dniEmpleado VARCHAR(9) PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255)
);

CREATE TABLE existencias(
	idArticulo VARCHAR(255),
    nombre VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    precio INT NOT NULL CHECK (precio > 0),
    idPub INT,
    FOREIGN KEY (idPub) REFERENCES pub(idPub)
);



CREATE TABLE pub_empleado(
    idPub INT,
	dniEmpleado VARCHAR(9),
	funcion VARCHAR(255) CHECK (funcion IN ('CAMARERO', 'SEGURIDAD', 'LIMPIEZA')),
    PRIMARY KEY (idPub, dniEmpleado, funcion),
    FOREIGN KEY (idPub) REFERENCES pub(idPub),
    FOREIGN KEY (dniEmpleado) REFERENCES empleado(dniEmpleado)
);