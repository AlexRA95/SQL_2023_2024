CREATE DATABASE IF NOT EXISTS RA4;
USE RA4;

DROP TABLE IF EXISTS adopciones;
DROP TABLE IF EXISTS historial_medico;
DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS chenil;
DROP TABLE IF EXISTS pabellon;
DROP TABLE IF EXISTS adoptante;
DROP TABLE IF EXISTS veterinario;

CREATE TABLE pabellon(
	id_pabellon INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    capacidad_maxima INT
    
);

CREATE TABLE chenil(
	id_chenil INT AUTO_INCREMENT,
    id_pabellon INT,
    estado VARCHAR(1) NOT NULL,
    CONSTRAINT pk_chenil PRIMARY KEY (id_chenil, id_pabellon),
    CONSTRAINT fk_chenil FOREIGN KEY (id_pabellon) REFERENCES pabellon(id_pabellon) 
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE animal(
	codigo INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    especie VARCHAR(30) NOT NULL, 
    raza VARCHAR(20), /*Podemos no conocer la raza del animal*/
    edad INT, /*Podemos no conocer la edad del animal*/
    genero VARCHAR(1)  NOT NULL,
    fecha_nacimiento DATE , /*Podemos no conocer la fecha de nacimiento*/
    fecha_ingreso DATE NOT NULL,
    cod_madre INT, /*Puede no conocerse la madre*/
    pabellon INT,
    chenil INT,
    CONSTRAINT pk_animal PRIMARY KEY (codigo, pabellon, chenil),
    CONSTRAINT fk_animal FOREIGN KEY (pabellon, chenil) REFERENCES chenil(id_pabellon, id_chenil)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_animal_madre FOREIGN KEY (cod_madre) REFERENCES animal(codigo)
		ON DELETE CASCADE ON UPDATE CASCADE
	
);

CREATE TABLE adoptante(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    telefono VARCHAR(12)  NOT NULL,
    email VARCHAR(30)  NOT NULL
);

CREATE TABLE adopciones(
	id_animal INT,
    id_adoptante INT,
    fecha_adopcion DATE,
    entrevista_adoptante BLOB NOT NULL,
    CONSTRAINT pk_adopciones PRIMARY KEY (id_animal, id_adoptante, fecha_adopcion),
    CONSTRAINT fk_adopciones_animal FOREIGN KEY (id_animal) REFERENCES animal(codigo)
		ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_adopciones_adoptante FOREIGN KEY (id_adoptante) REFERENCES adoptante(id)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE veterinario(
	id_veterinario INT PRIMARY KEY AUTO_INCREMENT,
    especialidad VARCHAR(50) NOT NULL,
    horario_trabajo VARCHAR(40) NOT NULL,
    servicio_domicilio VARCHAR(1)  NOT NULL
);

CREATE TABLE historial_medico(
	id_animal INT,
    id_veterinario INT,
    fecha_consulta DATE NOT NULL,
    fecha_proxRevision DATE NOT NULL,
    diagnostico VARCHAR(40),
    tratamiento VARCHAR(40) , /*Puede pasar que un animal no tenga ningun tratamiento mandado*/
    CONSTRAINT pk_historial PRIMARY KEY (id_animal, id_veterinario, fecha_consulta, diagnostico ), /*Diagnostico es clabe primaria para que pueda haber varios diagnosticos en 1 consulta en la misma fecha*/
    CONSTRAINT fk_historial_animal FOREIGN KEY (id_animal) REFERENCES animal(codigo)
		ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_historial_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario)
		ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE pabellon ADD CONSTRAINT check_pabellon_capacidad CHECK (capacidad_maxima<=100);
ALTER TABLE animal ADD CONSTRAINT check_animal_fecha CHECK (fecha_ingreso>=fecha_nacimiento);
ALTER TABLE animal ADD CONSTRAINT check_animal_genero CHECK (genero IN ('H','M'));
ALTER TABLE adoptante ADD CONSTRAINT check_adoptante_telefono CHECK ( telefono LIKE '+34%');
ALTER TABLE adoptante ADD CONSTRAINT check_adoptante_email CHECK (email LIKE '%gmail.com' OR '@hotmail.com');
ALTER TABLE veterinario ADD CONSTRAINT check_veterinario_servicio_domicilio CHECK (servicio_domicilio IN ('S','N'));


CREATE ROLE IF NOT EXISTS 'veterinario';
GRANT SELECT ON animal TO 'veterinario';
GRANT SELECT, INSERT, UPDATE ON historial_medico TO 'veterinario';
CREATE USER IF NOT EXISTS 'sara'@'172.10.10.2' IDENTIFIED BY  '12345' PASSWORD EXPIRE;
GRANT 'veterinario' TO  'sara'@'172.10.10.2';
SET DEFAULT ROLE 'veterinario' TO 'sara'@'172.10.10.2';
CREATE USER IF NOT EXISTS 'juan'@'172.10.10.3' ACCOUNT LOCK;
GRANT SELECT, ALTER ON animal TO 'juan'@'172.10.10.3';
GRANT SELECT, ALTER ON adoptante TO 'juan'@'172.10.10.3';
GRANT SELECT, ALTER ON adopciones TO 'juan'@'172.10.10.3';
ALTER USER 'juan'@'172.10.10.3' ACCOUNT UNLOCK ;
ALTER USER 'juan'@'172.10.10.3' IDENTIFIED BY 'pass_temporal' PASSWORD EXPIRE INTERVAL 20 DAY;