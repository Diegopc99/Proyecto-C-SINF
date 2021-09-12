DROP DATABASE Practica2;
 CREATE DATABASE Practica2;

 USE Practica2;
 
 CREATE TABLE Actores(
    ID_actor INT AUTO_INCREMENT,
    nombre VARCHAR (30),
    PRIMARY KEY (ID_actor)
 );

 INSERT INTO Actores(nombre) VALUES
    ('Leonardo DiCaprio'),
    ('Jason Statham'),
    ('Paul Walker'),
    ('Vin Diesel'),
    ('Emma Watson');

 CREATE TABLE Directores(
     ID_director INT AUTO_INCREMENT,
     nombre VARCHAR (30), 
     PRIMARY KEY (ID_director)

 );

INSERT INTO Directores(nombre) VALUES
    ('Justin Lin'),
    ('Peter Jackson'),
    ('Ang Lee'),
    ('Zack Snyder'),
    ('Michael Mann');

 CREATE TABLE Peliculas(
     ID_pelicula INT AUTO_INCREMENT,
     nombre VARCHAR (30),
     PRIMARY KEY (ID_pelicula),
     ID_director INT,
     FOREIGN KEY (ID_director) REFERENCES Directores(ID_director)  
 );

INSERT INTO Peliculas(nombre,ID_director) VALUES
    ('The Fast & The Furious','1'),
    ('The Lord Of The Rings','2'),
    ('Brokebark Mountain','3'),
    ('300','4'),
    ('Heat','5');


 
SELECT * FROM Directores INNER JOIN Peliculas ON Peliculas.ID_director = Directores.ID_director;

SELECT Directores.nombre FROM Directores INNER JOIN Peliculas ON Peliculas.ID_director = Directores.ID_director WHERE Peliculas.ID_pelicula = 2; -- Printea solo el nombre del director de la pelicula con id 1

