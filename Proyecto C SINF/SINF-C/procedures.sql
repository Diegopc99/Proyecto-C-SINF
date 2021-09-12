DELIMITER //
DROP PROCEDURE IF EXISTS CrearEventos //

CREATE PROCEDURE CrearEventos(
    IN ID_espectaculoIN INT,
    IN ID_recintoIN INT,
    IN fecha_inicio TIMESTAMP,
    IN fecha_fin TIMESTAMP,
    IN ent_bebe BOOLEAN,
    IN ent_infantil BOOLEAN,
    IN ent_parado BOOLEAN,
    IN ent_jubilado BOOLEAN)

BEGIN

    IF ((fecha_fin < fecha_inicio) OR (fecha_fin < NOW()) OR (fecha_inicio < NOW())) THEN
        CALL raise(1356,"Fechas introducidas incorrectas.");
    END IF;

    IF ((SELECT EXISTS(SELECT * FROM Espectaculo WHERE Espectaculo.ID_espectaculo = ID_espectaculoIN)) = '') THEN
        CALL raise(1356,"El espectaculo introducido no existe.");
    END IF;

    IF ((SELECT EXISTS(SELECT * FROM Recinto WHERE Recinto.ID_recinto = ID_recintoIN)) = '') THEN
        CALL raise(1356,"El recinto introducido no existe.");
    END IF;

    IF (SELECT EXISTS(SELECT * FROM CelebradoEn WHERE CelebradoEn.ID_espectaculo = ID_espectaculoIN AND CelebradoEn.ID_recinto = ID_recintoIN AND ((fecha_inicio BETWEEN CelebradoEn.fecha_inicio AND CelebradoEn.fecha_fin) OR (fecha_fin BETWEEN CelebradoEn.fecha_inicio AND CelebradoEn.fecha_fin) OR (fecha_inicio < CelebradoEn.fecha_inicio AND fecha_fin > CelebradoEn.fecha_fin)))) THEN
        CALL raise(1356,"Un evento ya existe con esas caracteristicas.");
    END IF;



INSERT INTO CelebradoEn(ID_espectaculo,ID_recinto,fecha_inicio,fecha_fin,estado,entradasBebe,entradasInfantil,entradasParado,entradasJubilado) VALUES (ID_espectaculoIN, ID_recintoIN, fecha_inicio, fecha_fin, "Abierto", ent_bebe, ent_infantil, ent_parado, ent_jubilado);

END //

DROP PROCEDURE IF EXISTS InsertarPrecios//

CREATE PROCEDURE InsertarPrecios(
    IN ID_CelebradoEnIN INT,
    IN ID_gradaIN INT,
    IN PrecioBebeIN DECIMAL(5,2),
    IN PrecioInfantilIN DECIMAL(5,2),
    IN PrecioParadoIN DECIMAL(5,2),
    IN PrecioJubiladoIN DECIMAL(5,2),
    IN PrecioAdultoIN DECIMAL(5,2)
)

BEGIN

DECLARE ID_recintoAUX INT;
DECLARE checkBebe BOOLEAN;
DECLARE checkInfantil BOOLEAN;
DECLARE checkParado BOOLEAN;
DECLARE checkJubilado BOOLEAN;

-- Selecciono el ID del recinto que aloje dicho espectaculo y dicha grada recibida
-- Tiene que coincidir cada uno de sus ID (Recinto, Grada y Espectaculo)
SELECT Grada.ID_recinto INTO ID_recintoAUX FROM Grada, CelebradoEn WHERE Grada.ID_grada = ID_gradaIN AND CelebradoEn.ID_recinto = Grada.ID_recinto AND CelebradoEn.ID_CelebradoEn = ID_CelebradoEnIN;

