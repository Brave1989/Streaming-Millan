create database streaming_db;
USE streaming_db;

-- Tabla: Usuario
CREATE TABLE USUARIO (
    ID_usuario INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    numero_de_telefono VARCHAR(15) NOT NULL,
    fecha_registro DATE,
    tipo_de_suscripcion VARCHAR(20),
    CONSTRAINT PK_USUARIO PRIMARY KEY (ID_usuario)
);

-- Tabla: Servicio de Streaming
CREATE TABLE SERVICIO_DE_STREAMING (
    ID_servicio INT AUTO_INCREMENT,
    nombre_del_servicio VARCHAR(40) NOT NULL,
    tipo_de_servicio VARCHAR(40) NOT NULL,
    cantidad_de_pantallas_disponibles INT,
    CONSTRAINT PK_SERVICIO_DE_STREAMING PRIMARY KEY (ID_servicio)
);

-- Tabla: Suscripción
CREATE TABLE SUSCRIPCION (
    ID_suscripcion INT AUTO_INCREMENT,
    ID_servicio INT, -- Foreign Key que se relaciona con la tabla Servicio de Streaming
    fecha_inicio DATE,
    fecha_fin DATE,
    correo_suscripcion VARCHAR(100) NOT NULL,
    contrasena_suscripcion VARCHAR(100) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    CONSTRAINT PK_SUSCRIPCION PRIMARY KEY (ID_suscripcion)
);

-- Tabla: Usuario_Suscripción
CREATE TABLE USUARIO_SUSCRIPCION (
    ID_usuario INT,  -- Foreign Key que se relaciona con la tabla Usuario
    ID_suscripcion INT,  -- Foreign Key que se relaciona con la tabla Suscripcion
    CONSTRAINT PK_USUARIO_SUSCRIPCION PRIMARY KEY (ID_usuario, ID_suscripcion)  -- Primary Key compuesta
);

-- Tabla: Pantalla
CREATE TABLE PANTALLA (
    ID_pantalla INT AUTO_INCREMENT,
    ID_suscripcion INT,  -- Foreign Key que se relaciona con la tabla Suscripcion
    numero_de_pantallas INT,
    importe_por_pantalla DECIMAL(10,2),
    CONSTRAINT PK_PANTALLA PRIMARY KEY (ID_pantalla)
);

-- Tabla: Perfil
CREATE TABLE PERFIL (
    ID_perfil INT AUTO_INCREMENT,
    ID_usuario INT,  -- Foreign Key que se relaciona con la tabla Usuario
    ID_pantalla INT,  -- Foreign Key que se relaciona con la tabla Pantalla
    nombre_del_perfil VARCHAR(30),
    pin CHAR(4) NOT NULL, 
    CONSTRAINT PK_PERFIL PRIMARY KEY (ID_perfil)
);

-- Tabla: Pago
CREATE TABLE PAGO (
    ID_pago INT AUTO_INCREMENT,
    ID_pantalla INT,  -- Foreign Key que se relaciona con la tabla Pantalla
    fecha_de_pago DATE NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    metodo_de_pago VARCHAR(30) NOT NULL,
    CONSTRAINT PK_PAGO PRIMARY KEY (ID_pago)
);

-- Tabla: Inversión
CREATE TABLE INVERSION (
    ID_inversion INT AUTO_INCREMENT,
    ID_servicio INT,  -- Foreign Key que se relaciona con la tabla Servicio de Streaming
    importe DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    metodo_de_pago VARCHAR(30) NOT NULL,
    CONSTRAINT PK_INVERSION PRIMARY KEY (ID_inversion)
);

-- foreign keys

-- Reference:  FK_SUSCRIPCION_SERVICIO_DE_STREAMING (tabla: SUSCRIPCION)
ALTER TABLE SUSCRIPCION 
ADD CONSTRAINT FK_SUSCRIPCION_SERVICIO_DE_STREAMING 
FOREIGN KEY (ID_servicio)
REFERENCES SERVICIO_DE_STREAMING (ID_servicio);

-- Reference:  FK_USUARIO_SUSCRIPCION  (tabla: USUARIO_SUSCRIPCION)
ALTER TABLE USUARIO_SUSCRIPCION 
ADD CONSTRAINT FK_USUARIO_SUSCRIPCION FOREIGN KEY (ID_suscripcion)
REFERENCES SUSCRIPCION (ID_suscripcion);

-- Reference:  FK_USUARIO_SUSCRIPCION_USUARIO (tabla: USUARIO_SUSCRIPCION)
ALTER TABLE USUARIO_SUSCRIPCION 
ADD CONSTRAINT FK_USUARIO_SUSCRIPCION_USUARIO FOREIGN KEY (ID_usuario)
REFERENCES USUARIO (ID_usuario);

-- Reference:  FK_PANTALLA_SUSCRIPCION  (tabla: PANTALLA)
ALTER TABLE PANTALLA 
ADD CONSTRAINT FK_PANTALLA_SUSCRIPCION FOREIGN KEY (ID_suscripcion)
REFERENCES SUSCRIPCION (ID_suscripcion);

-- Reference:  FK_Perfil_Usuario  (tabla: PERFIL)
ALTER TABLE PERFIL 
ADD CONSTRAINT FK_PERFIL_USUARIO FOREIGN KEY (ID_usuario)
REFERENCES USUARIO (ID_usuario);

-- Reference:  FK_Perfil_Pantalla (tabla: PERFIL)
ALTER TABLE PERFIL 
ADD CONSTRAINT FK_PERFIL_PANTALLA FOREIGN KEY (ID_pantalla)
REFERENCES PANTALLA (ID_pantalla);

-- Reference:  FK_Pago_Pantalla  (tabla: PAGO)
ALTER TABLE PAGO 
ADD CONSTRAINT FK_PAGO_PANTALLA FOREIGN KEY (ID_pantalla)
REFERENCES PANTALLA (ID_pantalla);

-- Reference:  FK_Inversion_Servicio  (tabla: INVERSION)
ALTER TABLE INVERSION 
ADD CONSTRAINT FK_INVERSION_SERVICIO FOREIGN KEY (ID_servicio)
REFERENCES SERVICIO_DE_STREAMING (ID_servicio);