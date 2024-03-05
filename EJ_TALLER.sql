CREATE DATABASE IF NOT EXISTS taller;

USE taller;

DROP TABLE IF EXISTS automoviles;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS propietarios;

CREATE TABLE automoviles(
	idAuto INT PRIMARY KEY,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    anio INT(4),
    consume INT,
    emsisiones VARCHAR(50)
);

CREATE TABLE propietarios(
	idPropietario INT PRIMARY KEY,
    nombre VARCHAR(255),
    dni VARCHAR(9),
    fechaNacimiento DATE,
    imagen VARCHAR(255)
);

ALTER TABLE automoviles ADD COLUMN tipo VARCHAR(255) CHECK (tipo IN ('utilitario', 'monovolumen', 'todoterreno', 'familiar')) AFTER consume;
ALTER TABLE automoviles ADD COLUMN precio REAL(8,2)  FIRST;
ALTER TABLE propietarios RENAME COLUMN fechaNacimiento TO nacimiento;
ALTER TABLE propietarios DROP COLUMN imagen;
ALTER TABLE propietarios RENAME TO clientes;
ALTER TABLE automoviles ADD COLUMN idPropietario INT;
ALTER TABLE automoviles ADD CONSTRAINT fk_propietario FOREIGN KEY (idPropietario) REFERENCES clientes(idPropietario) ;
SHOW COLUMNS FROM automoviles;
SHOW CREATE TABLE automoviles;


DROP DATABASE IF EXISTS veterinario;

CREATE DATABASE IF NOT EXISTS mascotas;

DROP TABLE IF EXISTS mascotas.vacunas;
DROP TABLE IF EXISTS mascotas.vacunaciones;
DROP TABLE IF EXISTS mascotas.animales;


CREATE TABLE mascotas.animales(
	nomAnimal VARCHAR(255),
    tipo VARCHAR(255),
    raza VARCHAR(255),
    peso DOUBLE(4,2),
    color VARCHAR(255),
    CONSTRAINT pk_animales PRIMARY KEY (nomAnimal)
);

CREATE TABLE mascotas.vacunaciones(
	nomAnimal VARCHAR(255),
    fechaVacuna DATE,
    descripcionVacuna VARCHAR(255),
    CONSTRAINT pk_vacunaciones PRIMARY KEY (nomAnimal, fechaVacuna),
    CONSTRAINT fk_vacunaciones FOREIGN KEY (nomAnimal) REFERENCES animales(nomAnimal)
);

ALTER TABLE mascotas.vacunaciones DROP CONSTRAINT fk_vacunaciones;
ALTER TABLE mascotas.animales DROP PRIMARY KEY;

SHOW COLUMNS FROM mascotas.animales;

ALTER TABLE mascotas.animales RENAME COLUMN nomAnimal to nombre;
ALTER TABLE mascotas.animales ADD CONSTRAINT pk_animales PRIMARY KEY (nombre);
ALTER TABLE mascotas.vacunaciones ADD CONSTRAINT fk_vacunaciones FOREIGN KEY (nomAnimal) REFERENCES mascotas.animales(nombre);
ALTER TABLE mascotas.animales ADD COLUMN origen VARCHAR(255) CHECK (origen IN ('comprado', 'recogido', 'adoptado')) DEFAULT 'adoptado' AFTER peso;
ALTER TABLE mascotas.animales MODIFY COLUMN peso REAL(6,3);
SHOW COLUMNS FROM mascotas.animales;
ALTER TABLE mascotas.vacunaciones RENAME COLUMN fechaVacuna to fecha;
SHOW COLUMNS FROM mascotas.vacunaciones;
ALTER TABLE mascotas.animales DROP COLUMN color;
SHOW COLUMNS FROM mascotas.animales;
ALTER TABLE mascotas.vacunaciones RENAME TO mascotas.vacunas ;
SHOW CREATE TABLE mascotas.vacunas;
SHOW CREATE TABLE mascotas.animales;


CREATE USER IF NOT EXISTS 'gestor'@'172.16.10.1' IDENTIFIED BY 'soy_gestor' PASSWORD EXPIRE INTERVAL 90 DAY;
GRANT ALL PRIVILEGES ON mascotas.* TO 'gestor'@'172.16.10.1' WITH GRANT OPTION;
CREATE ROLE IF NOT EXISTS 'auxiliares'; 
GRANT SELECT, INSERT, ALTER, DELETE ON mascotas.animales TO 'auxiliares';
CREATE USER IF NOT EXISTS 'pedro'@'10.%' ACCOUNT LOCK;
CREATE USER IF NOT EXISTS 'ana'@'10.%' ACCOUNT LOCK;
GRANT 'auxiliares' TO 'pedro'@'10.%', 'ana'@'10.%';
SET DEFAULT ROLE 'auxiliares' TO 'ana'@'10.%';
REVOKE 'pedro'@'10.%' FROM 'auxiliares';
ALTER USER 'pedro'@'10.%' IDENTIFIED BY '1234';
ALTER USER 'ana'@'10.%' ACCOUNT UNLOCK;
CREATE USER IF NOT EXISTS 'juan'@'170.16.0.22' IDENTIFIED BY 'contrasenia';
CREATE USER IF NOT EXISTS 'marta'@'172.16.0.%' IDENTIFIED BY '123456';
CREATE ROLE IF NOT EXISTS 'veterinario';
GRANT SELECT ON mascotas.animales TO 'veterinario';
GRANT SELECT, INSERT, ALTER, DELETE ON mascotas.vacunas TO 'veterinario';
GRANT 'auxiliares' TO 'juan'@'170.16.0.22', 'marta'@'172.16.0.%';
REVOKE DELETE ON mascotas.animales FROM 'auxiliares';
