
# Presentacion de los resultados de Tablas

Los objetos de tipo Date reprecentan un momento fijo en le tiempo de un formato independiente, 

aConsultas sobre una tabla0
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
8. Consulta para obtener el detalle de un pedido específico, incluyendo los productos solicitados
```
SELECT 
    p.codigo_pedido,
    p.fecha_pedido,
    p.fecha_espera,
    p.fecha_entrega,
    p.comentarios,
    p.estado,
    c.nombre_cliente,
    c.apellido_cliente,
    dp.cantidad,
    dp.precio_unitario,
    dp.numero_linea,
    pr.nombre_producto,
    pr.descripcion
FROM 
    pedido p
INNER JOIN 
    cliente c ON p.id_cliente = c.id_cliente
INNER JOIN 
    detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
INNER JOIN 
    producto pr ON dp.codigo_producto = pr.codigo_producto
WHERE 
    p.codigo_pedido = 1;

+---------------+--------------+--------------+---------------+----------------+------------+----------------+------------------+----------+-----------------+--------------+-----------------+-----------------------------+
| codigo_pedido | fecha_pedido | fecha_espera | fecha_entrega | comentarios    | estado     | nombre_cliente | apellido_cliente | cantidad | precio_unitario | numero_linea | nombre_producto | descripcion                 |
+---------------+--------------+--------------+---------------+----------------+------------+----------------+------------------+----------+-----------------+--------------+-----------------+-----------------------------+
|             1 | 2024-02-10   | 2024-04-15   | 2024-05-02    | Pedido urgente | En proceso | Pedro          | Gonzalez         |        5 |              11 |            1 | Producto 1      | Descripción del producto 1  |
+---------------+--------------+--------------+---------------+----------------+------------+----------------+------------------+----------+-----------------+--------------+-----------------+-----------------------------
```
9. Consulta para obtener el nombre del empleado que realizó un pedido y su correo electrónico:
```
SELECT 
    nt.numero_telefono,
    nt.prefijo_numero_telefono,
    nt.quien_es
FROM 
    numero_telefono nt
INNER JOIN 
    proveedor p ON nt.id_proveedor = p.id_proveedor
WHERE 
    p.nombre_proveedor = 'Proveedor1';

+-----------------+-------------------------+------------+
| numero_telefono | prefijo_numero_telefono | quien_es   |
+-----------------+-------------------------+------------+
| 9999999999      | +1                      | Proveedor1 |
+-----------------+-------------------------+------------+
```
10. Consulta para obtener el detalle de un pedido específico, incluyendo los productos solicitados
```
SELECT 
    e.nombre_empleado,
    e.apellido_empleado,
    e.correo_electronico_empleado
FROM 
    empleado e
INNER JOIN 
    cliente c ON e.id_empleado = c.id_empleado
INNER JOIN 
    pedido p ON c.id_cliente = p.id_cliente
WHERE 
    p.codigo_pedido = 1;
+-----------------+-------------------+-----------------------------+
| nombre_empleado | apellido_empleado | correo_electronico_empleado |
+-----------------+-------------------+-----------------------------+
| Juan            | Perez             | juan@example.com            |
+-----------------+-------------------+-----------------------------+
```
Consultas sobre una tabla

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
```
SELECT r.nombre_rol AS puesto,
       e.nombre_empleado AS nombre,
       e.apellido_empleado AS apellido,
       e.correo_electronico_empleado AS email
FROM empleado e
JOIN rol r ON e.id_rol = r.id_rol
WHERE e.id_jefe IS NULL;
+---------------+--------+----------+------------------+
| puesto        | nombre | apellido | email            |
+---------------+--------+----------+------------------+
| Administrador | Juan   | Perez    | juan@example.com |
+---------------+--------+----------+------------------+
 ```  
6. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
```
SELECT e.nombre_empleado AS nombre,
       e.apellido_empleado AS apellido,
       r.nombre_rol AS puesto
FROM empleado e
JOIN rol r ON e.id_rol = r.id_rol
WHERE r.nombre_rol != 'Representante de ventas';

+--------+-----------+---------------+
| nombre | apellido  | puesto        |
+--------+-----------+---------------+
| Juan   | Perez     | Administrador |
| Maria  | Gomez     | Usuario       |
| Carlos | Martinez  | Usuario       |
| Laura  | Hernandez | Usuario       |
| Ana    | Lopez     | Invitado      |
| Pedro  | Rodriguez | Invitado      |
+--------+-----------+---------------+
```

9. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
```
SELECT DISTINCT estado
FROM pedido;
+------------+
| estado     |
+------------+
| En proceso |
| Pendiente  |
| Entregado  |
+------------+
```

12. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo.
```
SELECT DISTINCT p1.id_cliente
FROM pago p1
WHERE EXISTS (
    SELECT 1
    FROM pago p2
    WHERE p1.id_cliente = p2.id_cliente
    AND p2.fecha_pago BETWEEN '2008-01-01' AND '2008-12-31'
);
```
15. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
```
SELECT codigo_pedido, id_cliente, fecha_pedido, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_pedido
AND fecha_entrega IS NOT NULL;

+---------------+------------+--------------+---------------+
| codigo_pedido | id_cliente | fecha_pedido | fecha_entrega |
+---------------+------------+--------------+---------------+
|             1 |          1 | 2024-02-10   | 2024-05-02    |
|             4 |          3 | 2024-01-10   | 2024-05-02    |
|             9 |          4 | 2024-08-10   | 2024-09-20    |
+---------------+------------+--------------+---------------+
```

18. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas.
```
SELECT DISTINCT forma_pago
FROM pago;
+------------------------+
| metodo_pago            |
+------------------------+
| Tarjeta de crédito     |
| Transferencia bancaria |
| PayPal                 |
| Efectivo               |
+------------------------+
```
¿Cuántos empleados hay en la compañía?
```
SELECT COUNT(*) AS total_empleados
FROM empleado;

+-----------------+
| total_empleados |
+-----------------+
|               6 |
+-----------------+
```
¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.
```
SELECT COUNT(*) AS numero_pedidos
FROM pedido
ORDER BY codigo_pedido DESC;
+----------------+
| numero_pedidos |
+----------------+
|              8 |
+----------------+
```
Calcula el precio de venta del producto más caro y más barato en una
misma consulta.
```
SELECT 
    MAX(precio_venta) AS precio_mas_caro,
    MIN(precio_venta) AS precio_mas_barato
FROM producto;

+-----------------+-------------------+
| precio_mas_caro | precio_mas_barato |
+-----------------+-------------------+
|          179.99 |             49.99 |
+-----------------+-------------------+
```
Calcula el número de clientes que tiene la empresa.
```
SELECT COUNT(*) AS numero_de_clientes
FROM clientes;

+--------------------+
| numero_de_clientes |
+--------------------+
|                  6 |
+--------------------+
```
¿Calcula cuántos clientes empiezan por M?
```
SELECT COUNT(*) AS clientes_que_empiezan_por_M
FROM cliente
WHERE nombre_cliente LIKE 'M%';

+-----------------------------+
| clientes_que_empiezan_por_M |
+-----------------------------+
|                           0 |
+-----------------------------+
```

Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
```
SELECT c.nombre_cliente AS nombre_cliente, c.apellido_cliente AS apellidos_cliente,
       MIN(p.fecha_pago) AS primer_pago, MAX(p.fecha_pago) AS ultimo_pago
FROM cliente c
LEFT JOIN pago p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

+----------------+-------------------+-------------+-------------+
| nombre_cliente | apellidos_cliente | primer_pago | ultimo_pago |
+----------------+-------------------+-------------+-------------+
| Pedro          | Gonzalez          | 2024-05-09  | 2024-05-09  |
| Ana            | Lopez             | 2024-05-10  | 2024-05-10  |
| Javier         | Martinez          | 2024-05-11  | 2024-05-12  |
| Laura          | Gomez             | NULL        | NULL        |
| Carlos         | Rodriguez         | NULL        | NULL        |
| Sofia          | Diaz              | NULL        | NULL        |
+----------------+-------------------+-------------+-------------+
```
Calcula el número de productos diferentes que hay en cada uno de los
pedidos.
```
SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS productos_diferentes
FROM detalle_pedido
GROUP BY codigo_pedido;

+---------------+----------------------+
| codigo_pedido | productos_diferentes |
+---------------+----------------------+
|             1 |                    1 |
|             2 |                    1 |
|             3 |                    1 |
|             4 |                    1 |
|             6 |                    1 |
|             7 |                    1 |
|             8 |                    1 |
|             9 |                    1 |
+---------------+----------------------+
```
Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.
```
SELECT codigo_pedido, SUM(cantidad) AS cantidad_total
FROM detalle_pedido
GROUP BY codigo_pedido;
+---------------+----------------+
| codigo_pedido | cantidad_total |
+---------------+----------------+
|             1 |              5 |
|             2 |              3 |
|             3 |              2 |
|             4 |              1 |
|             6 |              4 |
|             7 |              2 |
|             8 |              3 |
|             9 |              6 |
+---------------+----------------+
```
Devuelve un listado de los 20 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.
```
SELECT codigo_producto, SUM(cantidad) AS total_unidades_vendidas
FROM detalle_pedido
GROUP BY codigo_producto
ORDER BY total_unidades_vendidas DESC;

+-----------------+-------------------------+
| codigo_producto | total_unidades_vendidas |
+-----------------+-------------------------+
| PROD005         |                       8 |
| PROD001         |                       5 |
| PROD004         |                       4 |
| PROD002         |                       3 |
| PROD003         |                       3 |
| PROD006         |                       3 |
+-----------------+-------------------------+
```
La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
```
SELECT 
    SUM(cantidad * precio_unitario) AS base_imponible,
    SUM(cantidad * precio_unitario) * 0.21 AS iva,
    SUM(cantidad * precio_unitario) + (SUM(cantidad * precio_unitario) * 0.21) AS total_facturado
FROM detalle_pedido;

+----------------+-------+-----------------+
| base_imponible | iva   | total_facturado |
+----------------+-------+-----------------+
|            395 | 82.95 |          477.95 |
+----------------+-------+-----------------+
```
La misma información que en la pregunta anterior, pero agrupada por
código de producto.
```
SELECT 
    codigo_producto,
    SUM(cantidad * precio_unitario) AS base_imponible,
    SUM(cantidad * precio_unitario) * 0.21 AS iva,
    SUM(cantidad * precio_unitario) + (SUM(cantidad * precio_unitario) * 0.21) AS total_facturado
FROM detalle_pedido
GROUP BY codigo_producto;

+-----------------+----------------+-------+-----------------+
| codigo_producto | base_imponible | iva   | total_facturado |
+-----------------+----------------+-------+-----------------+
| PROD001         |             55 | 11.55 |           66.55 |
| PROD002         |             27 |  5.67 |           32.67 |
| PROD003         |             52 | 10.92 |           62.92 |
| PROD004         |             52 | 10.92 |           62.92 |
| PROD005         |            152 | 31.92 |          183.92 |
| PROD006         |             57 | 11.97 |           68.97 |
+-----------------+----------------+-------+-----------------+
```
Lista las ventas totales de los productos que hayan facturado más de 3000
euros. Se mostrará el nombre, unidades vendidas, total facturado y total
facturado con impuestos (21% IVA).
```
SELECT 
    p.nombre_producto,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS total_facturado,
    SUM(dp.cantidad * dp.precio_unitario) * 0.21 AS total_iva,
    SUM(dp.cantidad * dp.precio_unitario) + (SUM(dp.cantidad * dp.precio_unitario) * 0.21) AS total_facturado_con_iva
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY 
    p.nombre_producto
HAVING 
    total_facturado_con_iva > 3000;
```

