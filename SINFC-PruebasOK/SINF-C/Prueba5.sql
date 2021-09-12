-- Pagamos la pre-reserva con id 3 asi pasa a estar reservado
CALL confirmarPagos(3,"ES6621000418401234567891",null,null,null,null,null);
CALL confirmarPagos();

-- Comprobacion de errores

CALL confirmarPagos(3,"ES6621000418402367867891",null,null,null,null,null); -- Da error porque no existe un cliente con ese IBAN

-- ---------------------------------------

SELECT * FROM Reserva;
 
