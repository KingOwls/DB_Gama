
# Presentacion de los resultados de Tablas

Los objetos de tipo Date reprecentan un momento fijo en le tiempo de un formato independiente, 

aConsultas sobre una tabla
```
``
```

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas
```
SELECT 
    oficina.id_oficina,
    ciudad.nombre_ciudad 
FROM 
    oficina, 
    ciudad
WHERE 
    ciudad.id_ciudad = oficina.id_ciudad;

+------------+---------------+
| id_oficina | nombre_ciudad |
+------------+---------------+
| OF001      | Buenos Aires  |
| OF002      | Santiago      |
| OF003      | Bogotá        |
+------------+---------------+
```
2. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

```
SELECT 
    e.nombre_empleado AS 'Nombre',
    e.apellido_empleado AS 'Apellido',
    r.nombre_rol AS 'Rol'
FROM
    empleado AS e 
INNER JOIN
    rol AS r ON r.id_rol = e.id_rol
WHERE 
    r.nombre_rol != 'Representante Ventas'
ORDER BY 
    r.nombre_rol ASC;
+--------+----------+---------------+
| Nombre | Apellido | Rol           |
+--------+----------+---------------+
| Juan   | Perez    | Administrador |
| Maria  | Gomez    | Usuario       |
| Carlos | Martinez | Usuario       |
+--------+----------+---------------+
```
3. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
```
SELECT DISTINCT 
	o.estado 
FROM 
	pedido AS o;
+------------+
| estado     |
+------------+
| En proceso |
| Pendiente  |
+------------+
```
4. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
```
SELECT 
	p.codigo_pedido AS 'Codigo Pedido',
	p.id_cliente AS 'Codigo Cliente',
	p.fecha_espera AS 'Fecha de Espera',
	p.fecha_entrega AS 'Fecha de Entrega'
FROM 
	pedido AS p

+---------------+----------------+-----------------+------------------+
| Codigo Pedido | Codigo Cliente | Fecha de Espera | Fecha de Entrega |
+---------------+----------------+-----------------+------------------+
|             1 |              1 | 2024-04-15      | 2024-05-02       |
|             2 |              2 | 2024-04-17      | NULL             |
|             3 |              3 | 2024-04-19      | NULL             |
|             4 |              3 | 2024-04-15      | 2024-05-02       |
+---------------+----------------+-----------------+------------------+
```
5. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
```
SELECT DISTINCT 
	p.metodo_pago AS 'Metodo'
FROM 
	pago AS p;
+------------------------+
| Metodo                 |
+------------------------+
| Tarjeta de crédito     |
| Transferencia bancaria |
| PayPal                 |
| Efectivo               |
+------------------------+
```

6. ¿Cuántos empleados hay en la compañía?
```
SELECT 
	COUNT(e.id_empleado) AS 'Total Empleados'
FROM
	empleado AS e;

+-----------------+
| Total Empleados |
+-----------------+
|               3 |
+-----------------+
```
7. 7. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
```
SELECT 
	o.estado, 
	COUNT(o.codigo_pedido) AS 'Numero_Pedidos' 
FROM 
	pedido AS o
GROUP BY
	o.estado 
ORDER BY
	Numero_Pedidos DESC;

+------------+----------------+
| estado     | Numero_Pedidos |
+------------+----------------+
| En proceso |              2 |
| Pendiente  |              2 |
+------------+----------------+
```

Debe generar 10 procedimientos almacenados por cada base de datos. Los procedimientos deben incluir procesos de Crear, Actualizar, eliminar o buscar.

