CREATE DATABASE IF NOT EXISTS feria;

USE feria;

DROP TABLE IF EXISTS entradas;
DROP TABLE IF EXISTS precio_espectaculo;
DROP TABLE IF EXISTS representacion;
DROP TABLE IF EXISTS espectaculo;
DROP TABLE IF EXISTS asientos;
DROP TABLE IF EXISTS zona_recintos;
DROP TABLE IF EXISTS recintos;
DROP TABLE IF EXISTS espectador;



CREATE TABLE recintos(
	idRecinto INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    telefono VARCHAR(9) NOT NULL UNIQUE,
    horario VARCHAR(255) NOT NULL
);

CREATE TABLE zona_recintos(
	idRecinto INT,
    zona VARCHAR(6) NOT NULL CHECK (zona IN ('PALCO', 'PLATEA', 'GRADA')),
    capacidad INT NOT NULL CHECK (capacidad <=250),
    PRIMARY KEY (idRecinto, zona),
    FOREIGN KEY (idRecinto) REFERENCES recintos(idRecinto)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE asientos(
	idRecinto INT,
    zona VARCHAR(6) NOT NULL,
    fila INT NOT NULL CHECK (fila BETWEEN 1 AND 60),
    numero INT NOT NULL CHECK (numero BETWEEN 1 AND 20),
    PRIMARY KEY (idRecinto, zona, fila, numero),
    FOREIGN KEY (idRecinto, zona) REFERENCES zona_recintos(idRecinto, zona)
    
);

CREATE TABLE espectaculo(
	idEspectaculo INT,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    fechaInicio DATETIME NOT NULL,
    fechaFin DATETIME NOT NULL,
    interprete VARCHAR(255) NOT NULL,
    idRecinto INT NOT NULL,
    PRIMARY KEY (idEspectaculo),
    FOREIGN KEY (idRecinto) REFERENCES recintos(idRecinto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (nombre, interprete ),
    CHECK (fechaInicio < fechaFin)
    
);

CREATE TABLE representacion(
	idEspectaculo INT,
    fecha DATE,
    hora TIME,
    PRIMARY KEY (idEspectaculo, fecha, hora ),
    FOREIGN KEY (idEspectaculo) REFERENCES espectaculo(idEspectaculo)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE precio_espectaculo(
	idEspectaculo INT,
    idRecinto INT,
    zona VARCHAR(6),
    precio DOUBLE(10, 2) NOT NULL CHECK (precio > 0),
    PRIMARY KEY(idEspectaculo, idRecinto, zona),
	FOREIGN KEY (idRecinto, zona) REFERENCES zona_recintos(idRecinto, zona)
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idEspectaculo) REFERENCES espectaculo(idEspectaculo)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE espectador(
	dniCliente VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono INT(9) NOT NULL,
    ciudad VARCHAR (255) NOT NULL,
    nTarjeta INT NOT NULL
);

CREATE TABLE entradas (
    dniCliente VARCHAR(9),
    idEspectaculo INT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    idRecinto INT,
    fila INT,
    numero INT,
    zona VARCHAR(6),
    PRIMARY KEY (dniCliente , idEspectaculo , fecha , hora , idRecinto , zona),
    FOREIGN KEY (idRecinto , zona , fila , numero)
        REFERENCES asientos (idRecinto , zona , fila , numero)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (dniCliente)
        REFERENCES espectador (dniCliente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEspectaculo , fecha , hora)
        REFERENCES representacion (idEspectaculo , fecha , hora)
        ON DELETE CASCADE ON UPDATE CASCADE
);
