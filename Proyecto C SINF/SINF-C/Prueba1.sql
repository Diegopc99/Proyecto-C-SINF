CALL CrearEventos (7,5,'2021-11-12 14:00:00','2021-11-12 17:00:00',true,true,true,true);
CALL CrearEventos (8,8,'2021-10-03 12:00:00','2021-10-06 20:00:00',true,true,true,true);
CALL CrearEventos (9,9,'2021-08-21 10:00:00','2021-11-12 18:30:00',true,true,true,true);
CALL CrearEventos (10,6,'2021-06-12 18:00:00','2021-06-12 21:00:00',true,true,true,true);
CALL CrearEventos (11,6,'2021-07-07 11:00:00','2021-07-07 12:00:00',true,true,true,true);
CALL CrearEventos (14,7,'2021-11-11 15:00:00','2021-11-11 16:30:00',true,true,true,true);
CALL CrearEventos (10,4,'2021-12-16 09:00:00','2021-12-16 21:00:00',true,true,true,true);
CALL CrearEventos (6,8,'2022-02-1 17:00:00','2022-02-01 19:30:00',false,false,true,false);
CALL CrearEventos (15,7,'2021-05-30 17:30:00','2021-11-12 18:45:00',true,true,true,true);
CALL CrearEventos (14,7,'2021-11-11 17:00:00','2021-11-11 18:30:00',true,true,true,true);

-- Fecha mal (Antes fin que inicio) espectaculo mal recinto mal

CALL CrearEventos (12,6,'2021-01-11 15:00:00','2021-11-11 16:30:00',true,true,true,true); -- fecha mal (xanerio deste ano)
CALL CrearEventos (17,7,'2021-11-11 15:00:00','2021-11-11 16:30:00',true,true,true,true); -- Non existe ese espectaculo
CALL CrearEventos (14,77,'2021-11-11 15:00:00','2021-11-11 16:30:00',true,true,true,true); -- NOn existe o recinto
CALL CrearEventos (8,8,'2021-10-05 12:00:00','2021-10-08 20:00:00',true,true,true,true); -- Cadra no medio doutro JaggerRoyale

-- *****************

    CALL listarEventos();
-- SELECT * FROM CelebradoEn;
