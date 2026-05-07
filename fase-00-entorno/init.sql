-- init.sql
-- Este archivo crea la base de datos del curso
-- Los -- son comentarios en SQL
-- Crear un schema (es como una carpeta dentro de la base de datos)
-- Usamos "tienda" para agrupar todas las tablas del curso
CREATE SCHEMA IF NOT EXISTS tienda;
-- "IF NOT EXISTS" evita un error si el schema ya existe
-- TABLA CLIENTES
CREATE TABLE tienda.clientes (
 cliente_id SERIAL PRIMARY KEY,
 -- SERIAL: numero que se incrementa automaticamente (1, 2, 3, ...)
 -- PRIMARY KEY: identifica unicamente cada fila, no puede repetirse
 nombre VARCHAR(100) NOT NULL,
 -- VARCHAR(100): texto de hasta 100 caracteres
 -- NOT NULL: obligatorio, no puede estar vacio
 email VARCHAR(150) UNIQUE NOT NULL,
 -- UNIQUE: no pueden haber dos clientes con el mismo email
 ciudad VARCHAR(80),
 -- Sin NOT NULL: puede estar vacio (NULL)
 pais VARCHAR(60) DEFAULT 'Peru',
 -- DEFAULT 'Peru': si no se especifica, usa Peru
 fecha_reg DATE DEFAULT CURRENT_DATE,
 -- CURRENT_DATE: la fecha de hoy automaticamente
 activo BOOLEAN DEFAULT TRUE
 -- BOOLEAN: verdadero o falso
 -- Usamos "activo" para hacer "soft delete" — nunca borramos datos reales
);
-- TABLA PRODUCTOS
CREATE TABLE tienda.productos (
 producto_id SERIAL PRIMARY KEY,
 nombre VARCHAR(150) NOT NULL,
 categoria VARCHAR(80),
 precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
 -- DECIMAL(10,2): numero con hasta 10 digitos y 2 decimales (ej: 9999999.99)
 -- CHECK (precio > 0): el precio debe ser mayor a cero
 stock INT DEFAULT 0 CHECK (stock >= 0),
 activo BOOLEAN DEFAULT TRUE
);
-- TABLA PEDIDOS
CREATE TABLE tienda.pedidos (
 pedido_id SERIAL PRIMARY KEY,
 cliente_id INT REFERENCES tienda.clientes(cliente_id),
 -- REFERENCES: clave foranea — conecta con la tabla clientes
 -- Garantiza que no puedes crear un pedido para un cliente que no existe
 fecha TIMESTAMP DEFAULT NOW(),
 -- TIMESTAMP: fecha y hora. NOW() = este momento exacto
 estado VARCHAR(30) DEFAULT 'pendiente',
 total DECIMAL(12,2)
);
-- TABLA DETALLE DE PEDIDOS
CREATE TABLE tienda.detalle_pedidos (
 detalle_id SERIAL PRIMARY KEY,
 pedido_id INT REFERENCES tienda.pedidos(pedido_id),
 producto_id INT REFERENCES tienda.productos(producto_id),
 cantidad INT NOT NULL CHECK (cantidad > 0),
 precio_unit DECIMAL(10,2) NOT NULL
);
-- DATOS DE MUESTRA
-- INSERT INTO: insertar filas en la tabla
INSERT INTO tienda.clientes (nombre, email, ciudad, pais) VALUES
('Ana Torres', 'ana@email.com', 'Lima', 'Peru'),
('Luis Garcia', 'luis@email.com', 'Bogota', 'Colombia'),
('Maria Lopez', 'maria@email.com', 'Madrid', 'Espana'),
('Carlos Ruiz', 'carlos@email.com', 'Lima', 'Peru'),
('Sofia Mendez', 'sofia@email.com', 'Buenos Aires', 'Argentina'),
('Diego Vargas', 'diego@email.com', 'Lima', 'Peru'),
('Paula Castro', 'paula@email.com', 'Medellin', 'Colombia'),
('Juan Perez', 'juan@email.com', 'Lima', 'Peru');
INSERT INTO tienda.productos (nombre, categoria, precio, stock) VALUES
('Laptop Pro 15', 'Electronica', 2500.00, 15),
('Mouse Inalambrico', 'Electronica', 45.00, 80),
('Teclado Mecanico', 'Electronica', 120.00, 40),
('Monitor 27 4K', 'Electronica', 650.00, 20),
('Curso Python Online', 'Digital', 89.00, 999),
('Curso SQL Avanzado', 'Digital', 75.00, 999),
('Silla Ergonomica', 'Muebles', 380.00, 25),
('Escritorio Standing', 'Muebles', 520.00, 10),
('Auriculares BT', 'Electronica', 150.00, 60),
('Webcam HD 1080p', 'Electronica', 95.00, 35);
INSERT INTO tienda.pedidos (cliente_id, fecha, estado, total) VALUES
(1, '2024-01-15 10:30:00', 'completado', 2545.00),
(2, '2024-01-20 14:00:00', 'completado', 164.00),
(1, '2024-02-01 09:00:00', 'completado', 650.00),
(3, '2024-02-10 16:30:00', 'enviado', 89.00),
(4, '2024-02-15 11:00:00', 'completado', 215.00),
(5, '2024-03-01 08:00:00', 'completado', 2620.00),
(1, '2024-03-10 13:00:00', 'pendiente', 150.00),
(6, '2024-03-15 15:30:00', 'completado', 75.00),
(2, '2024-04-01 10:00:00', 'cancelado', 520.00),
(7, '2024-04-10 12:00:00', 'completado', 245.00);
INSERT INTO tienda.detalle_pedidos (pedido_id, producto_id, cantidad, precio_unit) VALUES
(1, 1, 1, 2500.00), (1, 2, 1, 45.00),
(2, 3, 1, 120.00), (2, 2, 1, 44.00),
(3, 4, 1, 650.00), (4, 5, 1, 89.00),
(5, 2, 1, 45.00), (5, 3, 1, 120.00), (5, 9, 1, 150.00),
(6, 1, 1, 2500.00), (6,10, 1, 95.00), (6, 5, 1, 25.00),
(7, 9, 1, 150.00), (8, 6, 1, 75.00), (9, 8, 1, 520.00),
(10,2, 2, 45.00), (10,10, 1, 95.00), (10,6, 1, 60.00);