SELECT CelebradoEn.entradasBebe INTO checkBebe FROM CelebradoEn WHERE CelebradoEn.ID_CelebradoEn = ID_CelebradoEnIN;
SELECT CelebradoEn.entradasInfantil INTO checkInfantil FROM CelebradoEn WHERE CelebradoEn.ID_CelebradoEn = ID_CelebradoEnIN;
SELECT CelebradoEn.entradasJubilado INTO checkJubilado FROM CelebradoEn WHERE CelebradoEn.ID_CelebradoEn = ID_CelebradoEnIN;
SELECT CelebradoEn.entradasParado INTO checkParado FROM CelebradoEn WHERE CelebradoEn.ID_CelebradoEn = ID_CelebradoEnIN;

    IF (ID_recintoAUX IS NULL) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El ID de grada introducido no pertenece al Espectáculo con dicho ID de espectáculo";
    ELSE
        -- Comprobar aquí los booleanos de CelebradoEn y en función de sus valores, actualizar precios o no
        IF NOT (checkBebe)     THEN SET PrecioBebeIN = NULL; END IF;
        IF NOT (checkInfantil) THEN SET PrecioInfantilIN = NULL; END IF;
        IF NOT (checkParado)   THEN SET PrecioParadoIN = NULL; END IF;
        IF NOT (checkJubilado) THEN SET PrecioJubiladoIN = NULL; END IF;

        UPDATE Grada SET precioJubilado=PrecioJubiladoIN, precioAdulto=PrecioAdultoIN, precioInfantil=PrecioInfantilIN, precioParado=PrecioParadoIN, precioBebe=PrecioBebeIN WHERE Grada.ID_recinto = ID_recintoAUX;
    
    END IF;
END //


DROP PROCEDURE IF EXISTS estadoLocalidades_grada//

CREATE PROCEDURE estadoLocalidades_grada(
    IN ID_gradaIN INT,
    IN ID_eventoIN INT
)

BEGIN

    SELECT Grada.ID_grada,Grada.nombre,Localidad.ID_localidad,Localidad.num_asiento,Localidad.estado FROM Localidad 
        INNER JOIN 
            Grada 
        ON 
            Grada.ID_grada = Localidad.ID_grada
        INNER JOIN 
            Recinto
        ON 
            Recinto.ID_recinto = Grada.ID_recinto
        INNER JOIN 
            CelebradoEn
        ON 
            CelebradoEn.ID_recinto = Recinto.ID_recinto

    WHERE CelebradoEn.ID_CelebradoEn = ID_eventoIN AND Grada.ID_grada = ID_gradaIN; 

END //    


DROP PROCEDURE IF EXISTS listarEventos//

CREATE PROCEDURE listarEventos(

)

BEGIN

    SELECT DISTINCT CelebradoEn.ID_CelebradoEn AS ID_Evento,Espectaculo.nombre AS Espectaculo,CelebradoEn.estado,Grada.nombre AS Nombre_Grada,Grada.ID_grada,Grada.precioJubilado,Grada.precioAdulto,Grada.precioBebe,Grada.precioInfantil,Grada.precioParado FROM CelebradoEn
        INNER JOIN 
            Espectaculo
        ON 
            Espectaculo.ID_espectaculo = CelebradoEn.ID_espectaculo
        INNER JOIN
            Recinto
        ON 
            CelebradoEn.ID_recinto = Recinto.ID_recinto
        INNER JOIN 
            Grada
        ON 
            Recinto.ID_recinto = Grada.ID_recinto

    ORDER BY CelebradoEn.ID_CelebradoEn,Grada.ID_grada;

END // 

DROP PROCEDURE IF EXISTS crearPreReserva//

CREATE PROCEDURE crearPreReserva(
    IN num_localidades_reservaIN INT,
    IN ID_CelebradoEnIN INT,
    IN ID_gradaIN INT,
    IN DNI_clienteIN CHAR (9),
    IN tipoUsuarioIN VARCHAR (15)
)

