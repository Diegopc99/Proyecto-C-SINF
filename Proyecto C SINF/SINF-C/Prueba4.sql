
CALL anulacion(2);

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
