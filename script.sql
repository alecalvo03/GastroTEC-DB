PRAGMA foreign_keys = ON;
/*
 * DataBase Tables Creation
 */

CREATE TABLE UNIVERSIDAD (
    IdUniversidad         INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(40),
    IdCalificacion        INTEGER,
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES CALIFICACION(IdCalificacion));

CREATE TABLE CALIFICACION (
    IdCalificacion        INTEGER PRIMARY KEY AUTOINCREMENT,
    UpVotes               INTEGER,
    DownVotes             INTEGER);

CREATE TABLE SEDE (
    IdSede                INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(20),
    IdCalificacion        INTEGER,
    IdUbicacion           INTEGER,
    IdUniversidad         INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES UNIVERSIDAD(IdUniversidad),
    CONSTRAINT fk_ubucacion FOREIGN KEY (IdUbicacion) REFERENCES UBICACION(IdUbicacion),
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES CALIFICACION(IdCalificacion));

CREATE TABLE UBICACION (
    IdUbicacion           INTEGER PRIMARY KEY AUTOINCREMENT,
    Pais                  VARCHAR(15),
    Provincia             VARCHAR(15),
    Ciudad                VARCHAR(20),
    Calle                 VARCHAR(20),
    Direccion             VARCHAR(50));

CREATE TABLE ESTUDIANTE (
    IdEstudiante          INTEGER PRIMARY KEY AUTOINCREMENT,
    IdUniversidad         INTEGER,
    Carrera               VARCHAR(40),
    FechaNacimiento       VARCHAR(10),
    LugarNacimiento       INTEGER,
    Nombre                VARCHAR(20),
    Apellidos             VARCHAR(25),
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES UNIVERSIDAD(IdUniversidad),
    CONSTRAINT fk_ubucacion FOREIGN KEY (LugarNacimiento) REFERENCES UBICACION(IdUbicacion));

CREATE TABLE RESTAURANTE (
    IdRestaurante         INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(30),
    Horario               VARCHAR(11),
    IdSede                INTEGER,
    IdCalificacion        INTEGER,
    CONSTRAINT fk_sede FOREIGN KEY (IdSede) REFERENCES SEDE(IdSede),
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES CALIFICACION(IdCalificacion));

CREATE TABLE MENU (
    IdMenu                INTEGER PRIMARY KEY AUTOINCREMENT,
    IdRestaurante         INTEGER,
    Horario               TIME,
    Fecha                 DATE,
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES RESTAURANTE(IdRestaurante));

CREATE TABLE PLATILLO (
    IdPlatillo            INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(25),
    Precio                INTEGER,
    IdCalificacion        INTEGER,
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES CALIFICACION(IdCalificacion));

CREATE TABLE VOTO (
    IdVoto                INTEGER PRIMARY KEY AUTOINCREMENT,
    Hora                  TIME,
    Fecha                 DATE,
    Calificacion          INTEGER);