BEGIN

    DECLARE var_ID_espectaculo INT;
    DECLARE var_ID_localidad INT;
    DECLARE precio_reserva INT;
    DECLARE var_ID_entrada INT;
    DECLARE var_ID_reserva INT;
    DECLARE p1 INT DEFAULT 0;

    IF ((SELECT CelebradoEn.estado FROM CelebradoEn WHERE CelebradoEn.ID_CelebradoEn = ID_CelebradoEnIN) = "Cerrado") THEN
        CALL raise(1356,"Ya no se pueden hacer pre-reservas.");
    END IF;

    IF (num_localidades_reservaIN > (SELECT COUNT(Localidad.ID_localidad) FROM Localidad WHERE Localidad.estado="Libre" AND Localidad.ID_grada = ID_gradaIN)) THEN
        CALL raise(1356,"No hay suficientes localidades libres para reservar.");
    END IF;

    IF ((SELECT EXISTS(SELECT * FROM Cliente WHERE DNI = DNI_clienteIN)) = '') THEN
        CALL raise(1356,"No existe el cliente en la base de datos.");
    END IF;
    

    SELECT Espectaculo.ID_espectaculo INTO var_ID_espectaculo FROM CelebradoEn
        INNER JOIN 
            Espectaculo
        ON
            CelebradoEn.ID_espectaculo = Espectaculo.ID_espectaculo

    WHERE ID_CelebradoEn = ID_CelebradoEnIN;

    -- --------------------------------------------------------

    IF(tipoUsuarioIN = "Jubilado")THEN
        SELECT Grada.precioJubilado INTO precio_reserva FROM Grada
            WHERE Grada.ID_grada = ID_gradaIN;
    END IF;
    IF(tipoUsuarioIN = "Bebe")THEN
        SELECT Grada.precioBebe INTO precio_reserva FROM Grada
            WHERE Grada.ID_grada = ID_gradaIN;
    END IF;
    IF(tipoUsuarioIN = "Parado")THEN
        SELECT Grada.precioParado INTO precio_reserva FROM Grada
            WHERE Grada.ID_grada = ID_gradaIN;
    END IF;
    IF(tipoUsuarioIN = "Infantil")THEN
        SELECT Grada.precioInfantil INTO precio_reserva FROM Grada
            WHERE Grada.ID_grada = ID_gradaIN;
    END IF;
    IF(tipoUsuarioIN = "Adulto")THEN
        SELECT Grada.precioAdulto INTO precio_reserva FROM Grada
            WHERE Grada.ID_grada = ID_gradaIN;
    END IF;

    SET precio_reserva = precio_reserva * num_localidades_reservaIN;

    -- ------------------------------------------------------------------

    SET @insert_Reserva = CONCAT("INSERT INTO Reserva(DNI_cliente,estado,precio,tipoUsuario) VALUES('",DNI_clienteIN,"','Pre-Reservado','",precio_reserva,"','",tipoUsuarioIN,"');");
    PREPARE script_insert_Reserva FROM @insert_Reserva;
    EXECUTE script_insert_Reserva;

        SELECT Reserva.ID_reserva INTO var_ID_reserva FROM Reserva
            WHERE Reserva.DNI_cliente = DNI_clienteIN AND Reserva.estado = "Pre-Reservado" AND Reserva.precio = precio_reserva AND Reserva.tipoUsuario = tipoUsuarioIN;

    -- ----------------------------------------------------------------------

    label1: LOOP
    SET p1 = p1 + 1;

        SELECT Localidad.ID_localidad INTO var_ID_localidad FROM Grada
            INNER JOIN 
                Localidad
            ON 
                Grada.ID_grada = Localidad.ID_grada
        
        WHERE Grada.ID_grada = ID_gradaIN AND Localidad.estado = "Libre" LIMIT 1;

        -- Cambiamos el estado de esa localidad a reservado

        UPDATE Localidad SET Localidad.estado = "Pre-Reservado" WHERE Localidad.ID_localidad = var_ID_localidad;

        SET @insert_Entrada = CONCAT("INSERT INTO Entrada(ID_CelebradoEn,ID_localidad,ID_grada) VALUES(",ID_CelebradoEnIN,",",var_ID_localidad,",",ID_gradaIN,");");
        PREPARE script_insert_Entrada FROM @insert_Entrada;
        EXECUTE script_insert_Entrada;

             SELECT Entrada.ID_entrada INTO var_ID_entrada FROM Entrada
                 WHERE Entrada.ID_localidad = var_ID_localidad AND Entrada.ID_grada = ID_gradaIN AND Entrada.ID_CelebradoEn = ID_CelebradoEnIN;

        SET @insert_ReservaEntrada = CONCAT("INSERT INTO ReservaEntrada(ID_entrada,ID_reserva) VALUES(",var_ID_entrada,",",var_ID_reserva,");");
        PREPARE script_insert_ReservaEntrada FROM @insert_ReservaEntrada;
        EXECUTE script_insert_ReservaEntrada;

        -- *************************************************

    IF p1 < num_localidades_reservaIN THEN
      ITERATE label1;
    END IF;
    LEAVE label1;
    END LOOP label1;

    -- ----------------------------------------------------------------