1. Procedimiento para crear una nueva gama de producto:
```
DELIMITER //
CREATE PROCEDURE CrearGamaProducto(
    IN p_id_gama_producto VARCHAR(50),
    IN p_descripcion TEXT,
    IN p_descripcion_html TEXT,
    IN p_imagen VARCHAR(256)
)
BEGIN
    INSERT INTO gama_producto (id_gama_producto, descripcion, descripcion_html, imagen)
    VALUES (p_id_gama_producto, p_descripcion, p_descripcion_html, p_imagen);
END //
DELIMITER ;
```
2. Procedimiento para buscar una gama de producto por su ID:
```
DELIMITER //
CREATE PROCEDURE BuscarGamaProductoPorID(
    IN p_id_gama_producto VARCHAR(50)
)
BEGIN
    SELECT * FROM gama_producto WHERE id_gama_producto = p_id_gama_producto;
END //
DELIMITER ;
```
3. Procedimiento para actualizar la descripción de una gama de producto:
```
DELIMITER //
CREATE PROCEDURE ActualizarDescripcionGamaProducto(
    IN p_id_gama_producto VARCHAR(50),
    IN p_nueva_descripcion TEXT
)
BEGIN
    UPDATE gama_producto SET descripcion = p_nueva_descripcion
    WHERE id_gama_producto = p_id_gama_producto;
END //
DELIMITER ;
```
4. Procedimiento para eliminar una gama de producto por su ID:
```
DELIMITER //
CREATE PROCEDURE EliminarGamaProducto(
    IN p_id_gama_producto VARCHAR(50)
)
BEGIN
    DELETE FROM gama_producto WHERE id_gama_producto = p_id_gama_producto;
END //
DELIMITER ;
```
5. Procedimiento para listar todas las gamas de productos:
```
DELIMITER //
CREATE PROCEDURE ListarGamasProductos()
BEGIN
    SELECT * FROM gama_producto;
END //
DELIMITER ;
```
6. Procedimiento para crear un nuevo producto:
```
DELIMITER //
CREATE PROCEDURE CrearProducto(
    IN p_codigo_producto VARCHAR(255),
    IN p_nombre_producto VARCHAR(255),
    IN p_descripcion TEXT,
    IN p_cantidad_existente SMALLINT,
    IN p_precio_venta DECIMAL(15, 2),
    IN p_gama VARCHAR(50),
    IN p_altura SMALLINT,
    IN p_ancho SMALLINT,
    IN p_longitud SMALLINT,
    IN p_peso SMALLINT
)
BEGIN
    INSERT INTO producto (codigo_producto, nombre_producto, descripcion, cantidad_existente, precio_venta, gama, altura, ancho, longitud, peso)
    VALUES (p_codigo_producto, p_nombre_producto, p_descripcion, p_cantidad_existente, p_precio_venta, p_gama, p_altura, p_ancho, p_longitud, p_peso);
END //
DELIMITER ;
```
7. Procedimiento para buscar un producto por su código:
```
DELIMITER //
CREATE PROCEDURE BuscarProductoPorCodigo(
    IN p_codigo_producto VARCHAR(255)
)
BEGIN
    SELECT * FROM producto WHERE codigo_producto = p_codigo_producto;
END //
DELIMITER ;
```
8. Procedimiento para actualizar el precio de venta de un producto:
```
DELIMITER //
CREATE PROCEDURE ActualizarPrecioVentaProducto(
    IN p_codigo_producto VARCHAR(255),
    IN p_nuevo_precio DECIMAL(15, 2)
)
BEGIN
    UPDATE producto SET precio_venta = p_nuevo_precio
    WHERE codigo_producto = p_codigo_producto;
END //
DELIMITER ;
```
9. Procedimiento para eliminar un producto por su código:
```
DELIMITER //
CREATE PROCEDURE EliminarProducto(
    IN p_codigo_producto VARCHAR(255)
)
BEGIN
    DELETE FROM producto WHERE codigo_producto = p_codigo_producto;
END //
DELIMITER ;
```
10. Procedimiento para listar todos los productos:
```
DELIMITER //
CREATE PROCEDURE ListarProductos()
BEGIN
    SELECT * FROM producto;
END //
DELIMITER ;
```
