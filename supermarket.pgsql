--CREACION DE BASES DE DATOS
CREATE DATABASE supermarket

--CREACION DE TABLAS
CREATE TABLE clientes(
id INT PRIMARY KEY,
nombre VARCHAR(200),
edad INT
)

CREATE TABLE pedidos (
id INT PRIMARY KEY,
cliente_id INT,
fecha DATE,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES clientes (id)
)

CREATE TABLE productos (
id INT PRIMARY KEY,
nombre_producto VARCHAR (500),
precio DECIMAL(10,2)
)


CREATE TABLE detalle_pedidos(
id INT PRIMARY KEY,
pedido_id INT,
producto_id INT,
cantidad INT,
FOREIGN KEY (pedido_id) REFERENCES pedidos (id),
FOREIGN KEY (producto_id) REFERENCES productos (id)
)
--ESCTRUCTURA DE RELACIONES FOREIGN KEY (CAMPO DE LA TABLA) REFERENCES TABLA (REFERENCIA DE LA TABLA)

--FIN CREACION DE TABLAS

-- ESTRUCTURA PARA INSERTAR DATOS A UNA TABLA

INSERT INTO clientes (id, nombre, edad) VALUES 
(1,'Miguel',30),(2,'Damian',7),(3,'David',1),
(4,'Andrea',27),(5,'Geraldine',20)

INSERT INTO clientes (id, nombre, edad) VALUES 
(6,'Bethy',43)

SELECT * FROM clientes

INSERT INTO productos (id, nombre_producto, precio) VALUES 
(1,'Colgate',6500),(2,'Jabon',2500),(3,'Cepillo',3500),
(4,'Enjuague',29000),(5,'Shampoo',18000)

SELECT * FROM productos

INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES 
(1,1,NOW(),55000),(2,2,NOW(),80000),(3,2,NOW(),95000),
(4,4,NOW(),20000),(5,3,NOW(),69000)

INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES 
(6,1,NOW(),55000),(7,2,NOW(),80000),(8,2,NOW(),95000),
(9,4,NOW(),20000),(10,3,NOW(),69000)

SELECT * FROM pedidos ORDER BY total DESC

INSERT INTO detalle_pedidos (id, pedido_id, producto_id, cantidad) VALUES 
(1,1,1,5),(2,2,3,5),(3,2,4,5),
(4,4,1,5),(5,3,5,5)

SELECT * FROM detalle_pedidos

--CAMBIAR EL NOMBRE DE UNA COLUMNA
ALTER TABLE productos RENAME nombre_prodcuto TO nombre_producto 

--TRUNCATE TABLE productos

SELECT c.nombre FROM clientes AS c JOIN pedidos AS p ON c.id = p.cliente_id

-- Ejercicio 1: Muestra el nombre del cliente y el total de sus pedidos.

SELECT c.nombre, SUM(p.total) AS total_pedidos
FROM clientes AS c
JOIN pedidos AS p ON c.id = p.cliente_id
GROUP BY c.nombre;

--2: Ejercicio 2: Muestra el nombre del producto y la cantidad total de veces que se ha pedido.

SELECT p.nombre_producto, SUM(dp.cantidad) AS total_cantidad
FROM productos AS P
JOIN detalle_pedidos AS dp
ON p.id = dp.producto_id
GROUP BY
p.nombre_producto

-- Ejercicio 3: Muestra el nombre del cliente, su edad y cuenta el número de pedidos que ha realizado.

SELECT c.nombre, c.edad, SUM(p.total) AS total_pedidos
FROM clientes AS c
JOIN pedidos AS p ON c.id= p.cliente_id
GROUP BY
c.nombre, c.edad


--Ejercicio 4: Muestra el nombre del cliente 
--y el promedio del total de sus pedidos

SELECT c.nombre, AVG(p.total) AS total_promedio
FROM clientes AS c
JOIN pedidos AS p ON c.id = p.cliente_id
GROUP BY c.nombre
ORDER BY total_promedio DESC 

--Ejercicio 5: Muestra el nombre del producto y la cantidad total de veces 
--que se ha pedido, filtrando los productos que se han pedido más de 10 
--veces.
SELECT p.nombre_producto, SUM(dp.cantidad) AS cantidad_total_pedidos
FROM productos AS p
JOIN detalle_pedidos AS dp ON p.id = dp.producto_id
GROUP BY p.nombre_producto
HAVING cantidad_total_pedidos > 1

--Ejercicio 6: Consultar clientes sin pedidos

SELECT *
FROM clientes AS c
JOIN pedidos AS p ON c.id = p.cliente_id
-- WHERE p.id = null
