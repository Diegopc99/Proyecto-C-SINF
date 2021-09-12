 DROP DATABASE Practica2;
 CREATE DATABASE Practica2;

 USE Practica2;
 
 CREATE TABLE Actores(
    ID_actor INT AUTO_INCREMENT,
    nombre VARCHAR (30),
    PRIMARY KEY (ID_actor) 
 );

 CREATE TABLE Directores(
     ID_director INT AUTO_INCREMENT,
     nombre VARCHAR (30), 
     PRIMARY KEY (ID_director) 
 );
 CREATE TABLE Peliculas(
     ID_pelicula INT AUTO_INCREMENT,
     nombre VARCHAR (30),
     PRIMARY KEY (ID_pelicula) 
 );

INSERT INTO Actores(nombre) VALUES
    ('Leonardo DiCaprio'),
    ('Jason Statham'),
    ('Paul Walker'),
    ('Vin Diesel'),
    ('Emma Watson');

INSERT INTO Directores(nombre) VALUES
    ('Justin Lin'),
    ('Peter Jackson'),
    ('Ang Lee'),
    ('Zack Snyder'),
    ('Michael Mann');

INSERT INTO Peliculas(nombre) VALUES
    ('The Fast & The Furious'),
    ('The Lord Of The Rings'),
    ('Brokebark Mountain'),
    ('300'),
    ('Heat');


 