END //

DROP PROCEDURE IF EXISTS confirmarPagos //

CREATE PROCEDURE confirmarPagos(
    IN ID_reservaIN INT,
    IN IBANIN VARCHAR(34),
    IN num_localidades_reservaIN INT,
    IN ID_CelebradoEnIN INT,
    IN ID_gradaIN INT,
    IN DNI_clienteIN CHAR (9),
    IN tipoUsuarioIN VARCHAR (15)
)

BEGIN

    DECLARE var_ID_espectaculo INT;
    DECLARE var_ID_localidad INT;
    DECLARE precio_reserva INT;
    DECLARE var_ID_entrada INT;
    DECLARE var_ID_reserva INT;
    DECLARE p1 INT DEFAULT 0;

    IF(ID_reservaIN IS NOT NULL) THEN -- Cambiamos el estado de la reserva/pre-reserva

        IF ((SELECT EXISTS(SELECT * FROM Cliente WHERE IBAN = IBANIN)) = '') THEN
            CALL raise(1356,"No existe el cliente al que se le quiere realizar el pago.");
        END IF;

        -- IF ((SELECT Reserva.estado FROM Reserva WHERE Reserva.ID_reserva = ID_reservaIN) = "Reservado") THEN
           -- UPDATE Reserva SET Reserva.estado = "Pagado" WHERE Reserva.ID_reserva = ID_reservaIN;
        -- END IF;

        IF ((SELECT Reserva.estado FROM Reserva WHERE Reserva.ID_reserva = ID_reservaIN) = "Pre-Reservado") THEN
            UPDATE Reserva SET Reserva.estado = "Reservado" WHERE Reserva.ID_reserva = ID_reservaIN;
        END IF;
    END IF;

    IF(ID_reservaIN IS NULL) THEN -- Creamos el pago al momento, sin pre_reserva

        IF (num_localidades_reservaIN > (SELECT COUNT(Localidad.ID_localidad) FROM Localidad WHERE Localidad.estado="Libre" AND Localidad.ID_grada = ID_gradaIN)) THEN
            CALL raise(1356,"No hay suficientes localidades libres para prereservar.");
        END IF;

        SELECT Espectaculo.ID_espectaculo INTO var_ID_espectaculo FROM CelebradoEn
            INNER JOIN 
                Espectaculo
            ON
                CelebradoEn.ID_espectaculo = Espectaculo.ID_espectaculo

        WHERE ID_CelebradoEn = ID_CelebradoEnIN;

        -- --------------------------------------------------------

        IF(tipoUsuarioIN = "Jubilado")THEN
            SELECT Grada.precioJubilado INTO precio_reserva FROM Grada
                WHERE Grada.ID_grada = ID_gradaIN;
        END IF;
        IF(tipoUsuarioIN = "Bebe")THEN
            SELECT Grada.precioBebe INTO precio_reserva FROM Grada
                WHERE Grada.ID_grada = ID_gradaIN;
        END IF;
        IF(tipoUsuarioIN = "Parado")THEN
            SELECT Grada.precioParado INTO precio_reserva FROM Grada
                WHERE Grada.ID_grada = ID_gradaIN;
        END IF;
        IF(tipoUsuarioIN = "Infantil")THEN
            SELECT Grada.precioInfantil INTO precio_reserva FROM Grada
                WHERE Grada.ID_grada = ID_gradaIN;
        END IF;
        IF(tipoUsuarioIN = "Adulto")THEN
            SELECT Grada.precioAdulto INTO precio_reserva FROM Grada
                WHERE Grada.ID_grada = ID_gradaIN;
        END IF;

        SET precio_reserva = precio_reserva * num_localidades_reservaIN;

        -- ------------------------------------------------------------------

        SET @insert_Reserva = CONCAT("INSERT INTO Reserva(DNI_cliente,estado,precio,tipoUsuario) VALUES('",DNI_clienteIN,"','Pagado','",precio_reserva,"','",tipoUsuarioIN,"');");
        PREPARE script_insert_Reserva FROM @insert_Reserva;
        EXECUTE script_insert_Reserva;

            SELECT Reserva.ID_reserva INTO var_ID_reserva FROM Reserva
                WHERE Reserva.DNI_cliente = DNI_clienteIN AND Reserva.estado = "Pagado" AND Reserva.precio = precio_reserva AND Reserva.tipoUsuario = tipoUsuarioIN;

        -- ----------------------------------------------------------------------

        label1: LOOP
        SET p1 = p1 + 1;

            SELECT Localidad.ID_localidad INTO var_ID_localidad FROM Grada
                INNER JOIN 
                    Localidad
                ON 
                    Grada.ID_grada = Localidad.ID_grada
            
            WHERE Grada.ID_grada = ID_gradaIN AND Localidad.estado = "Libre" LIMIT 1;

            -- Cambiamos el estado de esa localidad a reservado

            UPDATE Localidad SET Localidad.estado = "Reservada" WHERE Localidad.ID_localidad = var_ID_localidad;

            SET @insert_Entrada = CONCAT("INSERT INTO Entrada(ID_CelebradoEn,ID_localidad,ID_grada) VALUES(",ID_CelebradoEnIN,",",var_ID_localidad,",",ID_gradaIN,");");
            PREPARE script_insert_Entrada FROM @insert_Entrada;
            EXECUTE script_insert_Entrada;

                SELECT Entrada.ID_entrada INTO var_ID_entrada FROM Entrada
                    WHERE Entrada.ID_localidad = var_ID_localidad AND Entrada.ID_grada = ID_gradaIN AND Entrada.ID_CelebradoEn = ID_CelebradoEnIN;

            SET @insert_ReservaEntrada = CONCAT("INSERT INTO ReservaEntrada(ID_entrada,ID_reserva) VALUES(",var_ID_entrada,",",var_ID_reserva,");");
            PREPARE script_insert_ReservaEntrada FROM @insert_reservaEntrada;
            EXECUTE script_insert_ReservaEntrada;

            -- *************************************************

        IF p1 < num_localidades_reservaIN THEN
        ITERATE label1;
        END IF;
        LEAVE label1;
        END LOOP label1;

    END IF;