```
SELECT 
    p.nombre_producto,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS total_facturado,
    SUM(dp.cantidad * dp.precio_unitario) * 0.21 AS total_iva,
    SUM(dp.cantidad * dp.precio_unitario) + (SUM(dp.cantidad * dp.precio_unitario) * 0.21) AS total_facturado_con_iva
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY 
    p.nombre_producto;

+-----------------+-------------------+-----------------+-----------+-------------------------+
| nombre_producto | unidades_vendidas | total_facturado | total_iva | total_facturado_con_iva |
+-----------------+-------------------+-----------------+-----------+-------------------------+
| Producto 1      |                 5 |              55 |     11.55 |                   66.55 |
| Producto 2      |                 3 |              27 |      5.67 |                   32.67 |
| Producto 3      |                 3 |              52 |     10.92 |                   62.92 |
| Producto 4      |                 4 |              52 |     10.92 |                   62.92 |
| Producto 5      |                 8 |             152 |     31.92 |                  183.92 |
| Producto 6      |                 3 |              57 |     11.97 |                   68.97 |
+-----------------+-------------------+-----------------+-----------+-------------------------+
```
Muestre la suma total de todos los pagos que se realizaron para cada uno
de los años que aparecen en la tabla pagos.
```
SELECT 
    YEAR(fecha_pago) AS año,
    SUM(total) AS total_pagos
FROM 
    pago
GROUP BY 
    YEAR(fecha_pago);
    
+------+-------------+
| año  | total_pagos |
+------+-------------+
| 2024 |         496 |
+------+-------------+
```
Devuelve el nombre del cliente con mayor límite de crédito.
```
SELECT nombre_cliente
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;

+----------------+
| nombre_cliente |
+----------------+
| Sofia          |
+----------------+
```
Devuelve el nombre del producto que tenga el precio de venta más caro.
```
SELECT nombre_producto
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;

+-----------------+
| nombre_producto |
+-----------------+
| Producto 6      |
+-----------------+
```
Devuelve el nombre del producto del que se han vendido más unidades.
(Tenga en cuenta que tendrá que calcular cuál es el número total de
unidades que se han vendido de cada producto a partir de los datos de la
tabla detalle_pedido)
```
SELECT p.nombre_producto
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY dp.codigo_producto
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

+-----------------+
| nombre_producto |
+-----------------+
| Producto 5      |
+-----------------+
```
4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
realizado. (Sin utilizar INNER JOIN).
```
SELECT nombre_cliente, limite_credito
FROM cliente
WHERE limite_credito > (
    SELECT IFNULL(SUM(total), 0)
    FROM pago
    WHERE pago.id_cliente = cliente.id_cliente
);

+----------------+----------------+
| nombre_cliente | limite_credito |
+----------------+----------------+
| Pedro          |           1000 |
| Ana            |           1500 |
| Javier         |           2000 |
| Laura          |           1200 |
| Carlos         |           1800 |
| Sofia          |           2200 |
+----------------+----------------+
```

