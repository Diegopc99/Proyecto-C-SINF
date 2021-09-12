DROP TRIGGER IF EXISTS trigger_estado_espectaculo;

DELIMITER //


-- TRIGGER PARA CADA VEZ QUE SE INSERTE UNA NUEVA ENTRADA, COMPROBAR EL ESTADO DEL ESPECTACULO
CREATE TRIGGER trigger_estado_espectaculo AFTER INSERT ON Entrada FOR EACH ROW
BEGIN
DECLARE cada_id_grada INT;
DECLARE fin INT DEFAULT FALSE;
DECLARE cursorGrada CURSOR FOR SELECT DISTINCT ID_grada FROM Entrada WHERE Entrada.ID_entrada = new.ID_entrada;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN cursorGrada;
    bucle: LOOP
    FETCH cursorGrada INTO cada_id_grada; -- Me quedo con la grada de la localidad que ha sido reservada
    
    IF fin THEN LEAVE bucle;
    END IF;

    -- Si todas las localidades están en alguna entrada (y por tanto no están libres, nos quedamos con su Espectáculo y lo cerramos)

    IF NOT EXISTS (

        SELECT * FROM Localidad WHERE Localidad.ID_localidad NOT IN (SELECT Entrada.ID_localidad FROM Entrada) AND Localidad.ID_grada = cada_id_grada AND Localidad.estado="Libre"

    )

    -- ¿ Como comprobar aquí si otras gradas también se han agotado?
    -- Ver para cada grada, si coinciden todas sus localidades con las localidades en objetos Entrada
    -- ¿ Hacer esto en otro trigger o procedure y llamarlo ?

    THEN UPDATE CelebradoEn SET estado="Cerrado(sinentradas)" WHERE ID_espectaculo = new.ID_espectaculo;
    ELSE UPDATE CelebradoEn SET estado="Abierto" WHERE ID_espectaculo = new.ID_espectaculo;
    
    END IF;
    END LOOP;

CLOSE cursorGrada;
END //

DELIMITER ;

-- NOTA: en verdad debería ser AFTER INSERT ON Reserva, ya que cuando se confirme una prerreserva, eso no va a crear otra entrada
-- ¿ Crear luego otro trigger AFTER UPDATE ON Reserva ?