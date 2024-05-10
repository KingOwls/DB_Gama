CREATE TABLE `gama_producto` (
  `id_gama_producto` VARCHAR(50) NOT NULL,
  `descripcion` TEXT NULL,
  `descripcion_html` TEXT NULL,
  `imagen` VARCHAR(256) NULL,
  PRIMARY KEY (`id_gama_producto`))
ENGINE = InnoDB;

CREATE TABLE `producto` (
  `codigo_producto` VARCHAR(255) NOT NULL,
  `nombre_producto` VARCHAR(255) NULL,
  `descripcion` TEXT NULL,
  `cantidad_existente` SMALLINT NULL,
  `precio_venta` DECIMAL(15, 2) NULL,
  `gama` VARCHAR(50) NOT NULL,
  `altura` SMALLINT NULL,
  `ancho` SMALLINT NULL,
  `longitud` SMALLINT NULL,
  `peso` SMALLINT NULL,
  PRIMARY KEY (`codigo_producto`),
  INDEX `fk_producto_gama_producto_idx` (`gama`),
  UNIQUE INDEX `codigo_producto_UNICO` (`codigo_producto`),
  CONSTRAINT `fk_producto_gama_producto`
    FOREIGN KEY (`gama`)
    REFERENCES `gama_producto` (`id_gama_producto`)
) ENGINE=InnoDB;

