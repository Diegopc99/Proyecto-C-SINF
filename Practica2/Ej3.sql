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