-- Comprobación: \. load.sql  && \. Prueba.sql

-- Creamos los eventos pertinentes en la relacion CelebradoEn:
CALL CrearEventos (7,5,'2022-05-13 10:00:00','2022-05-13 11:10:00',true,true,true,true, 1); 
CALL CrearEventos (8,8,'2021-05-12 21:50:00','2021-05-12 23:00:00',true,true,true,true, 10); -- cambiar fecha_inicio (NOW + 5 min) // fecha_fin (NOW + 7 min)
CALL CrearEventos (9,9,'2021-05-12 21:52:00','2021-05-13 23:10:00',true,true,true,true, 60);

-- Listamos:
CALL listarEventos();

-- Creamos las prerreservas(num_localidades, ID_CelebradoEN, ID_grada, DNI, tipoUsuario):
CALL crearPreReserva(1, 1, 12, "12345678A", "Infantil");
CALL crearPreReserva(2, 2, 13, "12345678A", "Jubilado");
CALL crearPreReserva(3, 3, 14, "12345678A", "Parado");

-- Para ver los estados de los eventos: 
-- SELECT Espectaculo.nombre, CelebradoEn.estado, CelebradoEn.fecha_inicio FROM Espectaculo INNER JOIN CelebradoEn ON Espectaculo.ID_espectaculo = CelebradoEn.ID_espectaculo;

-- Para anular la última prerreserva:
-- CALL anulacion(3);

-- Qué hay que comprobar en esta prueba:
-- 1) Que se anule correctamente una prerreserva tras expirar t1 minutos tras su creación (depende del evento)
-- 2) Que se cambie el estado de un evento a 'Cerrado' si queda menos de 5 min (t2) para que comience
-- 3) Que se muestre por pantalla la penalizacion cuando se quiera anular una prerreserva si quedan menos de 10 min (t3) para que empiece el evento

-- Cómo lo probamos?:
-- 1) Creamos un evento dentro de mucho con muy poca duración para las prerreservas y creamos una prerreserva para ese y ver cómo expira
-- 2) Creamos un evento (libre) para que empiece dentro de siete minutos y que dure una hora (cambia a cerrado) y luego a finalizado
-- 3) Creamos un evento (t1 = 60) que empiece dentro de +10 minutos, efectuamos una reserva antes de diez, y llamamos a anulacion() cuando quedan menos de diez y ANTES QUE CINCO (t2)

-- RESULTADOS:
-- 1) La reserva para el primer evento tiene que desaparecer muy pronto
-- 2) El segundo evento deberá cambiar pronto a estado 'Cerrado' (a falta de 5 min)
-- 3) Cuando anulemos la tercera entrada (a), deberá salir el mensaje de penalización