CREATE DATABASE IF NOT EXISTS gimnasio;
USE gimnasio;

DROP TABLE IF EXISTS resumen_entrenamiento;
DROP TABLE IF EXISTS registro_entrenamiento;
DROP TABLE IF EXISTS rutina;
DROP TABLE IF EXISTS entrenador;
DROP TABLE IF EXISTS cliente;

/*EJERCICIO 1*/
CREATE TABLE entrenador(
	id INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    fecha_contratación DATE NOT NULL,
    id_supervisor INT,
    CONSTRAINT pk_entrenador PRIMARY KEY (id),
    CONSTRAINT fk_entrenador FOREIGN KEY (id_supervisor) REFERENCES entrenador(id)
		ON DELETE NO ACTION ON UPDATE CASCADE
        /*Lo pongo en no action ya que supongo que no queremos que se borren los entrenadores que supervisan*/
);

CREATE TABLE rutina(
	id INT AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    descripcion BLOB NOT NULL,
    duración_estimada INT NOT NULL,
    entrenador INT,
    CONSTRAINT pk_rutina PRIMARY KEY (id, entrenador),
    CONSTRAINT fk_rutina FOREIGN KEY (entrenador) REFERENCES entrenador(id)
		ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE cliente(
	codigo INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    edad INT NOT NULL,
    genero CHAR(1) NOT NULL,
    fecha_inscripción DATE NOT NULL,
    fecha_baja DATE,
    CONSTRAINT pk_cliente PRIMARY KEY (codigo)
);

CREATE TABLE registro_entrenamiento(
	id_cliente INT,
    id_rutina INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    CONSTRAINT pk_registro PRIMARY KEY (id_cliente, id_rutina, fecha_inicio),
    CONSTRAINT fk_registro_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(codigo)
		ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_registro_rutina FOREIGN KEY (id_rutina) REFERENCES rutina(id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT chck_registro_fecha CHECK (fecha_inicio<fecha_fin)
);


/*EJERCICIO 2*/

/*EJ 2.1*/
ALTER TABLE cliente ADD CONSTRAINT chck_cliente_edad CHECK (edad BETWEEN 16 AND 85);

/*EJ 2.2*/
ALTER TABLE entrenador ADD COLUMN especialidad VARCHAR(20) NOT NULL CHECK (especialidad IN ('Resistencia', 'Funcional', 'HIIT')) DEFAULT 'Funcional' AFTER nombre;
		/*Pongo que el after sea despues de nombre ya que entiendo que delante significa que esté a la derecha de fecha_contratación*/
	SHOW CREATE TABLE entrenador;
    
/*EJ 2.3*/

ALTER TABLE rutina ADD COLUMN dificultad REAL(5,2) FIRST;

/*EJ 2.4*/
ALTER TABLE registro_entrenamiento DROP CONSTRAINT fk_registro_rutina;
ALTER TABLE rutina MODIFY COLUMN id INT;
ALTER TABLE rutina DROP PRIMARY KEY;
ALTER TABLE rutina ADD PRIMARY KEY (id, entrenador, nombre);
ALTER TABLE rutina MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE registro_entrenamiento ADD CONSTRAINT  fk_registro_rutina FOREIGN KEY (id_rutina) REFERENCES rutina(id)
		ON DELETE CASCADE ON UPDATE CASCADE;
 
/*EJ 2.5*/

ALTER TABLE registro_entrenamiento RENAME TO resumen_entrenamiento;

/*EJ 2.6*/

ALTER TABLE rutina DROP COLUMN duración_estimada;

/*EJ 2.7*/

CREATE USER IF NOT EXISTS 'administrador'@'localhost' IDENTIFIED BY 'admin_gym';
GRANT ALL PRIVILEGES ON gimnasio.* TO 'administrador'@'localhost' WITH GRANT OPTION;

/*EJ 2.8*/

CREATE ROLE IF NOT EXISTS 'entrenadores';
GRANT INSERT, UPDATE ON gimnasio.rutina TO 'entrenadores';
GRANT SELECT ON gimnasio.cliente TO 'entrenadores';

/*EJ 2.9*/

CREATE USER IF NOT EXISTS 'carla'@'176.23.23.10' IDENTIFIED BY '1234' PASSWORD EXPIRE;
GRANT 'entrenadores' TO 'carla'@'176.23.23.10';

/*EJ 2.10*/

CREATE USER IF NOT EXISTS 'pedro'@'%' ACCOUNT LOCK;

/*ej 2.11*/

GRANT SELECT, INSERT, ALTER, DELETE ON gimnasio.* TO 'pedro';

/*EJ 2.12*/
REVOKE INSERT, UPDATE ON gimnasio.rutina FROM 'entrenadores';