CREATE TABLE VOTOXUNIVERSIDAD(
    IdUniversidad         INTEGER,
    IdEstudiante          INTEGER,
    IdVoto                INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES UNIVERSIDAD(IdUniversidad),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES ESTUDIANTE(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES VOTO(IdVoto));

CREATE TABLE VOTOXRESTAURANTE(
    IdUniversidad         INTEGER,
    IdRestaurante         INTEGER,
    IdEstudiante          INTEGER,
    IdVoto                INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES UNIVERSIDAD(IdUniversidad),
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES RESTAURANTE(IdRestaurante),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES ESTUDIANTE(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES VOTO(IdVoto));

CREATE TABLE VOTOXPLATILLO(
    IdUniversidad         INTEGER,
    IdRestaurante         INTEGER,
    IdMenu                 INTEGER,
    IdPlatillo            INTEGER,
    IdEstudiante          INTEGER,
    IdVoto                INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES UNIVERSIDAD(IdUniversidad),
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES RESTAURANTE(IdRestaurante),
    CONSTRAINT fk_menu FOREIGN KEY (IdMenu) REFERENCES MENU(IdMenu),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES PLATILLO(IdPlatillo),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES ESTUDIANTE(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES VOTO(IdVoto));

CREATE TABLE RESTAURANTEXPLATILLO(
    IdRestaurante         INTEGER,
    IdPlatillo            INTEGER,
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES RESTAURANTE(IdRestaurante),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES PLATILLO(IdPlatillo));

CREATE TABLE MENUXPLATILLO(
    IdMenu                INTEGER,
    IdPlatillo            INTEGER,
    CONSTRAINT fk_menu FOREIGN KEY (IdMenu) REFERENCES MENU(IdMenu),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES PLATILLO(IdPlatillo));


INSERT INTO UNIVERSIDAD (Nombre)
VALUES ('TEC');

INSERT INTO CALIFICACION(UpVotes, DownVotes)
VALUES (50, 2),(10,25),(60,30);

UPDATE UNIVERSIDAD SET IdCalificacion = 1 WHERE IdUniversidad = 1;

INSERT INTO UBICACION (Pais, Provincia, Ciudad, Calle, Direccion)
VALUES ('Costa Rica', 'Cartago', 'Cartago', 'Calle 15, Avenida 14', '1 km Sur de la Basílica de los Ángeles.'),
    ('Costa Rica', 'Alajuela', 'San Carlos', 'Carretera a Fortuna', '18 kilómetros al norte de Ciudad Quesada.'),
    ('Costa Rica', 'San José', 'San José', 'Calles 5 y 7, Avenida 9 y 11.', 'Barrio Amón'),
    ('Costa Rica', 'San José', 'San Pedro', 'Calles 59.', '3 kilómetros al este del centro de San José');


INSERT INTO SEDE (Nombre, IdUbicacion, IdUniversidad)
VALUES ('Sede Central',1,1),
    ('Sede Regional San Carlos',2,1),
    ('Centro Académico San José',3,1);

INSERT INTO ESTUDIANTE (Nombre, Apellidos, Carrera, FechaNacimiento, LugarNacimiento, IdUniversidad)
VALUES ('Alejandro','Calvo Porras', 'Computadores', '1997-06-03', 1, 1),
    ('Erick','Muñoz Alvarado', 'Computadores', '1998-10-03', 3, 1),
    ('Fulanito', 'De Tal', 'Admin', '1992-05-02', 4, 1);

INSERT INTO RESTAURANTE (Nombre, Horario, IdSede, IdCalificacion)
VALUES ('Comedor','8:00-19:00', 1, 3);

INSERT INTO MENU (IdRestaurante, Horario, Fecha)
VALUES (1, 'Mañana', '2018-07-04'),
    (1, 'Mañana', '2018-07-05'),
    (1, 'Mañana', '2018-07-06'),
    (1, 'Mañana', '2018-07-14'),
    (1, 'Mañana', '2018-07-15'),
    (1, 'Mañana', '2018-07-16'),
    (1, 'Mañana', '2018-04-08'),
    (1, 'Mañana', '2018-08-05'),
    (1, 'Mañana', '2018-08-06'),
    (1, 'Tarde', '2018-07-04'),
    (1, 'Tarde', '2018-07-05'),
    (1, 'Tarde', '2018-07-06'),
    (1, 'Tarde', '2018-07-14'),
    (1, 'Tarde', '2018-07-15'),
    (1, 'Tarde', '2018-07-16'),
    (1, 'Tarde', '2018-04-08'),
    (1, 'Tarde', '2018-08-05'),
    (1, 'Tarde', '2018-08-06');


Insert INTO PLATILLO (Nombre, Precio)
VALUES ('Pinto',200),
    ('Huevo', 100),
    ('Salchichon',100),
    ('Natilla',100),
    ('Arroz',200),
    ('Frijoles',100),
    ('Pescado',800),
    ('Pollo Frito',600),
    ('Tortas de Carne',600),
    ('Fresco',150),
    ('Cafe',100),
    ('Repostería',300);
    
Insert INTO MENUXPLATILLO(IdMenu, IdPlatillo)
VALUES
    --Desayuno 
    (1,1),(1,2),
    (2,1),(2,3),
    (3,1),(3,4),
    (4,1),(4,2),(4,12),
    (5,1),(5,3),(5,11),
    (6,1),(6,4),
    (7,1),(7,2),
    (8,1),(8,3),(8,11),
    (9,1),(9,4),
    --Almuerzo
    (10,5),(10,6),(10,10),(10,7),
    (11,5),(11,6),(11,10),(11,8),
    (12,5),(12,6),(12,10),(12,9),
    (13,5),(13,6),(13,10),(13,7),
    (14,5),(14,6),(14,10),(14,8),
    (15,5),(15,6),(15,10),(15,9),
    (16,5),(16,6),(16,10),(16,7),
    (17,5),(17,6),(17,10),(17,8),
    (18,5),(18,6),(18,10),(18,9);
    
INSERT INTO VOTO (Hora, Fecha, Calificacion)
VALUES ('8:30','2018-07-04',1),
    ('8:45','2018-07-04',0),
    ('9:20','2018-07-04',1),
    ('9:32','2018-07-04',1),
    ('10:10','2018-07-06',1),
    ('8:25','2018-07-16',1),
    ('9:13','2018-07-16',0),
    ('11:20','2018-08-05',1),
    ('11:45','2018-08-05',1),
    ('12:00','2018-08-05',1);
    
INSERT INTO VOTOXPLATILLO (IdUniversidad, IdRestaurante, IdMenu, IdPlatillo, IdEstudiante, IdVoto)
VALUES (1,1,1,1,1,1),
    (1,1,2,1,2,2),
    (1,1,3,1,1,3),
    (1,1,4,2,1,4),
    (1,1,5,1,1,5),
    (1,1,6,1,3,6),
    (1,1,7,1,1,7),
    (1,1,10,8,1,8),
    (1,1,11,8,2,9),
    (1,1,12,8,3,10);
    

--Platillo mas gustado de todos
SELECT VOTOXPLATO.Nombre, MAX(VOTOXPLATO.Visits) Visits
FROM (
  SELECT PLATILLO.Nombre, COUNT(PLATILLO.Nombre) Visits
  FROM VOTOXPLATILLO
      INNER JOIN VOTO ON VOTOXPLATILLO.IdVoto = VOTO.IdVoto
      INNER JOIN PLATILLO ON VOTOXPLATILLO.IdPlatillo = PLATILLO.IdPlatillo
  GROUP BY PLATILLO.Nombre
) AS VOTOXPLATO;

--Platillo menos gustado de todos
SELECT VOTOXPLATO.Nombre, MIN(VOTOXPLATO.Visits) Visits
FROM (
  SELECT PLATILLO.Nombre, COUNT(PLATILLO.Nombre) Visits
  FROM VOTOXPLATILLO
      INNER JOIN VOTO ON VOTOXPLATILLO.IdVoto = VOTO.IdVoto
      INNER JOIN PLATILLO ON VOTOXPLATILLO.IdPlatillo = PLATILLO.IdPlatillo
  GROUP BY PLATILLO.Nombre
) AS VOTOXPLATO;

--Horario mas frecuentado
SELECT VOTOXPLATO.Horario, MAX(VOTOXPLATO.Visits) Visits
FROM (
  SELECT PLATILLO.IdPlatillo AS IdPlato, Menu.Horario, COUNT(MENU.Horario) Visits
  FROM VOTOXPLATILLO
      INNER JOIN VOTO ON VOTOXPLATILLO.IdVoto = VOTO.IdVoto
      INNER JOIN PLATILLO ON VOTOXPLATILLO.IdPlatillo = PLATILLO.IdPlatillo
      INNER JOIN MENU ON VOTOXPLATILLO.IdMenu = MENU.IdMenu
  GROUP BY MENU.Horario
) AS VOTOXPLATO;

--Se calcula la frecuencia de cada carrera por restaurante
SELECT VISITXCARRERA.Carrera AS Carrera, VISITXCARRERA.Restaurante AS Restaurante, MAX(VISITXCARRERA.VISITS) VISITS
FROM (
  SELECT Estudiante.Carrera AS Carrera, Restaurante.Nombre AS Restaurante, COUNT(ESTUDIANTE.Carrera) VISITS
  FROM VOTOXPLATILLO
  INNER JOIN VOTO ON VOTOXPLATILLO.IdVoto = VOTO.IdVoto
  INNER JOIN ESTUDIANTE ON VOTOXPLATILLO.IdEstudiante = ESTUDIANTE.IdEstudiante
  INNER JOIN RESTAURANTE ON VOTOXPLATILLO.IdRestaurante = RESTAURANTE.IdRestaurante
  
  GROUP BY Carrera, Restaurante
) AS VISITXCARRERA
GROUP BY VISITXCARRERA.Restaurante;

--Estudiante más participativo
SELECT VISITXESTUDIANTE.Nombre, VISITXESTUDIANTE.Restaurante, MAX(VISITXESTUDIANTE.VISITS) VISITS
FROM (
  SELECT ESTUDIANTE.Nombre AS Nombre, RESTAURANTE.Nombre AS Restaurante, COUNT(ESTUDIANTE.Nombre) VISITS
  FROM VOTOXPLATILLO
  INNER JOIN VOTO ON VOTOXPLATILLO.IdVoto = VOTO.IdVoto
  INNER JOIN ESTUDIANTE ON VOTOXPLATILLO.IdEstudiante = ESTUDIANTE.IdEstudiante
  INNER JOIN RESTAURANTE ON VOTOXPLATILLO.IdRestaurante = RESTAURANTE.IdRestaurante
  
  GROUP BY ESTUDIANTE.Nombre, Restaurante
) AS VISITXESTUDIANTE
GROUP BY VISITXESTUDIANTE.Restaurante;

