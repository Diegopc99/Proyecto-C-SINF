-- Creamos varias pre-reservas con n localidades y las listamos

CALL crearPreReserva(1,6,12,"12345678A","Infantil");
CALL crearPreReserva(2,6,13,"12345678A","Jubilado");
CALL crearPreReserva(3,6,14,"12345678A","Parado");

-- Comprobacion de errores

CALL crearPreReserva(2,6,14,"12345678A","Parado"); -- Error porque no hay localidades suficientes en la grada
CALL crearPreReserva(1,6,13,"12342478X","Parado"); -- Error porque no existe un cliente con ese DNI

SELECT * FROM Reserva;

SELECT ReservaEntrada.ID_entrada,ReservaEntrada.ID_reserva,Entrada.ID_localidad,Entrada.ID_grada FROM ReservaEntrada 
    INNER JOIN 
        Entrada
    ON
        Entrada.ID_Entrada = ReservaEntrada.ID_entrada
WHERE ReservaEntrada.ID_reserva = 1;

SELECT ReservaEntrada.ID_entrada,ReservaEntrada.ID_reserva,Entrada.ID_localidad,Entrada.ID_grada FROM ReservaEntrada 
    INNER JOIN 
        Entrada
    ON
        Entrada.ID_Entrada = ReservaEntrada.ID_entrada
WHERE ReservaEntrada.ID_reserva = 2;

SELECT ReservaEntrada.ID_entrada,ReservaEntrada.ID_reserva,Entrada.ID_localidad,Entrada.ID_grada FROM ReservaEntrada 
    INNER JOIN 
        Entrada
    ON
        Entrada.ID_Entrada = ReservaEntrada.ID_entrada
WHERE ReservaEntrada.ID_reserva = 3;

CALL estadoLocalidades_grada(12,6); 
CALL estadoLocalidades_grada(13,6); 
CALL estadoLocalidades_grada(14,6); 
CALL estadoLocalidades_grada(15,6); 




