CREATE DATABASE IF NOT EXISTS ikea;

USE ikea;

DROP TABLE  IF EXISTS compra;
DROP TABLE  IF EXISTS monta;
DROP TABLE IF EXISTS cliente;
DROP TABLE  IF EXISTS modelo_dormitorio;
DROP TABLE  IF EXISTS montador;


CREATE TABLE cliente(
	nif VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL UNIQUE

);


CREATE TABLE IF NOT EXISTS modelo_dormitorio(
	idModelo INT PRIMARY KEY

);


CREATE TABLE  montador(
	nif VARCHAR(9) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL UNIQUE
);


CREATE TABLE compra(
	nifCliente VARCHAR(9),
    idModelo INT,
    fechaCompra DATE,
    cantidad INT NOT NULL,
    PRIMARY KEY (nifCliente, idModelo, fechaCompra),
    FOREIGN KEY (nifCliente) REFERENCES cliente(nif)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idModelo) REFERENCES modelo_dormitorio(idModelo)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE monta(
	nifMontador VARCHAR(9),
    idModelo INT,
    fechaMontaje DATE,
    cantidad INT NOT NULL,
    PRIMARY KEY (nifMontador, idModelo, fechaMontaje),
    FOREIGN KEY (nifMontador) REFERENCES montador(nif)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idModelo) REFERENCES modelo_dormitorio(idModelo)
		ON DELETE CASCADE ON UPDATE CASCADE

);
