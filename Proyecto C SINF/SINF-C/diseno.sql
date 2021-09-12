DROP TABLE IF EXISTS ReservaEntrada;
DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Entrada;
DROP TABLE IF EXISTS Localidad;
DROP TABLE IF EXISTS CelebradoEn;
DROP TABLE IF EXISTS Espectaculo;
DROP TABLE IF EXISTS Grada;
DROP TABLE IF EXISTS Recinto;
DROP TABLE IF EXISTS Cliente;


CREATE TABLE Espectaculo(
    ID_espectaculo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    fecha_produccion TIMESTAMP NOT NULL,
    productora VARCHAR(20) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100),
    num_participantes INT NOT NULL,
    PRIMARY KEY(ID_espectaculo)
);

CREATE TABLE Recinto(
    ID_recinto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(20),
    tipo VARCHAR(30),
    aforo_max INT NOT NULL,
    PRIMARY KEY (ID_recinto)
);

CREATE TABLE CelebradoEn(
    ID_CelebradoEn INT NOT NULL AUTO_INCREMENT,
    ID_espectaculo INT NOT NULL,
    ID_recinto INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP DEFAULT NOW(),
    estado VARCHAR(20),
    entradasBebe BOOLEAN,
    entradasInfantil BOOLEAN,
    entradasParado BOOLEAN,
    entradasJubilado BOOLEAN,
    t1 INT NOT NULL DEFAULT 0,
    PRIMARY KEY(ID_CelebradoEn),
    FOREIGN KEY (ID_espectaculo) REFERENCES Espectaculo(ID_espectaculo),
    FOREIGN KEY (ID_recinto) REFERENCES Recinto(ID_recinto),
    CHECK (fecha_inicio < fecha_fin)
);

CREATE TABLE Grada(
    ID_grada INT NOT NULL AUTO_INCREMENT,
    ID_recinto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    localidades_max INT NOT NULL,
    localidades_max_compra INT,
    precioJubilado DECIMAL(5,2),
    precioAdulto DECIMAL(5,2),
    precioInfantil DECIMAL(5,2),
    precioParado DECIMAL(5,2),
    precioBebe DECIMAL(5,2),
    PRIMARY KEY (ID_grada),
    FOREIGN KEY (ID_recinto) REFERENCES Recinto(ID_recinto),
    CHECK (localidades_max_compra <= localidades_max)
);

CREATE TABLE Localidad(
    ID_localidad INT NOT NULL AUTO_INCREMENT,
    ID_grada INT NOT NULL,
    num_asiento VARCHAR(4) NOT NULL,
    estado VARCHAR(20) DEFAULT "Libre",
    PRIMARY KEY (ID_localidad, num_asiento),
    FOREIGN KEY (ID_grada) REFERENCES Grada(ID_grada)
);

CREATE TABLE Cliente(
    DNI CHAR(9) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    IBAN VARCHAR(34) NOT NULL,
    PRIMARY KEY (DNI)
);

CREATE TABLE Entrada(
    ID_entrada INT NOT NULL AUTO_INCREMENT,
    ID_CelebradoEn INT NOT NULL,
    ID_localidad INT NOT NULL,
    ID_grada INT NOT NULL, -- puede que sobre, implícito en ID_localidad, estamos dando la posibilidad de que haya inconsistencias
    PRIMARY KEY (ID_entrada),
    FOREIGN KEY (ID_CelebradoEn) REFERENCES CelebradoEn(ID_CelebradoEn),
    FOREIGN KEY (ID_localidad) REFERENCES Localidad(ID_localidad),
    FOREIGN KEY (ID_grada) REFERENCES Grada(ID_grada)
  
);

CREATE TABLE Reserva(
    ID_reserva INT NOT NULL AUTO_INCREMENT,
    DNI_cliente CHAR(9) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    instante TIMESTAMP DEFAULT NOW(),
    precio DECIMAL(5,2) NOT NULL,
    tipoUsuario VARCHAR(15) NOT NULL,
    PRIMARY KEY (ID_reserva),
    FOREIGN KEY (DNI_cliente) REFERENCES Cliente(DNI)
);

CREATE TABLE ReservaEntrada(
    ID_entrada INT,
    ID_reserva INT,
    PRIMARY KEY (ID_entrada),
    FOREIGN KEY (ID_reserva) REFERENCES Reserva(ID_reserva) ON DELETE CASCADE,
    FOREIGN KEY (ID_entrada) REFERENCES Entrada(ID_Entrada) ON DELETE CASCADE
);



-- ON DELETE CASCADE para que se eliminen tmb las relaciones dependientes por una FK
