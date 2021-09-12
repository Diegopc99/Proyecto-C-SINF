DROP DATABASE Practica3;
 CREATE DATABASE Practica3;

 USE Practica3;
 
 CREATE TABLE Actores(
    ID_actor INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR (30) NOT NULL,
    PRIMARY KEY (ID_actor),
    IMDb INT UNIQUE,
    edad INT NOT NULL,
    CONSTRAINT check_edad CHECK (edad > -1 AND edad < 121)
 );

 INSERT INTO Actores(nombre,IMDb,edad) VALUES
    ('Leonardo DiCaprio','0000138','130'),
    ('Jason Statham','0005458','54'),
    ('Paul Walker','0908094','32'),
    ('Vin Diesel','0004874','46'),
    ('Emma Watson','0914612','-1');

 CREATE TABLE Directores(
     ID_director INT AUTO_INCREMENT NOT NULL,
     nombre VARCHAR (30) NOT NULL, 
     PRIMARY KEY (ID_director),
     IMDb INT UNIQUE,
     edad INT NOT NULL,
    CONSTRAINT check_edad CHECK (edad > -1 AND edad < 121)
 );

INSERT INTO Directores(nombre,IMDb,edad) VALUES
    ('Justin Lin','0510912','34'),
    ('Peter Jackson','0001392','40'),
    ('Ang Lee','0000487','52'),
    ('Zack Snyder','0811583','60'),
    ('Michael Mann','0000520','25');

 CREATE TABLE Peliculas(
     ID_pelicula INT AUTO_INCREMENT NOT NULL,
     nombre VARCHAR (30) NOT NULL,
     PRIMARY KEY (ID_pelicula),
     ID_director INT NOT NULL,
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
     ID_actor INT  NOT NULL,
     ID_pelicula INT  NOT NULL,
     FOREIGN KEY (ID_actor) REFERENCES Actores(ID_actor),
     FOREIGN KEY (ID_pelicula) REFERENCES Peliculas (ID_pelicula)
 );

INSERT INTO Actua_En(ID_actor,ID_pelicula) VALUES
    ('2','1'),
    ('3','1'),
    ('4','1'),
    ('1','5');

DELIMITER // 

DROP PROCEDURE IF EXISTS introducir_pelicula;

CREATE PROCEDURE introducir_pelicula()
BEGIN

    START TRANSACTION;

    INSERT INTO Directores(nombre,IMDb,edad) VALUES ("Paco Fiestas","0002347",'22');
    SELECT SLEEP(30);

    COMMIT;

END //

DELIMITER ;

CALL introducir_pelicula();
