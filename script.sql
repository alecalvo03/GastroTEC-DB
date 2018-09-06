PRAGMA foreign_keys = ON;

CREATE TABLE Universidad (
    IdUniversidad INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre VARCHAR(40),
    IdCalificacion INTEGER,
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));
    
CREATE TABLE Calificacion (
    IdCalificacion INTEGER PRIMARY KEY AUTOINCREMENT,    
    UpVotes INTEGER,
    DownVotes INTEGER);
    
CREATE TABLE Sede (
    IdSede INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre VARCHAR(20),
    IdCalificacion INTEGER,
    IdUbicacion INTEGER,
    IdUniversidad INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_ubucacion FOREIGN KEY (IdUbicacion) REFERENCES Ubicacion(IdUbicacion),
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));
    
CREATE TABLE Ubicacion (
    IdUbicacion INTEGER PRIMARY KEY AUTOINCREMENT,
    Pais VARCHAR(15),
    Provincia VARCHAR(15),
    Ciudad VARCHAR(20),
    Calle VARCHAR(20),
    Direccion VARCHAR(50));

CREATE TABLE Estudiante (
    IdEstudiante INTEGER PRIMARY KEY AUTOINCREMENT,
    Carrera VARCHAR(40),
    FechaNacimiento VARCHAR(8),
    LugarNacimiento INTEGER,
    Nombre VARCHAR(20),
    Apellidos VARCHAR(25),
    CONSTRAINT fk_ubucacion FOREIGN KEY (LugarNacimiento) REFERENCES Ubicacion(IdUbicacion));
     
CREATE TABLE Restaurante (
    IdRestaurante INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre VARCHAR(30),
    Horario VARCHAR(11),
    Platillos INTEGER,
    IdSede INTEGER,
    IdPlatillo INTEGER,
    IdCalificacion INTEGER,
    CONSTRAINT fk_sede FOREIGN KEY (IdSede) REFERENCES Sede(IdSede),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo),
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));
    
CREATE TABLE Platillo(
    IdPlatillo INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre VARCHAR(25),
    Precio INTEGER,
    IdCalificacion INTEGER,
    CONSTRAINT fk_calificacion FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(IdCalificacion));
    
CREATE TABLE Menu(
    IdPlatillo INTEGER,
    Horario TIME,
    Fecha DATE,
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo));
    
CREATE TABLE Voto(
    IdVoto INTEGER PRIMARY KEY AUTOINCREMENT,
    Hora TIME,
    Fecha DATE,
    Calificacion INTEGER);
    
CREATE TABLE VotoxUniversidad(
    IdUniversidad INTEGER,
    IdEstudiante INTEGER,
    IdVoto INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES Voto(IdVoto));
    
CREATE TABLE VotoxRestaurante(
    IdUniversidad INTEGER,
    IdRestaurante INTEGER,
    IdEstudiante INTEGER,
    IdVoto INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES Voto(IdVoto));

CREATE TABLE VotoxPlatillo(
    IdUniversidad INTEGER,
    IdRestaurante INTEGER,
    IdPlatillo INTEGER,
    IdEstudiante INTEGER,
    IdVoto INTEGER,
    CONSTRAINT fk_universidad FOREIGN KEY (IdUniversidad) REFERENCES Universidad(IdUniversidad),
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo),
    CONSTRAINT fk_estudiante FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    CONSTRAINT fk_voto FOREIGN KEY (IdVoto) REFERENCES Voto(IdVoto));
    
CREATE TABLE RestaurantexPlatillo(
    IdRestaurante INTEGER,
    IdPlatillo INTEGER,
    CONSTRAINT fk_restaurante FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante),
    CONSTRAINT fk_platillo FOREIGN KEY (IdPlatillo) REFERENCES Platillo(IdPlatillo));