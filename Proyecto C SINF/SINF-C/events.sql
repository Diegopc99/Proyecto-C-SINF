drop event IF EXISTS EstadoEspectaculo;

delimiter //

-- Evento que a cada poco calcula si han pasado 24h entre el momento actual y la fecha de inicio del espectáculo
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

        if(TIMESTAMPDIFF(HOUR, current_timestamp(), my_fecha_ini) < 1) then update CelebradoEn set estado="Cerrado(empieza)" where ID_espectaculo=my_id_espectaculo and ID_recinto=my_id_recinto and fecha_inicio=my_fecha_ini and fecha_fin=my_fecha_fin;
        end if;

        if(current_timestamp() > my_fecha_fin) then update CelebradoEn set estado="Finalizado" where ID_espectaculo=my_id_espectaculo and ID_recinto=my_id_recinto and fecha_inicio=my_fecha_ini and fecha_fin=my_fecha_fin;
        end if;

    END LOOP;
close cursorEvento;
end//


delimiter ;
