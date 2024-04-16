DROP DATABASE IF EXISTS videojuegos;
CREATE DATABASE  IF NOT EXISTS videojuegos;
USE videojuegos;

/*!50503 set default_storage_engine = InnoDB */;

--
-- Estructura de la tabla genero
--
DROP TABLE IF EXISTS genero;
CREATE TABLE IF NOT EXISTS genero (
  id_genero INT NOT NULL AUTO_INCREMENT,
  nombre_genero varchar(50) DEFAULT NULL,
  PRIMARY KEY (id_genero)
);

--
-- Añadir datos a la tabla 'genero'
--
LOCK TABLES `genero` WRITE;
INSERT INTO `genero` VALUES (1,'Estrategia'),(2,'MOBA'),(3,'ARPG'),(4,'Mundo abierto');
UNLOCK TABLES;

--
-- Estructura de la tabla genero
--
DROP TABLE IF EXISTS juego;
CREATE TABLE juego (
  id_juego INT NOT NULL AUTO_INCREMENT,
  id_genero INT DEFAULT NULL,
  nombre_juego varchar(200) DEFAULT NULL,
  PRIMARY KEY (id_juego),
  FOREIGN KEY (id_genero) REFERENCES genero (id_genero) ON DELETE CASCADE
);

LOCK TABLES `juego` WRITE;
INSERT INTO `juego` VALUES 
	(1,1, 'Hearthstone'),(2,1,'Clash Royale'),
	(3,2, 'League of Legends'),(4,2,'Brawl Stars'),
    (5,3, 'Elden Ring'),(6,3,'Sekiro: Shadows Die Twice'),
    (7,4, 'Horizon Forbidden West'),(8,4,'The legend of Zelda: Breath of the wild');
UNLOCK TABLES;

--
-- Estructura de la tabla desarrollador
--
DROP TABLE IF EXISTS desarrollador;
CREATE TABLE desarrollador (
  id_desarrollador INT NOT NULL AUTO_INCREMENT,
  nombre_desarrollador varchar(100) DEFAULT NULL,
  PRIMARY KEY (id_desarrollador)
);

LOCK TABLES `desarrollador` WRITE;
INSERT INTO `desarrollador` VALUES 
	(1,'Blizzard'),(2,'Supercell'),(3,'Riot Games'),(4,'FromSoftware'),(5, 'Guerrilla Games'), (6, 'Nintendo EPD'), (7, 'Monolith Soft');
UNLOCK TABLES;

--
-- Estructura de la tabla desarrollador_juego
--
DROP TABLE IF EXISTS desarrollador_juego;
CREATE TABLE desarrollador_juego (
  id_des_juego INT NOT NULL AUTO_INCREMENT,
  id_juego INT DEFAULT NULL,
  id_desarrollador INT DEFAULT NULL,
  PRIMARY KEY (id_des_juego),
  FOREIGN KEY (id_juego) REFERENCES juego (id_juego) ON DELETE CASCADE,
  FOREIGN KEY (id_desarrollador) REFERENCES desarrollador (id_desarrollador) ON DELETE CASCADE
);

LOCK TABLES `desarrollador_juego` WRITE;
INSERT INTO `desarrollador_juego` VALUES 
	(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 2), (5, 5, 4), (6, 6, 4), (7, 7, 5), (8, 8, 6);
UNLOCK TABLES;

--
--  Estructura de la tabla plataforma
--
DROP TABLE IF EXISTS plataforma;
CREATE TABLE plataforma (
  id_plataforma INT NOT NULL AUTO_INCREMENT,
  nombre_plataforma varchar(50) DEFAULT NULL,
  PRIMARY KEY (id_plataforma)
);

LOCK TABLES `plataforma` WRITE;
INSERT INTO `plataforma` VALUES 
	(1, 'PC'), (2, 'PlayStation'), (3, 'Xbox'), (4, 'Mobile'), (5, 'Nintendo');
UNLOCK TABLES;

--
-- Estructura de la tabla plataforma_juego
--
DROP TABLE IF EXISTS plataforma_juego;
CREATE TABLE plataforma_juego (
  id_plat_juego INT NOT NULL AUTO_INCREMENT,
  id_desarrollador_juego INT DEFAULT NULL,
  id_plataforma INT DEFAULT NULL,
  anio_lanzamiento INT DEFAULT NULL,
  PRIMARY KEY (id_plat_juego),
   FOREIGN KEY (id_desarrollador_juego) REFERENCES desarrollador_juego (id_des_juego) ON DELETE CASCADE,
  FOREIGN KEY (id_plataforma) REFERENCES plataforma (id_plataforma) ON DELETE CASCADE
);

LOCK TABLES `plataforma_juego` WRITE;
INSERT INTO `plataforma_juego` VALUES 
	(1, 1, 1, 2014), (2, 1, 4, 2015), (3, 2, 4, 2016), (4, 3, 1, 2009),
    (5, 4, 4, 2017), (6, 5, 3, 2022), (7, 5, 1, 2022), (8, 5, 2, 2022),
    (9, 6, 3, 2019), (10, 6, 1, 2019), (11, 6, 2, 2019),
    (12, 7, 2, 2022), (13, 8, 5, 2017);
UNLOCK TABLES;
