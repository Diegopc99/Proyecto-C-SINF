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

ALTER TABLE Actores ADD nacionalidad varchar (30) NOT NULL;
ALTER TABLE Peliculas ADD nacionalidad varchar (30) NOT NULL;
ALTER TABLE Directores ADD nacionalidad varchar (30) NOT NULL;

UPDATE Actores SET nacionalidad='EEUU' WHERE Actores.nombre= "Jason Statham";
UPDATE Actores SET nacionalidad='EEUU' WHERE Actores.nombre="Leonardo DiCaprio";
UPDATE Actores SET nacionalidad='EEUU' WHERE Actores.nombre="Vin Diesel";
UPDATE Actores SET nacionalidad='England' WHERE Actores.nombre="Emma Watson";

UPDATE Peliculas SET nacionalidad='EEUU' WHERE Peliculas.nombre="300";

UPDATE Directores SET nacionalidad='EEUU' WHERE Directores.nombre="Zack Snyder";


DELIMITER $$

DROP TRIGGER IF EXISTS actualizar_imdb;

CREATE TRIGGER actualizar_imdb AFTER INSERT ON Directores FOR EACH ROW
BEGIN
    DECLARE nacion_aux VARCHAR (30);
    DECLARE imdb_aux INT;

    SELECT Directores.nacionalidad INTO nacion_aux FROM Directores WHERE ID_Director= NEW.ID_Director;
    SELECT Directores.IMDb INTO imdb_aux FROM Directores WHERE ID_Director = NEW.ID_Director;

    INSERT INTO EEUU (imdb) VALUES (imdb_aux);

END $$

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS extraer_imdbs;

CREATE PROCEDURE extraer_imdbs(IN nacionalidad VARCHAR(30))
BEGIN

    DECLARE imdb_aux INT;

    DECLARE fin INT;

    DECLARE cursor_actores CURSOR FOR
        SELECT Actores.IMDb FROM Actores WHERE Actores.nacionalidad = nacionalidad;

    DECLARE cursor_peliculas CURSOR FOR
        SELECT Peliculas.IMDb FROM Peliculas  WHERE Peliculas.nacionalidad = nacionalidad;

    DECLARE cursor_directores CURSOR FOR
        SELECT Directores.IMDb FROM Directores  WHERE Directores.nacionalidad = nacionalidad;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

    SET @comandoCREATETABLE = CONCAT("CREATE TABLE ",nacionalidad,"(imdb INT);");
    PREPARE scriptComando FROM @comandoCREATETABLE;
    EXECUTE scriptComando;

    SET imdb_aux = 0;
    SET fin = 0;

        OPEN cursor_actores;
        BEGIN
            bucle_actores : LOOP 
            FETCH cursor_actores INTO imdb_aux;
            IF(fin = 1)THEN 
                LEAVE bucle_actores;
            ELSE
                SET @insert_value = CONCAT("INSERT INTO ",nacionalidad,"(imdb) ","VALUES(",imdb_aux,");");
                PREPARE script_insert FROM @insert_value;
                EXECUTE script_insert;
            END IF;
            END LOOP bucle_actores;
        END;
        CLOSE cursor_actores;

    SET imdb_aux = 0;
    SET fin = 0;

        OPEN cursor_peliculas;
        BEGIN
            bucle_peliculas : LOOP 
            FETCH cursor_peliculas INTO imdb_aux;
            IF(fin = 1)THEN 
                LEAVE bucle_peliculas;
            ELSE
                SET @insert_value = CONCAT("INSERT INTO ",nacionalidad,"(imdb) ","VALUES(",imdb_aux,");");
                PREPARE script_insert FROM @insert_value;
                EXECUTE script_insert;
            END IF;
            END LOOP bucle_peliculas;
        END;
        CLOSE cursor_peliculas;

    SET imdb_aux = 0;
    SET fin = 0;

        OPEN cursor_directores;
        BEGIN
            bucle_directores : LOOP 
            FETCH cursor_directores INTO imdb_aux;
            IF(fin = 1)THEN 
                LEAVE bucle_directores;
            ELSE
                SET @insert_value = CONCAT("INSERT INTO ",nacionalidad,"(imdb) ","VALUES(",imdb_aux,");");
                PREPARE script_insert FROM @insert_value;
                EXECUTE script_insert;
            END IF;
            END LOOP bucle_directores;
        END;
        CLOSE cursor_directores;

    SET @comando_select = CONCAT("SELECT * FROM ",nacionalidad,";");
    PREPARE scriptSelect FROM @comando_select;
    EXECUTE scriptSelect;

END //

DELIMITER ;

CALL extraer_imdbs("EEUU");

