DROP DATABASE IF EXISTS proyecto;
CREATE DATABASE proyecto CHARACTER SET utf8mb4;
USE proyecto;

CREATE TABLE marca(
	id_marca INT PRIMARY KEY auto_increment,
    nombre VARCHAR(255) not null
);

CREATE TABLE movil(
	id_movil INT auto_increment,
    nombre VARCHAR(255) not null,
    marca INT not null,
    precio_venta DOUBLE(5,2) not null,
    precio_compra DOUBLE(5,2) not null,
    fecha_lanzamiento DATE not null,
    CONSTRAINT pk_movil PRIMARY KEY (id_movil, marca),
    CONSTRAINT fk_movil FOREIGN KEY (marca) REFERENCES marca(id_marca) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE pais(
	id_pais INT PRIMARY KEY auto_increment,
    nombre VARCHAR(255) not null
);

CREATE TABLE fabrica(
	id_fabrica INT auto_increment,
    nombre VARCHAR(255) not null,
    pais INT NOT NULL,
    CONSTRAINT pk_fabrica PRIMARY KEY (id_fabrica, pais),
    CONSTRAINT fk_fabrica FOREIGN KEY (pais) REFERENCES pais(id_pais) ON UPDATE CASCADE 
);

CREATE TABLE procedencia(
	id_fabrica INT,
	id_movil INT,
    CONSTRAINT pk_procedencia PRIMARY KEY (id_fabrica, id_movil),
    CONSTRAINT fk_procedencia_fabrica FOREIGN KEY (id_fabrica) REFERENCES fabrica(id_fabrica) ON UPDATE CASCADE ON DELETE 	 CASCADE,
    CONSTRAINT fk_procedencia_movil FOREIGN KEY (id_movil) REFERENCES movil(id_movil) ON UPDATE CASCADE
);

