use practicas;
\. diseno.sql
\. datosbase.sql
\. events.sql
\. procedures.sql

SELECT Localidad.ID_localidad, Localidad.num_asiento, Localidad.estado AS estadoLocalidad, Grada.ID_grada, Grada.nombre AS NombreGrada, Recinto.nombre AS NombreRecinto, Espectaculo.nombre AS NombreEspectaculo, CelebradoEn.estado AS EstadoEvento FROM Localidad LEFT JOIN Grada ON Localidad.ID_grada = Grada.ID_grada LEFT JOIN Recinto ON Grada.ID_recinto = Recinto.ID_recinto  LEFT JOIN CelebradoEn ON Recinto.ID_recinto = CelebradoEn.ID_recinto LEFT JOIN Espectaculo ON CelebradoEn.ID_espectaculo = Espectaculo.ID_espectaculo ORDER BY Localidad.ID_localidad;
