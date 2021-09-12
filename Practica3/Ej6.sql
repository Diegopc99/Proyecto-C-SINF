
DROP DATABASE Practica3;
CREATE DATABASE Practica3;

USE Practica3;

DELIMITER //

CREATE PROCEDURE ponerEnMayusculas(IN cadena_minus VARCHAR (30),OUT cadena_mayus VARCHAR (30))

BEGIN

    SET cadena_mayus = UPPER(cadena_minus);

END //

DELIMITER ;


CALL ponerEnMayusculas("HOla",@cadena);

SELECT @cadena;

