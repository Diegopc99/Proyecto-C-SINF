DROP DATABASE Practica2;
 CREATE DATABASE Practica2;

 USE Practica2;
 
 CREATE TABLE Actores(
    ID_actor INT AUTO_INCREMENT,
    nombre VARCHAR (30),
    PRIMARY KEY (ID_actor),
    IMDb INT UNIQUE
 );

 INSERT INTO Actores(nombre,IMDb) VALUES
    ('Leonardo DiCaprio','0000138'),
    ('Jason Statham','0005458'),
    ('Paul Walker','0908094'),
    ('Vin Diesel','0004874'),
    ('Emma Watson','0914612');

 CREATE TABLE Directores(
     ID_director INT AUTO_INCREMENT,
     nombre VARCHAR (30), 
     PRIMARY KEY (ID_director),
     IMDb INT UNIQUE

 );

INSERT INTO Directores(nombre,IMDb) VALUES
    ('Justin Lin','0510912'),
    ('Peter Jackson','0001392'),
    ('Ang Lee','0000487'),
    ('Zack Snyder','0811583'),
    ('Michael Mann','0000520');

 CREATE TABLE Peliculas(
     ID_pelicula INT AUTO_INCREMENT,
     nombre VARCHAR (30),
     PRIMARY KEY (ID_pelicula),
     ID_director INT,
     FOREIGN KEY (ID_director) REFERENCES Directores(ID_director),
     IMDb INT UNIQUE  
 );

 INSERT INTO Peliculas(nombre,ID_director,IMDb) VALUES
    ('The Fast & The Furious','1','0232500'),
    ('The Lord Of The Rings','2','0120737'),
    ('Brokebark Mountain','3','0388795'),
    ('300','4','0416449'),
    ('Heat','5','0113277');

 CREATE TABLE Actua_En(
     ID_actor INT,
     ID_pelicula INT,
     FOREIGN KEY (ID_actor) REFERENCES Actores(ID_actor),
     FOREIGN KEY (ID_pelicula) REFERENCES Peliculas (ID_pelicula)
 );

INSERT INTO Actua_En(ID_actor,ID_pelicula) VALUES
    ('2','1'),
    ('3','1'),
    ('4','1'),
    ('1','5'),
    ('5','4');

SELECT Actores.nombre FROM Actua_En 
    INNER JOIN 
        Actores 
    ON
        Actua_En.ID_actor=Actores.ID_actor
    INNER JOIN 
        Peliculas
    ON
        Actua_En.ID_pelicula=Peliculas.ID_pelicula

WHERE Peliculas.ID_pelicula = 1; -- Printea solo los actores de la pelicula 1 (actores de fast and furious)