CREATE TABLE `proveedor` (
  `id_proveedor` INT NOT NULL,
  `nombre_proveedor` VARCHAR(50) NULL,
  `apellido_proveedor` VARCHAR(50) NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB;

CREATE TABLE `proveedor_producto` (
  `id_proveedor` INT NOT NULL,
  `nuevo_precio` DECIMAL(15) NULL,
  `viejo_precio` DECIMAL(15) NULL,
  `codigo_producto` VARCHAR(15) NOT NULL,
  INDEX `fk_proveedor_producto_proveedor1_idx` (`id_proveedor`),
  INDEX `fk_proveedor_producto_producto1_idx` (`codigo_producto`),
  CONSTRAINT `pk_proveedor_producto` PRIMARY KEY (`id_proveedor`, `codigo_producto`),
  CONSTRAINT `fk_proveedor_producto_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `fk_proveedor_producto_producto1`
    FOREIGN KEY (`codigo_producto`)
    REFERENCES `producto` (`codigo_producto`)
) ENGINE = InnoDB;

CREATE TABLE `rol` (
  `id_rol` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(50) NOT NULL,
  `mostrarProductos` TINYINT NULL DEFAULT 1,
  `activo` TINYINT NULL DEFAULT 1,
  `creado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rol`)
) ENGINE = InnoDB;

CREATE TABLE `pais` (
  `id_pais` INT(10) NOT NULL AUTO_INCREMENT,
  `nombre_pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;

CREATE TABLE `region` (
  `id_region` INT(10) NOT NULL AUTO_INCREMENT,
  `nombre_region` VARCHAR(45) NULL,
  `id_pais` INT(10) NOT NULL,
  PRIMARY KEY (`id_region`),
  INDEX `fk_region_pais1_idx` (`id_pais`),
  CONSTRAINT `fk_region_pais1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `pais` (`id_pais`)
) ENGINE = InnoDB;

CREATE TABLE `ciudad` (
  `id_ciudad` INT(10) NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(45) NULL,
  `id_region` INT(10) NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  INDEX `fk_ciudad_region1_idx` (`id_region` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_region1`
    FOREIGN KEY (`id_region`)
    REFERENCES `region` (`id_region`))
ENGINE = InnoDB;

CREATE TABLE `oficina` (
  `id_oficina` VARCHAR(10) NOT NULL,
  `numero_telefono_oficina` VARCHAR(45) NULL,
  `linea_direccion_1` VARCHAR(50) NULL,
  `linea_direccion_2` VARCHAR(50) NULL,
  `id_ciudad` INT(10) NOT NULL,
  `id_oficina_principal` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id_oficina`),
  INDEX `fk_oficina_ciudad1_idx` (`id_ciudad`),
  INDEX `fk_oficina_oficina1_idx` (`id_oficina_principal`),
  CONSTRAINT `fk_oficina_ciudad1`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `ciudad` (`id_ciudad`)
) ENGINE = InnoDB;

CREATE TABLE `empleado` (
  `id_empleado` INT(11) NOT NULL,
  `nombre_empleado` VARCHAR(50) NULL,
  `apellido_empleado` VARCHAR(50) NULL DEFAULT NULL,
  `segundo_apellido_empleado` VARCHAR(50) NULL,
  `extension_empleado` VARCHAR(45) NULL,
  `correo_electronico_empleado` VARCHAR(100) NULL,
  `id_jefe` INT(11) NULL,
  `id_rol` INT(11) NOT NULL,
  `activo` TINYINT NULL DEFAULT 1,
  `creado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `id_oficina` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `fk_empleado_empleado1_idx` (`id_jefe`),
  INDEX `fk_empleado_rol1_idx` (`id_rol`),
  INDEX `fk_empleado_oficina1_idx` (`id_oficina`),
  CONSTRAINT `fk_empleado_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `rol` (`id_rol`),
  CONSTRAINT `fk_empleado_oficina1`
    FOREIGN KEY (`id_oficina`)
    REFERENCES `oficina` (`id_oficina`)
) ENGINE = InnoDB;

CREATE TABLE `cliente` (
  `id_cliente` INT NOT NULL,
  `nombre_cliente` VARCHAR(50) NULL,
  `apellido_cliente` VARCHAR(50) NULL,
  `limite_credito` DECIMAL(15) NULL,
  `id_empleado` INT(11) NULL DEFAULT NULL,
  `correo_electronico_cliente` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_empleado1_idx` (`id_empleado`),
  CONSTRAINT `fk_cliente_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
) ENGINE = InnoDB;

CREATE TABLE `direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `linea_direccion_1` VARCHAR(250) NULL,
  `linea_direccion_2` VARCHAR(250) NULL,
  `tipo_direccion` VARCHAR(45) NULL,
  `id_ciudad` INT(10) NOT NULL,
  `id_proveedor` INT NULL DEFAULT NULL,
  `id_cliente` INT NULL DEFAULT NULL,
  `id_empleado` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_direccion`),
  INDEX `fk_direccion_ciudad1_idx` (`id_ciudad`),
  INDEX `fk_direccion_proveedor1_idx` (`id_proveedor`),
  INDEX `fk_direccion_cliente1_idx` (`id_cliente`),
  INDEX `fk_direccion_empleado1_idx` (`id_empleado`),
  CONSTRAINT `fk_direccion_ciudad1`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `ciudad` (`id_ciudad`),
  CONSTRAINT `fk_direccion_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `fk_direccion_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `fk_direccion_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
) ENGINE = InnoDB;

CREATE TABLE `contacto_cliente` (
  `id_contacto_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `primer_apellido` VARCHAR(45) NULL,
  `segundo_apellido` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_contacto_cliente` VARCHAR(45) NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_contacto_cliente`),
  INDEX `fk_contacto_cliente_cliente1_idx` (`id_cliente`),
  CONSTRAINT `fk_contacto_cliente_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
) ENGINE = InnoDB;

CREATE TABLE `numero_telefono` (
  `id_numero_telefono` INT NOT NULL AUTO_INCREMENT,
  `numero_telefono` VARCHAR(45) NULL,
  `prefijo_numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `creado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `quien_es` VARCHAR(45) NULL,
  `id_oficina` VARCHAR(10) NULL DEFAULT NULL,
  `id_empleado` INT(11) NULL DEFAULT NULL,
  `id_proveedor` INT NULL DEFAULT NULL,
  `id_contacto_cliente` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_numero_telefono`),
  INDEX `fk_numero_telefono_oficina1_idx` (`id_oficina`),
  INDEX `fk_numero_telefono_empleado1_idx` (`id_empleado`),
  INDEX `fk_numero_telefono_proveedor1_idx` (`id_proveedor`),
  INDEX `fk_numero_telefono_contacto_cliente1_idx` (`id_contacto_cliente`),
  CONSTRAINT `fk_numero_telefono_oficina1`
    FOREIGN KEY (`id_oficina`)
    REFERENCES `oficina` (`id_oficina`),
  CONSTRAINT `fk_numero_telefono_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `fk_numero_telefono_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `fk_numero_telefono_contacto_cliente1`
    FOREIGN KEY (`id_contacto_cliente`)
    REFERENCES `contacto_cliente` (`id_contacto_cliente`)
) ENGINE = InnoDB;

CREATE TABLE `pedido` (
  `codigo_pedido` INT NOT NULL,
  `fecha_pedido` DATE NULL,
  `fecha_espera` DATE NULL,
  `fecha_entrega` DATE NULL,
  `comentarios` TEXT NULL,
  `estado` VARCHAR(15) NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`codigo_pedido`),
  INDEX `fk_pedido_cliente1_idx` (`id_cliente`),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
) ENGINE = InnoDB;

CREATE TABLE `detalle_pedido` (
  `cantidad` INT(11) NULL,
  `precio_unitario` DECIMAL(15) NULL,
  `numero_linea` SMALLINT(6) NULL,
  `codigo_pedido` INT NOT NULL,
  `codigo_producto` VARCHAR(15) NOT NULL,
  INDEX `fk_detalle_pedido_pedido1_idx` (`codigo_pedido`),
  INDEX `fk_detalle_pedido_producto1_idx` (`codigo_producto`),
  PRIMARY KEY (`codigo_producto`, `codigo_pedido`),
  CONSTRAINT `fk_detalle_pedido_pedido1`
    FOREIGN KEY (`codigo_pedido`)
    REFERENCES `pedido` (`codigo_pedido`),
  CONSTRAINT `fk_detalle_pedido_producto1`
    FOREIGN KEY (`codigo_producto`)
    REFERENCES `producto` (`codigo_producto`)
) ENGINE = InnoDB;

CREATE TABLE `pago` (
  `id_transaccion` VARCHAR(50) NOT NULL,
  `fecha_pago` DATE NULL,
  `total` DECIMAL(15) NULL,
  `metodo_pago` VARCHAR(45) NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  INDEX `fk_pago_cliente1_idx` (`id_cliente`),
  CONSTRAINT `fk_pago_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
) ENGINE = InnoDB;


INSERT INTO `gama_producto` (`id_gama_producto`, `descripcion`, `descripcion_html`, `imagen`) VALUES
('GAMA001', 'Descripción de la gama de productos 1', '<p>Descripción HTML de la gama de productos 1</p>', 'imagen1.jpg'),
('GAMA002', 'Descripción de la gama de productos 2', '<p>Descripción HTML de la gama de productos 2</p>', 'imagen2.jpg'),
('GAMA003', 'Descripción de la gama de productos 3', '<p>Descripción HTML de la gama de productos 3</p>', 'imagen3.jpg');

INSERT INTO `gama_producto` (`id_gama_producto`, `descripcion`, `descripcion_html`, `imagen`) VALUES
('GAMA004', 'Descripción de la gama de productos 4', '<p>Descripción HTML de la gama de productos 4</p>', 'imagen4.jpg'),
('GAMA005', 'Descripción de la gama de productos 5', '<p>Descripción HTML de la gama de productos 5</p>', 'imagen5.jpg'),
('GAMA006', 'Descripción de la gama de productos 6', '<p>Descripción HTML de la gama de productos 6</p>', 'imagen6.jpg');


INSERT INTO `producto` (`codigo_producto`, `nombre_producto`, `descripcion`, `cantidad_existente`, `precio_venta`, `gama`, `altura`, `ancho`, `longitud`, `peso`) VALUES
('PROD001', 'Producto 1', 'Descripción del producto 1', 100, 49.99, 'GAMA001', 10, 5, 15, 200),
('PROD002', 'Producto 2', 'Descripción del producto 2', 150, 99.99, 'GAMA002', 15, 8, 20, 300),
('PROD003', 'Producto 3', 'Descripción del producto 3', 200, 149.99, 'GAMA003', 20, 10, 25, 400);

INSERT INTO `producto` (`codigo_producto`, `nombre_producto`, `descripcion`, `cantidad_existente`, `precio_venta`, `gama`, `altura`, `ancho`, `longitud`, `peso`) VALUES
('PROD004', 'Producto 4', 'Descripción del producto 4', 120, 79.99, 'GAMA004', 12, 6, 18, 250),
('PROD005', 'Producto 5', 'Descripción del producto 5', 180, 129.99, 'GAMA005', 18, 9, 22, 350),
('PROD006', 'Producto 6', 'Descripción del producto 6', 220, 179.99, 'GAMA006', 22, 11, 27, 450);


INSERT INTO `proveedor` (`id_proveedor`, `nombre_proveedor`, `apellido_proveedor`) VALUES
(1, 'Proveedor1', 'Apellido1'),
(2, 'Proveedor2', 'Apellido2'),
(3, 'Proveedor3', 'Apellido3');

INSERT INTO `proveedor` (`id_proveedor`, `nombre_proveedor`, `apellido_proveedor`) VALUES
(4, 'Proveedor4', 'Apellido4'),
(5, 'Proveedor5', 'Apellido5'),
(6, 'Proveedor6', 'Apellido6');


INSERT INTO `proveedor_producto` (`id_proveedor`, `nuevo_precio`, `viejo_precio`, `codigo_producto`) VALUES
(1, 50.99, 45.99, 'PROD001'),
(2, 99.99, 89.99, 'PROD002'),
(3, 149.99, 129.99, 'PROD003');

INSERT INTO `proveedor_producto` (`id_proveedor`, `nuevo_precio`, `viejo_precio`, `codigo_producto`) VALUES
(4, 75.99, 69.99, 'PROD004'),
(5, 119.99, 109.99, 'PROD005'),
(6, 169.99, 149.99, 'PROD006');


INSERT INTO `rol` (`nombre_rol`, `mostrarProductos`, `activo`, `creado_en`, `actualizado_en`) VALUES
('Administrador', 1, 1, '2023-06-09', '2024-05-09'),
('Usuario', 1, 1, '2020-07-19', '2024-05-09'),
('Invitado', 0, 1, '2011-05-29', '2024-05-09');

INSERT INTO `pais` (`nombre_pais`) VALUES
('Argentina'),
('Brasil'),
('Chile'),
('Colombia'),
('Ecuador');

INSERT INTO `region` (`nombre_region`, `id_pais`) VALUES
('Región Norte', 1),
('Región Sur', 1),
('Región Sudeste', 2),
('Región Nordeste', 2),
('Región Central', 3);

INSERT INTO `region` (`nombre_region`, `id_pais`) VALUES
('Región Oeste', 1),
('Región Este', 1),
('Región Occidental', 2),
('Región Oriental', 2),
('Región Norte', 3),
('Región Sur', 3);


INSERT INTO `ciudad` (`nombre_ciudad`, `codigo_postal`, `id_region`) VALUES
('Buenos Aires', 'C1234', 1),
('Sao Paulo', '01000-000', 3),
('Santiago', '8320000', 2),
('Bogotá', '110111', 2),
('Quito', '170150', 1);

INSERT INTO `oficina` (`id_oficina`, `numero_telefono_oficina`, `linea_direccion_1`, `linea_direccion_2`, `id_ciudad`, `id_oficina_principal`) VALUES
('OF001', '123456789', 'Calle Principal 123', NULL, 1, NULL),
('OF002', '987654321', 'Avenida Central 456', 'Edificio XYZ, Piso 2', 3, 'OF001'),
('OF003', '555555555', 'Carrera 7 123', 'Torre Norte, Piso 5', 4, 'OF002');

INSERT INTO `oficina` (`id_oficina`, `numero_telefono_oficina`, `linea_direccion_1`, `linea_direccion_2`, `id_ciudad`, `id_oficina_principal`) VALUES
('OF004', '111111111', 'Calle Este 789', NULL, 2, NULL),
('OF005', '222222222', 'Avenida Sur 456', 'Edificio ABC, Piso 3', 5, 'OF004'),
('OF006', '333333333', 'Carrera 5 678', 'Torre Sur, Piso 10', 4, 'OF005');


INSERT INTO `empleado` (`id_empleado`, `nombre_empleado`, `apellido_empleado`, `segundo_apellido_empleado`, `extension_empleado`, `correo_electronico_empleado`, `id_jefe`, `id_rol`, `activo`, `creado_en`, `actualizado_en`, `id_oficina`) VALUES
(1, 'Juan', 'Perez', 'Garcia', '123456', 'juan@example.com', NULL, 1, 1, '2022-10-15', '2023-03-20', 'OF001'),
(2, 'Maria', 'Gomez', 'Lopez', '456789', 'maria@example.com', 1, 2, 1, '2022-09-20', '2023-04-25', 'OF002'),
(3, 'Carlos', 'Martinez', 'Fernandez', '789123', 'carlos@example.com', 1, 2, 1, '2022-09-20', '2023-04-25', 'OF002');

INSERT INTO `empleado` (`id_empleado`, `nombre_empleado`, `apellido_empleado`, `segundo_apellido_empleado`, `extension_empleado`, `correo_electronico_empleado`, `id_jefe`, `id_rol`, `activo`, `creado_en`, `actualizado_en`, `id_oficina`) VALUES
(4, 'Ana', 'Lopez', 'Sánchez', '987654', 'ana@example.com', 2, 3, 1, '2022-08-10', '2023-02-15', 'OF001'),
(5, 'Pedro', 'Rodriguez', 'Diaz', '654321', 'pedro@example.com', 2, 3, 1, '2022-07-05', '2023-01-10', 'OF002'),
(6, 'Laura', 'Hernandez', 'Gutierrez', '321987', 'laura@example.com', 3, 2, 1, '2022-06-15', '2022-12-20', 'OF003');

INSERT INTO `cliente` (`id_cliente`, `nombre_cliente`, `apellido_cliente`, `limite_credito`, `id_empleado`, `correo_electronico_cliente`) VALUES
(1, 'Pedro', 'Gonzalez', 1000.00, 1, 'pedro@example.com'),
(2, 'Ana', 'Lopez', 1500.00, 2, 'ana@example.com'),
(3, 'Javier', 'Martinez', 2000.00, 3, 'javier@example.com');

INSERT INTO `cliente` (`id_cliente`, `nombre_cliente`, `apellido_cliente`, `limite_credito`, `id_empleado`, `correo_electronico_cliente`) VALUES
(4, 'Laura', 'Gomez', 1200.00, 4, 'laura@example.com'),
(5, 'Carlos', 'Rodriguez', 1800.00, 5, 'carlos@example.com'),
(6, 'Sofia', 'Diaz', 2200.00, 6, 'sofia@example.com');


INSERT INTO `direccion` (`id_direccion`, `linea_direccion_1`, `linea_direccion_2`, `tipo_direccion`, `id_ciudad`, `id_proveedor`, `id_cliente`, `id_empleado`) VALUES
(1, 'Calle Principal 123', 'Colonia Centro', 'Residencial', 1, NULL, 1, NULL),
(2, 'Avenida Secundaria 456', NULL, 'Oficina', 2, NULL, NULL, 2),
(3, 'Calle Secundaria 789', NULL, 'Oficina', 3, NULL, NULL, 3);

INSERT INTO `direccion` (`id_direccion`, `linea_direccion_1`, `linea_direccion_2`, `tipo_direccion`, `id_ciudad`, `id_proveedor`, `id_cliente`, `id_empleado`) VALUES
(4, 'Calle Principal Norte 123', 'Urbanización Los Pinos', 'Residencial', 1, NULL, 4, NULL),
(5, 'Avenida Central 456', 'Edificio ABC, Piso 3', 'Oficina', 2, NULL, NULL, 5),
(6, 'Carrera 7 Este 789', NULL, 'Oficina', 3, NULL, NULL, 6);


INSERT INTO `contacto_cliente` (`id_contacto_cliente`, `nombre`, `apellido`, `tipo_contacto_cliente`, `id_cliente`) VALUES
(1, 'Juan', 'Pérez', 'Principal', 1),
(2, 'María', 'Gómez', 'Secundario', 2),
(3, 'Carlos', 'Martínez', 'Principal', 3);
INSERT INTO `contacto_cliente` (`id_contacto_cliente`, `nombre`, `apellido`, `tipo_contacto_cliente`, `id_cliente`) VALUES
(4, 'Laura', 'García', 'Secundario', 4),
(5, 'Pedro', 'Rodríguez', 'Principal', 5),
(6, 'Sofía', 'Díaz', 'Principal', 6);


-- Insertar datos para oficinas
INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_oficina`)
VALUES 
  ('1234567890', '+1', 'Oficina', 'Juan', 'OF001'),
  ('9876543210', '+1', 'Oficina', 'Maria', 'OF002');

INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_oficina`)
VALUES 
  ('5555555555', '+1', 'Oficina', 'Carlos', 'OF002'),
  ('1111111111', '+1', 'Oficina', 'Laura', 'OF006');
  
-- Insertar datos para empleados
INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_empleado`)
VALUES 
  ('5555555555', '+1', 'Personal', 'Juan', 1),
  ('6666666666', '+1', 'Trabajo', 'Maria', 2),
  ('7777777777', '+1', 'Trabajo', 'Carlos', 3),
  ('8888888888', '+1', 'Personal', 'Ana', 4),
  ('9999999999', '+1', 'Personal', 'Pedro', 5),
  ('1010101010', '+1', 'Personal', 'Laura', 6);


-- Insertar datos para proveedores
INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_proveedor`)
VALUES 
  ('9999999999', '+1', 'Oficina', 'Proveedor1', 1),
  ('8888888888', '+1', 'Oficina', 'Proveedor2', 2);
INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_proveedor`)
VALUES 
  ('2222222222', '+1', 'Personal', 'Proveedor3', 3),
  ('3333333333', '+1', 'Oficina', 'Proveedor4', 4);


-- Insertar datos para contactos de clientes
INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_contacto_cliente`)
VALUES 
  ('1111111111', '+1', 'Personal', 'Cliente1', 1),
  ('2222222222', '+1', 'Trabajo', 'Cliente2', 2);
INSERT INTO `numero_telefono` (`numero_telefono`, `prefijo_numero_telefono`, `tipo_numero_telefono`, `quien_es`, `id_contacto_cliente`)
VALUES 
  ('3333333333', '+1', 'Personal', 'Cliente3', 3),
  ('4444444444', '+1', 'Trabajo', 'Cliente4', 4);


INSERT INTO `pedido` (`codigo_pedido`, `fecha_pedido`, `fecha_espera`, `fecha_entrega`, `comentarios`, `estado`, `id_cliente`) 
VALUES
(1, '2024-02-10', '2024-04-15', '2024-05-02', 'Pedido urgente', 'En proceso', 1),
(2, '2024-03-12', '2024-04-17', NULL, 'Pedido estándar', 'Pendiente', 2),
(3, '2024-04-14', '2024-04-19', NULL, 'Pedido especial', 'Pendiente', 3),
(4, '2024-01-10', '2024-04-15', '2024-05-02', 'Pedido urgente', 'En proceso', 3);

