# Proyecto C SINF

Entramos en MySQL:

> sudo mysql -u usuarioROOT -p

> Password: SINFmolamogollon1! 

Cargamos los ficheros: \\. load.sql

## CONSULTAS COMUNES ##

Listar TODOS los Espectáculos con su estado y junto a sus Recintos:

> SELECT Espectaculo.ID_espectaculo, Espectaculo.nombre, Espectaculo.tipo, Recinto.ID_recinto, Recinto.nombre, CelebradoEn.estado, CelebradoEn.fecha_inicio, CelebradoEn.fecha_fin FROM Espectaculo LEFT JOIN CelebradoEn ON Espectaculo.ID_espectaculo = CelebradoEn.ID_espectaculo LEFT JOIN Recinto ON CelebradoEn.ID_recinto = Recinto.ID_recinto;

Listar TODAS las Localidades con sus Gradas con su Recinto, de cada Espectaculo QUE TENGA un Recinto asignado:

> SELECT Localidad.ID_localidad, Localidad.num_asiento, Localidad.estado AS estadoLocalidad, Grada.ID_grada, Grada.nombre AS NombreGrada, Recinto.nombre AS NombreRecinto, Espectaculo.nombre AS NombreEspectaculo, CelebradoEn.estado AS EstadoEvento FROM Localidad LEFT JOIN Grada ON Localidad.ID_grada = Grada.ID_grada LEFT JOIN Recinto ON Grada.ID_recinto = Recinto.ID_recinto  LEFT JOIN CelebradoEn ON Recinto.ID_recinto = CelebradoEn.ID_recinto LEFT JOIN Espectaculo ON CelebradoEn.ID_espectaculo = Espectaculo.ID_espectaculo ORDER BY Localidad.ID_localidad;

Listar TODAS las Entradas con sus Reservas:

> SELECT * FROM Entrada JOIN Reserva ON Entrada.ID_entrada = Reserva.ID_entrada;

### TIEMPOS ###

t1: 

t2: No se podrá hacer una prerreserva si faltan menos de t2 minutos para que comience el espectáculo: 1h

t3: 

#### UPDATE 8 mayo ####

Tal y como están ahora los datos, el espetáculo del Celta se va a CERRAR porque se agotan las entradas para una de sus gradas Esto está mal, debería ser cuando se agoten todas las de sus gradas.