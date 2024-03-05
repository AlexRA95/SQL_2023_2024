CREATE DATABASE IF NOT EXISTS agcViajes;
USE agcViajes;

DROP TABLE IF EXISTS contrata;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS vuela;
DROP TABLE IF EXISTS sucursal;
DROP TABLE IF EXISTS turista;
DROP TABLE IF EXISTS hotel;
DROP TABLE IF EXISTS vuelo;

CREATE TABLE sucursal(
	idSucursal INT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(255) NOT NULL CHECK (direccion LIKE 'C/%'),
    telefono VARCHAR(9) NOT NULL UNIQUE

);

CREATE TABLE turista(
	idTurista INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL CHECK (direccion LIKE 'C/%'),
	telefono VARCHAR(9) NOT NULL UNIQUE

);

CREATE TABLE hotel(
	idHotel INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
	direccion VARCHAR(255) NOT NULL CHECK (direccion LIKE 'C/%'),
    ciudad VARCHAR(255) NOT NULL DEFAULT 'Madrid',
    telefono VARCHAR(9) NOT NULL UNIQUE,
    plazas VARCHAR(255) NOT NULL CHECK (plazas BETWEEN 0 AND 100 )
    
);


CREATE TABLE vuelo(
	idVuelo INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    origen VARCHAR(255) NOT NULL,
    destino VARCHAR(255) NOT NULL,
    plazasTurista INT NOT NULL CHECK (plazasTurista >= 0 AND plazasTurista <= 120),
    plazasTotal INT NOT NULL,
    CONSTRAINT noIgual CHECK ((origen<>destino) AND (plazasTurista<plazasTotal))
    
);


CREATE TABLE contrata (
    idSucursal INT,
    idTurista INT,
    PRIMARY KEY (idSucursal , idTurista),
    FOREIGN KEY (idSucursal)
        REFERENCES sucursal (idSucursal)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idTurista)
        REFERENCES turista (idTurista)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reserva (
    idTurista INT,
    idHotel INT,
    fechaEntrada DATE NOT NULL,
    fechaSalida DATE NOT NULL,
    pension VARCHAR(1) NOT NULL CHECK (pension IN ('M' , 'C', 'D')),
    PRIMARY KEY (idTurista , idHotel , fechaEntrada),
    FOREIGN KEY (idTurista)
        REFERENCES turista (idTurista)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idHotel)
        REFERENCES hotel (idHotel)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE vuela (
    idTurista INT,
    idVuelo INT,
    clase VARCHAR(255) CHECK (clase IN ('Turista' , 'Business', 'Primera Clase')),
    PRIMARY KEY (idTurista , idVuelo),
    FOREIGN KEY (idTurista)
        REFERENCES turista (idTurista)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idVuelo)
        REFERENCES vuelo (idVuelo)
        ON DELETE CASCADE ON UPDATE CASCADE
);