INSERT INTO `pedido` (`codigo_pedido`, `fecha_pedido`, `fecha_espera`, `fecha_entrega`, `comentarios`, `estado`, `id_cliente`) 
VALUES
(6, '2024-05-20', '2024-06-25', NULL, 'Pedido urgente', 'Pendiente', 4),
(7, '2024-06-15', '2024-06-30', NULL, 'Pedido estándar', 'Pendiente', 5),
(8, '2024-07-18', '2024-08-10', NULL, 'Pedido especial', 'Pendiente', 6),
(9, '2024-08-10', '2024-09-05', '2024-09-20', 'Pedido urgente', 'Entregado', 4);

INSERT INTO `detalle_pedido` (`cantidad`, `precio_unitario`, `numero_linea`, `codigo_pedido`, `codigo_producto`) VALUES
(5, 10.99, 1, 1, 'PROD001'),
(3, 8.50, 2, 2, 'PROD002'),
(2, 15.75, 3, 3, 'PROD003'),
(1, 20.00, 4, 4,'PROD003');

INSERT INTO `detalle_pedido` (`cantidad`, `precio_unitario`, `numero_linea`, `codigo_pedido`, `codigo_producto`) VALUES
(4, 12.75, 5, 6, 'PROD004'),
(2, 9.99, 6, 7, 'PROD005'),
(3, 18.50, 7, 8, 'PROD006'),
(6, 22.00, 8, 9, 'PROD005');


INSERT INTO `pago` (`id_transaccion`, `fecha_pago`, `total`, `metodo_pago`, `id_cliente`) VALUES
('TRANS001', '2024-05-09', 100.00, 'Tarjeta de crédito', 1),
('TRANS002', '2024-05-10', 75.50, 'Transferencia bancaria', 2),
('TRANS003', '2024-05-11', 120.25, 'PayPal', 3),
('TRANS004', '2024-05-12', 200.00, 'Efectivo', 3);