5. Devuelve el producto que más unidades tiene en stock.
6. Devuelve el producto que menos unidades tiene en stock.
7. Devuelve el nombre, los apellidos y el email de los empleados que están a
cargo de Alberto Soria.
Subconsultas con ALL y ANY
8. Devuelve el nombre del cliente con mayor límite de crédito.
9. Devuelve el nombre del producto que tenga el precio de venta más caro.
10. Devuelve el producto que menos unidades tiene en stock.
Subconsultas con IN y NOT IN
11. Devuelve el nombre, apellido1 y cargo de los empleados que no
representen a ningún cliente.
12. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.
13. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.
14. Devuelve un listado de los productos que nunca han aparecido en un
pedido.
15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.
16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.
17. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.
18.

Subconsultas con EXISTS y NOT EXISTS
18. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.
19. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.
20. Devuelve un listado de los productos que nunca han aparecido en un
pedido.
21. Devuelve un listado de los productos que han aparecido en un pedido
alguna vez.
Subconsultas correlacionadas
Consultas variadas
1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
han realizado ningún pedido.
2. Devuelve un listado con los nombres de los clientes y el total pagado por
cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
realizado ningún pago.
3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
ordenados alfabéticamente de menor a mayor.
4. Devuelve el nombre del cliente, el nombre y primer apellido de su
representante de ventas y el número de teléfono de la oficina del
representante de ventas, de aquellos clientes que no hayan realizado ningún
pago.
5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
nombre y primer apellido de su representante de ventas y la ciudad donde
está su oficina.
6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.

7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
número de empleados que tiene.
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
2. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

```
SELECT 
    c.nombre_ciudad AS ciudad,
    nt.numero_telefono AS telefono
FROM 
    ciudad c
INNER JOIN 
    region r ON c.id_region = r.id_region
INNER JOIN 
    pais p ON r.id_pais = p.id_pais
INNER JOIN 
    oficina o ON c.id_ciudad = o.id_ciudad
INNER JOIN 
    numero_telefono nt ON o.id_oficina = nt.id_oficina
WHERE 
    p.nombre_pais = 'España';
```
