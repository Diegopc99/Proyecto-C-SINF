INSERT INTO Espectaculo(ID_espectaculo, nombre, fecha_produccion, productora, tipo, descripcion, num_participantes) VALUES
(1, "Concierto de los Rolling", "2021-05-06 00:00:00", "Gira por España", "Musical", "Descripcion", 5),
(2, "Concierto de los Jonas Brothers", "2019-11-06 00:00:00", "Gira por EEUU", "Musical", "Descripcion", 3),
(3, "Musical el Rey León", "2020-07-03 00:00:00", "Disney", "Musical", "Descripcion", 20),
(4, "Partido de Liga: Celta vs Eibar", "2021-05-11 19:00:00", "LaLiga", "Deportivo", "Descripcion", 22),
(5, "Espectaculo de prueba", "2021-05-11 19:00:00", "Productora de prueba", "Prueba", "Descripcion", 10);


INSERT INTO Recinto(ID_recinto, nombre, ubicacion, tipo, aforo_max) VALUES
(1, "Dignity Health Sports Park", "EEUU - Carson", "Parque", 2500),
(2, "Plaza DisneyLand", "Francia - París", "Parque temático", 100000),
(3, "Balaídos", "España - Vigo", "Estadio de fútbol", 29000);


INSERT INTO CelebradoEn(ID_espectaculo, ID_recinto, fecha_inicio, fecha_fin, estado, entradasBebe, entradasInfantil, entradasParado, entradasJubilado) VALUES
(1, 1, "2021-05-01 00:00:00", "2021-05-03 23:59:59", "Abierto", FALSE, FALSE, TRUE, TRUE),
(2, 1, "2021-04-22 00:00:00", "2021-04-23 23:59:59", "Abierto", TRUE, TRUE, TRUE, TRUE),
(3, 2, "2021-05-09 16:30:00", "2021-05-09 23:59:59", "Abierto", TRUE, TRUE, TRUE, TRUE),
(4, 3, "2022-05-23 00:00:00", "2022-05-25 23:59:59", "Abierto", FALSE, TRUE, TRUE, TRUE);

-- Todas estas gradas son de Balaidos
INSERT INTO Grada(ID_grada, ID_recinto, nombre, localidades_max, localidades_max_compra, precioJubilado, precioAdulto, precioInfantil, precioParado, precioBebe) VALUES
(1, 3, "Primera Línea", 20, 15, 3.18, 4.19, 1.89, 23.90, 100.00),
(2, 3, "Palco", 120, 5, 20.00, 20.00, 25.00, 31.00, 120.00),
(3, 3, "Tribuna", 45, 6, 50.00, 51.00, 52.00, 53.00, 54.00);


INSERT INTO Localidad(ID_localidad, ID_grada, num_asiento, estado) VALUES
(20, 1, "7A", "Libre"),
(21, 1, "7B", "Deteriorado"),
(22, 2, "222", "Reservado"),
(23, 3, "1AA", "Libre"),
(30, 3, "2AB", "Libre");

INSERT INTO Cliente(DNI, nombre, IBAN) VALUES
("12345678A", "Perico de los Palotes", "ES6621000418401234567891"),
("22345678A", "Juan Espinosa de la Rosa", "ES6621000418401235567891"),
("12345777G", "El Cigala", "ES6629000418401234567891"),
("17777777R", "Miley Cyrus", "ES1129000418401234567891");

