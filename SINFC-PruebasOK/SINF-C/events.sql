SET GLOBAL event_scheduler = ON;
SET @@global.event_scheduler = ON;
SET GLOBAL event_scheduler = 1;
SET @@global.event_scheduler = 1;

drop event IF EXISTS EstadoEspectaculo;
drop event IF EXISTS EventoCaducarPrerreserva;

delimiter //

-- Evento que a cada poco calcula si han pasado 5min entre el momento actual y la fecha de inicio del espectáculo
-- Si se cumple la condición, el estado es "Cerrado"
-- Si la fecha de inicio ha pasado del momento actual, el estado será "finalizado"

create event EstadoEspectaculo
on schedule EVERY 1 MINUTE STARTS current_timestamp()
do
begin

declare my_id_espectaculo INT;
declare my_id_recinto INT;
declare my_fecha_ini datetime;
declare my_fecha_fin datetime;
DECLARE fin INT DEFAULT FALSE;
DECLARE cursorEvento CURSOR FOR SELECT ID_espectaculo, ID_recinto, fecha_inicio, fecha_fin FROM CelebradoEn;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN cursorEvento;
    read_loop: LOOP

        FETCH cursorEvento INTO my_id_espectaculo, my_id_recinto, my_fecha_ini, my_fecha_fin;

        IF fin THEN
            LEAVE read_loop;
        END IF;

        if(TIMESTAMPDIFF(MINUTE, current_timestamp(), my_fecha_ini) < 5) then update CelebradoEn set estado="Cerrado" where ID_espectaculo=my_id_espectaculo and ID_recinto=my_id_recinto and fecha_inicio=my_fecha_ini and fecha_fin=my_fecha_fin;
        end if;

        if(current_timestamp() > my_fecha_fin) then update CelebradoEn set estado="Finalizado" where ID_espectaculo=my_id_espectaculo and ID_recinto=my_id_recinto and fecha_inicio=my_fecha_ini and fecha_fin=my_fecha_fin;
        end if;

    END LOOP;
close cursorEvento;

end//


DELIMITER //

CREATE EVENT EventoCaducarPrerreserva
on schedule EVERY 1 MINUTE STARTS current_timestamp()
DO
BEGIN
DECLARE my_ID_reserva INT;
DECLARE my_ID_entrada INT;
DECLARE my_ID_CelebradoEn INT;
DECLARE my_instante TIMESTAMP;
DECLARE diferenciaTiempo INT;
DECLARE fin2 INT DEFAULT FALSE;
DECLARE my_t1 INT;
DECLARE CursorReservas CURSOR FOR SELECT ID_reserva, instante FROM Reserva WHERE Reserva.estado='Pre-Reservado';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin2 = TRUE;

OPEN CursorReservas;
    read_loop2: LOOP

        FETCH CursorReservas INTO my_ID_reserva, my_instante;

        SELECT Entrada.ID_CelebradoEn INTO my_ID_CelebradoEn FROM Reserva INNER JOIN ReservaEntrada ON Reserva.ID_reserva = ReservaEntrada.ID_reserva INNER JOIN Entrada ON ReservaEntrada.ID_entrada = Entrada.ID_entrada WHERE Reserva.ID_reserva=my_ID_reserva LIMIT 1;

        SELECT t1 INTO my_t1 FROM CelebradoEn WHERE ID_CelebradoEn = my_ID_CelebradoEn;

        IF fin2 THEN
            LEAVE read_loop2;
        END IF;

        SET diferenciaTiempo = TIMESTAMPDIFF(MINUTE, my_instante, CURRENT_TIMESTAMP());
        
        IF(my_t1 < diferenciaTiempo) THEN

            CALL anulacion(my_ID_reserva);

        END IF;

    END LOOP;
CLOSE CursorReservas;
end//

delimiter ;
