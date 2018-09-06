PRAGMA foreign_keys = ON;
/*
 * DataBase Tables Creation
 */

CREATE TABLE Universidad (
    IdUniversidad         INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(40),
    IdCalificacion        INTEGER,
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));

CREATE TABLE Calificacion (
    IdCalificacion        INTEGER PRIMARY KEY AUTOINCREMENT,
    UpVotes               INTEGER,
    DownVotes             INTEGER);

CREATE TABLE Sede (
    IdSede                INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(20),
    IdCalificacion        INTEGER,
    IdUbicacion           INTEGER,
    IdUniversidad         INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_ubucacion FOREIGN KEY (IdUbicacion) REFERENCES Ubicacion(IdUbicacion),
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));

CREATE TABLE Ubicacion (
    IdUbicacion           INTEGER PRIMARY KEY AUTOINCREMENT,
    Pais                  VARCHAR(15),
    Provincia             VARCHAR(15),
    Ciudad                VARCHAR(20),
    Calle                 VARCHAR(20),
    Direccion             VARCHAR(50));

CREATE TABLE Estudiante (
    IdEstudiante          INTEGER PRIMARY KEY AUTOINCREMENT,
    IdUniversidad         INTEGER,
    Carrera               VARCHAR(40),
    FechaNacimiento       VARCHAR(10),
    LugarNacimiento       INTEGER,
    Nombre                VARCHAR(20),
    Apellidos             VARCHAR(25),
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_ubucacion FOREIGN KEY (LugarNacimiento) REFERENCES Ubicacion(IdUbicacion));

CREATE TABLE Restaurante (
    IdRestaurante         INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(30),
    Horario               VARCHAR(11),
    IdSede                INTEGER,
    IdCalificacion        INTEGER,
    CONSTRAINT fk_sede FOREIGN KEY (IdSede) REFERENCES Sede(IdSede),
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));

CREATE TABLE Menu (
    IdMenu                INTEGER PRIMARY KEY AUTOINCREMENT,
    IdRestaurante         INTEGER,
    Horario               TIME,
    Fecha                 DATE,
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante));

CREATE TABLE Platillo (
    IdPlatillo            INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre                VARCHAR(25),
    Precio                INTEGER,
    IdCalificacion        INTEGER,
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));

CREATE TABLE Voto (
    IdVoto                INTEGER PRIMARY KEY AUTOINCREMENT,
    Hora                  TIME,
    Fecha                 DATE,
    Calificacion          INTEGER);

CREATE TABLE VotoxUniversidad(
    IdUniversidad         INTEGER,
    IdEstudiante          INTEGER,
    IdVoto                INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES Voto(IdVoto));

CREATE TABLE VotoxRestaurante(
    IdUniversidad         INTEGER,
    IdRestaurante         INTEGER,
    IdEstudiante          INTEGER,
    IdVoto                INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES Voto(IdVoto));

CREATE TABLE VotoxPlatillo(
    IdUniversidad         INTEGER,
    IdRestaurante         INTEGER,
    IdPlatillo            INTEGER,
    IdEstudiante          INTEGER,
    IdVoto                INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES Voto(IdVoto));

CREATE TABLE RestaurantexPlatillo(
    IdRestaurante         INTEGER,
    IdPlatillo            INTEGER,
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo));

CREATE TABLE MenuxPlatillo(
    IdMenu                INTEGER,
    IdPlatillo            INTEGER,
    CONSTRAINT fk_menu FOREIGN KEY (IdMenu) REFERENCES Menu(IdMenu),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo));


INSERT INTO Universidad (Nombre)
VALUES ('TEC');

INSERT INTO Calificacion(UpVotes, DownVotes)
VALUES (50, 2),(10,25),(60,30);

UPDATE Universidad SET IdCalificacion = 1 WHERE IdUniversidad = 6;

INSERT INTO Ubicacion (Pais, Provincia, Ciudad, Calle, Direccion)
VALUES ('Costa Rica', 'Cartago', 'Cartago', 'Calle 15, Avenida 14', '1 km Sur de la Basílica de los Ángeles.'),
    ('Costa Rica', 'Alajuela', 'San Carlos', 'Carretera a Fortuna', '18 kilómetros al norte de Ciudad Quesada.'),
    ('Costa Rica', 'San José', 'San José', 'Calles 5 y 7, Avenida 9 y 11.', 'Barrio Amón'),
    ('Costa Rica', 'San José', 'San Pedro', 'Calles 59.', '3 kilómetros al este del centro de San José');


INSERT INTO Sede (Nombre, IdUbicacion, IdUniversidad)
VALUES ('Sede Central',1,1),
    ('Sede Regional San Carlos',2,1),
    ('Centro Académico San José',3,2);

INSERT INTO Estudiante (Nombre, Apellidos, Carrera, FechaNacimiento, LugarNacimiento, IdUniversidad)
VALUES ('Alejandro','Calvo Porras', 'Computadores', '03-06-1997', 1, 1),
    ('Erick','Muñoz Alvarado', 'Computadores', '03-10-1998', 3, 1),
    ('Fulanito', 'De Tal', 'Admin', '02-05-1992', 4, 1);

INSERT INTO Restaurante (Nombre, Horario, IdSede, IdCalificacion)
VALUES ('Comedor','8:00-19:00', 1, 3);

INSERT INTO Menu (IdRestaurante, Horario, Fecha)
VALUES (1, 'Mañana', '04-07-2018'),
    (1, 'Mañana', '05-07-2018'),
    (1, 'Mañana', '06-07-2018'),
    (1, 'Mañana', '14-07-2018'),
    (1, 'Mañana', '15-07-2018'),
    (1, 'Mañana', '16-07-2018'),
    (1, 'Mañana', '04-08-2018'),
    (1, 'Mañana', '05-08-2018'),
    (1, 'Mañana', '06-08-2018'),
    (1, 'Tarde', '04-07-2018'),
    (1, 'Tarde', '05-07-2018'),
    (1, 'Tarde', '06-07-2018'),
    (1, 'Tarde', '14-07-2018'),
    (1, 'Tarde', '15-07-2018'),
    (1, 'Tarde', '16-07-2018'),
    (1, 'Tarde', '04-08-2018'),
    (1, 'Tarde', '05-08-2018'),
    (1, 'Tarde', '06-08-2018');


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
VALUES ('8:30','04-07-2018',1),
    ('8:45','04-07-2018',0),
    ('9:20','04-07-2018',1),
    ('9:32','04-07-2018',1),
    ('10:10','06-07-2018',1),
    ('8:25','16-07-2018',1),
    ('9:13','16-07-2018',0),
    ('11:20','05-08-2018',1),
    ('11:45','05-08-2018',1),
    ('12:00','05-08-2018',1);
    
INSERT INTO VOTOXPLATILLO (IdUniversidad, IdRestaurante, IdPlatillo, IdEstudiante, IdVoto)
VALUES (1,1,1,1,1),
    (1,1,1,2,2),
    (1,1,1,1,3),
    (1,1,2,1,4),
    (1,1,1,1,5),
    (1,1,1,3,6),
    (1,1,1,1,7),
    (1,1,8,1,8),
    (1,1,8,2,9),
    (1,1,8,3,10);
