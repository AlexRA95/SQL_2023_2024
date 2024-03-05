CREATE DATABASE IF NOT EXISTS empleados_empresa;
USE empleados_empresa;

DROP TABLE IF EXISTS historial_salarial;
DROP TABLE IF EXISTS historial_laboral;
DROP TABLE IF EXISTS trabajos;
DROP TABLE IF EXISTS estudios;
DROP TABLE IF EXISTS departamentos;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS universidades;

CREATE TABLE empleados(
	dni INT(8) PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL,
    apellido1 VARCHAR(15) NOT NULL,
    apellido2 VARCHAR(15),
    direcc1 VARCHAR(25) NOT NULL,
    direcc2 VARCHAR(25),
    ciudad VARCHAR(10),
    provincia VARCHAR(20),
    cod_postal VARCHAR(5),
    sexo VARCHAR(1) CHECK (sexo IN ('H', 'M')),
    fecha_nac DATE
);

ALTER TABLE empleados ADD COLUMN valoracion INT(2) NOT NULL CHECK (valoracion BETWEEN 0 AND 10) DEFAULT '5';
ALTER TABLE empleados MODIFY COLUMN nombre VARCHAR(10);
ALTER TABLE empleados MODIFY COLUMN direcc1 VARCHAR(40);
ALTER TABLE empleados MODIFY COLUMN direcc1 VARCHAR(25);
ALTER TABLE empleados MODIFY COLUMN direcc1 VARCHAR(25);
ALTER TABLE empleados MODIFY COLUMN valoracion INT(2) NOT NULL ;
ALTER TABLE empleados ADD COLUMN telefono VARCHAR(11);
SHOW CREATE TABLE empleados ;



CREATE TABLE departamentos (
    dpto_cod INT(5),
    nombre_dpto VARCHAR(30) NOT NULL UNIQUE,
    dpto_padre INT(5),
    presupuesto INT NOT NULL,
    pres_actual INT,
    PRIMARY KEY (dpto_cod),
    FOREIGN KEY (dpto_padre) REFERENCES departamentos(dpto_cod)
);

ALTER TABLE departamentos MODIFY COLUMN nombre_dpto VARCHAR(30) NOT NULL;



CREATE TABLE trabajos(
	trabajo_cod INT(5) PRIMARY KEY,
    nombre_trab VARCHAR(20) NOT NULL UNIQUE,
    salario_min INT(2) NOT NULL,
    salario_max INT(2) NOT NULL
);


CREATE TABLE universidades(
	univ_cod INT(5) PRIMARY KEY,
    nombre_univ VARCHAR(25) NOT NULL,
    ciudad VARCHAR(20),
    municipio VARCHAR(2),
    cod_postal VARCHAR(5)
);



CREATE TABLE estudios(
	empleado_dni INT(8),
    universidad INT(5),
    anio INT,
    grado VARCHAR(3),
    especialiad VARCHAR(20),
    PRIMARY KEY (empleado_dni, universidad, grado, especialiad),
    CONSTRAINT fk_estudios_empleado FOREIGN KEY (empleado_dni) REFERENCES empleados(dni),
    CONSTRAINT fk_estudios_universidad FOREIGN KEY (universidad) REFERENCES universidades(univ_cod)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE historial_salarial(
    empleadoDni INT(8),
    salario INT NOT NULL,
    fecha_comienzo DATE,
    fecha_fin DATE,
    PRIMARY KEY (empleadoDni, fecha_comienzo, salario),
    CONSTRAINT fk_salario_empleado FOREIGN KEY (empleadoDni) REFERENCES empleados(dni)
);

CREATE TABLE historial_laboral(
	empleadoDni INT(8),
    trabajo_cod INT(5),
    fecha_inicio DATE,
    fecha_fin DATE,
    dpto_cod INT(5),
    supervisor_dni INT(8),
	PRIMARY KEY (empleadoDni, fecha_inicio, trabajo_cod ),
    CONSTRAINT fk_laboral_empleado FOREIGN KEY (empleadoDni) REFERENCES empleados(dni),
    CONSTRAINT fk_laboral_trabajo FOREIGN KEY (trabajo_cod) REFERENCES trabajos(trabajo_cod),
    CONSTRAINT fk_laboral_departamento FOREIGN KEY (dpto_cod) REFERENCES departamentos(dpto_cod)
);