END //


DROP PROCEDURE IF EXISTS anulacion//

CREATE PROCEDURE anulacion(
    IN ID_reservaIN INT
)

BEGIN

    DECLARE fin INT DEFAULT 0;
    DECLARE ID_localidad_aux INT;
    DECLARE ID_entrada_aux INT;
    DECLARE var_fecha_inicio TIMESTAMP;

    DECLARE t3 INT DEFAULT 5;
    DECLARE diff_tiempos INT;

    DECLARE cursor_localidades CURSOR FOR
        SELECT Entrada.ID_localidad FROM Entrada
            INNER JOIN 
                ReservaEntrada
            ON 
                 ReservaEntrada.ID_Entrada = Entrada.ID_Entrada
            INNER JOIN 
                Reserva
            ON
                Reserva.ID_reserva = ReservaEntrada.ID_reserva

        WHERE Reserva.ID_reserva = ID_reservaIN;

    DECLARE cursor_entradas CURSOR FOR
        SELECT Entrada.ID_entrada FROM Entrada
            INNER JOIN 
                ReservaEntrada
            ON 
                 ReservaEntrada.ID_Entrada = Entrada.ID_Entrada
            INNER JOIN 
                Reserva
            ON
                Reserva.ID_reserva = ReservaEntrada.ID_reserva

        WHERE Reserva.ID_reserva = ID_reservaIN;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    SELECT CelebradoEn.fecha_inicio INTO var_fecha_inicio FROM Reserva
            INNER JOIN 
                ReservaEntrada
            ON
                ReservaEntrada.ID_reserva = Reserva.ID_reserva
            INNER JOIN
                Entrada
            ON 
                Entrada.ID_entrada = ReservaEntrada.ID_entrada
            INNER JOIN 
                CelebradoEn
            ON
                Entrada.ID_CelebradoEn = CelebradoEn.ID_CelebradoEn
    WHERE Reserva.ID_reserva = ID_reservaIN LIMIT 1;

    SET diff_tiempos = TIMESTAMPDIFF(MINUTE,NOW(),var_fecha_inicio);

    IF (diff_tiempos < t3) THEN
        CALL raise(1356,"No puedes anular esta pre-reserva/reserva, se va a aplicara una penalizacion.");
    END IF;

    IF ((SELECT EXISTS(SELECT * FROM Reserva WHERE Reserva.ID_reserva = ID_reservaIN)) = '') THEN
        CALL raise(1356,"No existe una reserva/pre-reserva con ese ID.");
    END IF;

    IF((SELECT Reserva.estado FROM Reserva WHERE Reserva.ID_reserva = ID_reservaIN) = "Pre-Reservado" OR (SELECT Reserva.estado FROM Reserva WHERE Reserva.ID_reserva = ID_reservaIN) = "Reservado") THEN

        -- Liberamos las localidades asignadas a las entradas

        SET fin = 0;

        OPEN cursor_localidades;
        BEGIN
            bucle_localidades : LOOP 
            FETCH cursor_localidades INTO ID_localidad_aux;
            IF(fin = 1)THEN 
                LEAVE bucle_localidades;
            ELSE
                SET @update_value = CONCAT("UPDATE Localidad SET estado='Libre' WHERE Localidad.ID_localidad=",ID_localidad_aux,";");
                PREPARE script_update FROM @update_value;
                EXECUTE script_update;
            END IF;
            END LOOP bucle_localidades;
        END;
        CLOSE cursor_localidades;

        -- Eliminamos las entradas y las pre-reservas

        -- DELETE FROM Entrada WHERE Entrada.ID_Reserva = ID_reservaIN;

        SET fin = 0;

        OPEN cursor_entradas;
        BEGIN
            bucle_entradas : LOOP 
            FETCH cursor_entradas INTO ID_entrada_aux;
            IF(fin = 1)THEN 
                LEAVE bucle_entradas;
            ELSE
                SET @update_Delete = CONCAT("DELETE FROM Entrada WHERE Entrada.ID_entrada=",ID_entrada_aux,";");
                PREPARE script_Delete FROM @update_Delete;
                EXECUTE script_Delete;
            END IF;
            END LOOP bucle_entradas;
        END;
        CLOSE cursor_entradas;

        DELETE FROM Reserva WHERE Reserva.ID_Reserva = ID_reservaIN;

    END IF;


END //

DROP PROCEDURE IF EXISTS raise //

CREATE PROCEDURE raise(errno BIGINT UNSIGNED, message VARCHAR(256))
BEGIN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = message,
    MYSQL_ERRNO = errno;

END //


DELIMITER ;

