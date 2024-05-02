/* Crear base de datos dbGamarraMarket */
DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket
DEFAULT CHARACTER SET utf8;

/* Poner en uso la base de datos dbGamarraMarket */
USE dbGamarraMarket;

/* Eliminar base de datos dbGamarraMarket */
DROP DATABASE dbGamarraMarket;


/* Crear la tabla CLIENTE */
CREATE TABLE CLIENTE
(
    id int,
    tipo_documento char(3),
    numero_documento char(9),
    nombres varchar(60),
    apellidos varchar(90),
    email varchar(80),
    celular char(9),
    fecha_nacimiento date,
    activo bool,
    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

-- Table: PRENDA
CREATE TABLE PRENDA (
    id int NOT NULL,
    descripcion varchar(250) NOT NULL,
    marca varchar(60) NOT NULL,
    cantida int NOT NULL,
    talla char(10) NOT NULL,
    prcio decimal(8,2) NOT NULL,
    activo bool NOT NULL,
    CONSTRAINT PRENDA_pk PRIMARY KEY (id)
);

-- Table: VENDEDOR
CREATE TABLE VENDEDOR (
    ID int NOT NULL,
    Tipo_documento char(3) NOT NULL,
    numero_documento char(15) NOT NULL,
    nombres varchar(60) NOT NULL,
    apellido varchar(90) NOT NULL,
    salario decimal(8,2) NOT NULL,
    celular char(9) NULL,
    email varchar(80) NULL,
    activo bool NOT NULL,
    CONSTRAINT VENDEDOR_pk PRIMARY KEY (ID)
);

-- Table: VENTA
CREATE TABLE VENTA (
    id int NOT NULL,
    fecha_hora timestamp NOT NULL,
    activo bool NOT NULL,
    cliente_id int NOT NULL,
    vendedor_id int NOT NULL,
    CONSTRAINT VENTA_pk PRIMARY KEY (id)
);



-- Table: VENTA_DETALLE
CREATE TABLE VENTA_DETALLE (
    Id int NOT NULL,
    cantidad int NOT NULL,
    venta_id int NOT NULL,
    prenda_id int NOT NULL,
    CONSTRAINT VENTA_DETALLE_pk PRIMARY KEY (Id)
);


/* Listar estructura de tabla CLIENTE */
SHOW TABLES;

/* Crear relación VENTA_CLIENTE */
ALTER TABLE VENTA
	ADD CONSTRAINT VENTA_CLIENTE FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;

/* Crear relación VENTA_VENDEDOR */
ALTER TABLE VENTA
	ADD CONSTRAINT VENTA_VENDEDOR FOREIGN KEY (vendedor_id)
    REFERENCES VENDEDOR (ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;

/* Crear relación VENTA_DETALLE_VENDEDOR */
ALTER TABLE VENTA_DETALLE
	ADD CONSTRAINT VENTA_DETALLE_VENTA FOREIGN KEY (venta_id)
    REFERENCES VENTA (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;

/* Crear relación VENTA_DETALLE_VENDEDOR */
ALTER TABLE VENTA_DETALLE
	ADD CONSTRAINT VENTA_DETALLE_PRENDA FOREIGN KEY (prenda_id)
    REFERENCES PRENDA (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;


/* Listar relaciones de tablas de la base de datos activa */
SELECT 
    i.constraint_name, k.table_name, k.column_name, 
    k.referenced_table_name, k.referenced_column_name
FROM 
    information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k 
ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA = DATABASE();