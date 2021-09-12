INSERT INTO Espectaculo(ID_espectaculo, nombre, fecha_produccion, productora, tipo, descripcion, num_participantes) VALUES
(1, "Concierto de los Rolling", "2021-05-06 00:00:00", "Gira por España", "Musical", "Descripcion", 5),
(2, "Concierto de los Jonas Brothers", "2019-11-06 00:00:00", "Gira por EEUU", "Musical", "Descripcion", 3),
(3, "Musical el Rey León", "2020-07-03 00:00:00", "Disney", "Musical", "Descripcion", 20),
(4, "Partido de Liga: Celta vs Eibar", "2021-05-11 19:00:00", "LaLiga", "Deportivo", "Descripcion", 22),
(5, "Espectaculo de prueba", "2021-05-11 19:00:00", "Productora de prueba", "Prueba", "Descripcion", 10),
(6, "Camiones monstruo", "2021-11-21 19:00:00", "Endesa", "Deportivo", "Explosiones", 8),
(7, "Copa Pistón", "2030-08-30 09:00:00", "Disney", "Deportivo", "Kchooooow", 32),
(8, "Battle royale", "2022-10-01 14:00:00", "JaggerMania", "Entretenimiento", "Descripcion", 100),
(9, "Pesca de chocos deportiva", "2021-03-13 15:00:00", "YamaPesca", "Deportivo", "Chocos", 25),
(10, "Paintball", "2021-01-03 17:00:00", "UVigo", "Deportivo", "Descripcion", 20),
(11, "Curso de electrónica", "2025-11-23 19:00:00", "Dept electrónica", "Educativo", "Descripcion", 40),
(12, "Curso de sonido", "2022-07-03 18:00:00", "Depto de sonido", "Educativo", "Descripcion", 40),
(13, "Curso de telematica", "2020-07-03 18:00:00", "Dept de telemática", "Educativo", "Descripcion", 40),
(14, "La vida de Bryan: remastered", "2020-07-03 17:30:00", "Monty Python", "Comedia", "Descripcion", 42),
(15, "Loca academia de policia", "2020-07-03 20:30:00", "Warner Bros", "Comedia", "Descripcion", 42);


INSERT INTO Recinto(ID_recinto, nombre, ubicacion, tipo, aforo_max) VALUES
(1, "Dignity Health Sports Park", "EEUU - Carson", "Parque", 2500),
(2, "Plaza DisneyLand", "Francia - París", "Parque temático", 100000),
(3, "Balaídos", "España - Vigo", "Estadio de fútbol", 29000),
(4, "Verdansk", "Ucrania - Verdansk", "Estadio olímpico", 250),
(5, "Radiador Springs", "EEUU - Colorado", "Desierto", 7500),
(6, "UVigo", "España - Vigo", "Recinto Universitario", 100),
(7, "Yelmo Cines", "España - Vigo", "Cines", 200),
(8, "Jagger Arena", "España - Valladolid", "Arena multiuso", 2500),
(9, "Isla Wu-hu", "España - Vigo", "Parque natural", 1500);





-- Todas estas gradas son de Balaidos
INSERT INTO Grada(ID_grada, ID_recinto, nombre, localidades_max, localidades_max_compra, precioJubilado, precioAdulto, precioInfantil, precioParado, precioBebe) VALUES
(1, 3, "Primera Línea", 20, 15, 3.18, 4.19, 1.89, 23.90, 100.00),
(2, 3, "Palco", 120, 5, 20.00, 20.00, 25.00, 31.00, 120.00),
(3, 3, "Tribuna", 45, 6, 50.00, 51.00, 52.00, 53.00, 54.00),
(4, 4, "Palco Alto", 50, 6, 75.00, 80.00, 72.00, 75.00, 60.00),
(5, 4, "Palco intermedio", 100, 10, 60.00, 65.00, 55.00, 63.00, 50.00),
(6, 4, "Palco bajo", 150, 10, 50.00, 55.00, 52.00, 53.00, 45.00),
(7, 9, "Gradas VIP Choco", 500, 10, 80.00, 84.00, 78.00, 78.00, 70.00),
(8, 9, "Gradas Standard Choco", 1000, 10, 60.00, 64.00, 58.00, 58.00, 50.00),
(9, 5, "Parque de caravanas", 500, 10, 80.00, 84.00, 78.00, 78.00, 70.00),    -- tocar prezos
(10, 5, "Palco Exterior", 7000, 10, 80.00, 84.00, 78.00, 78.00, 70.00),
(11, 6, "Salon de Actos de Teleco", 100, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(12, 7, "Sala A", 70, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(13, 7, "Sala B", 70, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(14, 7, "Sala C", 70, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(15, 7, "Sala D", 60, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(16, 8, "Palco Jagg (Superior)", 1250, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(17, 8, "Palco Err(Inferior)", 1250, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(18, 8, "Palco Jagg", 1200, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(19, 8, "Palco Jagg2", 1200, 10, 10.00, 14.00, 8.00, 8.00, 1.00),
(20, 2, "Grada Única (Disneyland)", 1200, 10, 20.00, 24.00, 18.00, 18.00, 11.00),
(21, 8, "Grada Única (Parque)", 1200, 10, 10.00, 14.00, 8.00, 8.00, 1.00);


INSERT INTO Localidad(ID_grada, num_asiento, estado) VALUES
(1, "7AZ", "Libre"),
(1, "7BZ", "Deteriorado"),
(2, "222", "Reservado"),
(3, "1AA", "Libre"),
(3, "2AB", "Libre"),

(4, "3AB", "Libre"),
(4, "4AB", "Libre"),
(4, "5AB", "Libre"),
(5, "6AB", "Libre"),
(5, "7AB", "Libre"),
(5, "8AB", "Libre"),
(6, "9AB", "Libre"),
(6, "SUU", "Libre"),
(6, "1BB", "Libre"),
(7, "2BB", "Libre"),
(7, "3BB", "Libre"),
(7, "4BB", "Libre"),
(8, "5BB", "Libre"),
(8, "6BB", "Libre"),
(9, "7BB", "Libre"),
(9, "8BB", "Libre"),
(10, "9BB", "Libre"),
(11, "1BC", "Libre"),
(12, "2BC", "Libre"),
(12, "3BC", "Libre"),
(13, "4BC", "Libre"),
(13, "5BC", "Libre"),
(13, "6BC", "Libre"),
(14, "7BC", "Libre"),
(14, "8BC", "Libre"),
(14, "9BC", "Libre"),
(15, "1CC", "Libre"),
(15, "2CC", "Libre"),
(16, "3CC", "Libre"),
(16, "4CC", "Libre"),
(17, "5CC", "Libre"),
(17, "6CC", "Libre"),
(18, "7CC", "Libre"),
(18, "8CC", "Libre"),
(19, "9CC", "Libre"),
(19, "1CB", "Libre"),
(20, "2CB", "Libre"),
(20, "3CB", "Libre"),
(21, "4CB", "Libre"),
(21, "5CB", "Libre");


INSERT INTO Cliente(DNI, nombre, IBAN) VALUES
("12345678A", "Perico de los Palotes", "ES6621000418401234567891"),
("22345678A", "Juan Espinosa de la Rosa", "ES6621000418401235567891"),
("12345777G", "El Cigala", "ES6629000418401234567891"),
("17777777R", "Miley Cyrus", "ES1129000418401234567891");
