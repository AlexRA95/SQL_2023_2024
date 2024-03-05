CREATE DATABASE IF NOT EXISTS hoteles;
USE hoteles;

DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS habitacion;
DROP TABLE IF EXISTS planta;
DROP TABLE IF EXISTS hotel;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS cliente;

CREATE TABLE categoria(
	codCategoria INT PRIMARY KEY,
	tipoIVA DOUBLE NOT NULL CHECK (tipoIVA IN ('0.10', '0.14', '0.21')),
	descripcion VARCHAR(200) NOT NULL
);

CREATE TABLE cliente(
	dni VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    tipo VARCHAR(10) CHECK (tipo IN ('PARTICULAR', 'AGENCIA')) NOT NULL,
    nombreCliente VARCHAR(50)
);

CREATE TABLE hotel(
	codHotel INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    anioConstrucion INT (4) CHECK (anioConstrucion BETWEEN 1950 AND 2023),
    categoria INT,
    FOREIGN KEY (categoria) REFERENCES categoria(codCategoria)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE planta(
	codHotel INT,
    numeroPlanta INT,
    nombre VARCHAR(255),
    numHabitaciones INT CHECK (numHabitaciones BETWEEN 0 AND 100),
    PRIMARY KEY (codHotel, numeroPlanta),
    FOREIGN KEY (codHotel) REFERENCES hotel(codHotel)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE habitacion(
	codHotel INT,
    numeroPlanta INT,
    codHabitacion INT,
    tipo VARCHAR(25) CHECK (tipo IN ('Individual', 'Dobles', 'Triples', 'Suites', 'Apartamentos')),
    PRIMARY KEY (codHotel, numeroPlanta, codHabitacion),
    FOREIGN KEY (codHotel, numeroPlanta) REFERENCES planta(codHotel, numeroPlanta)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reserva (
    codHotel INT,
    numeroPlanta INT,
    codHabitacion INT,
    dniCliente VARCHAR(9),
    precio DOUBLE,
    fechaInicio DATE,
    fechaFin DATE,
    PRIMARY KEY (codHotel , numeroPlanta , codHabitacion , dniCliente , fechaInicio),
    FOREIGN KEY (codHotel , numeroPlanta , codHabitacion)
        REFERENCES habitacion (codHotel , numeroPlanta , codHabitacion)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (dniCliente)
        REFERENCES cliente (dni)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fecha CHECK (fechaInicio < fechaFin)
);