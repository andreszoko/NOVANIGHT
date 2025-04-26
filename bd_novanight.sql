create database db_novanight;
use db_novanight

CREATE TABLE factura (
    id_factura INT PRIMARY KEY,
    tipo_factura VARCHAR(20) NOT NULL,
    id_cliente int NOT NULL,
	id_empleado int not null,
    id_producto int not null,
	vendedor_nit VARCHAR(20) NOT NULL,
    adquirente_apellidos_nombre VARCHAR(100) NOT NULL,
    adquirente_nit VARCHAR(20) NOT NULL,
    iva_pagado DECIMAL(10, 2) NOT NULL,
    numero_consecutivo INT NOT NULL,
    fecha_expedicion DATE NOT NULL,
    descripcion_articulos_servicios VARCHAR(200) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    impresor_nombre VARCHAR(100) NOT NULL,
    impresor_nit VARCHAR(20) NOT NULL,
    retenedor_iva BIT NOT NULL);
    
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    dni INT,
    nombre CHAR(60),
    direccion CHAR(60),
    telefono INT,
    fecha_nacimiento DATE
);

CREATE TABLE producto (
    id_producto INT PRIMARY KEY,
    codigo_producto INT,
    nombre CHAR(60),
    costo_unitario FLOAT,
    id_proveedor INT
);

CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY,
    dni INT,
    nombre CHAR(60),
    direccion CHAR(60),
    telefono INT,
    ciudad CHAR(60),
    tipo_producto CHAR(60)
);

CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY,
    nif INT,
    nombre VARCHAR(60),
    cargo VARCHAR(60),
    direccion VARCHAR(60),
    telefono INT
);

CREATE TABLE ventas (
    idventas INT PRIMARY KEY,
    cantidad INT,
    descuento INT,
    total_venta DECIMAL(10, 2),
    fecha DATE,
	id_empleado int,
	id_cliente int,
	id_producto int
);




CREATE PROCEDURE insertarcliente
    @id_cliente INT,
    @dni INT,
    @nombre CHAR(60),
    @direccion CHAR(60),
    @telefono INT,
    @fecha_nacimiento DATE
AS
BEGIN
    INSERT INTO clientes (id_cliente, dni, nombre, direccion, telefono, fecha_nacimiento)
    VALUES (@id_cliente, @dni, @nombre, @direccion, @telefono, @fecha_nacimiento)
END
exec insertarcliente 01,1000,'samuel','sancipriano',3023315,'1990-05-15'
EXEC insertarcliente  101, 123456789, 'Juan Pérez', 'Calle Principal', 5551234567, '1990-05-15'
CREATE PROCEDURE insertarProducto
    @id_producto INT,
    @codigo_producto INT,
    @nombre CHAR(60),
    @costo_unitario FLOAT,
    @id_proveedor INT
AS
BEGIN
    INSERT INTO producto (id_producto, codigo_producto, nombre, costo_unitario, id_proveedor)
    VALUES (@id_producto, @codigo_producto, @nombre, @costo_unitario, @id_proveedor)
END

CREATE PROCEDURE InsertarProveedor
    @id_proveedor INT,
    @dni INT,
    @nombre CHAR(60),
    @direccion CHAR(60),
    @telefono INT,
    @ciudad CHAR(60),
    @tipo_producto CHAR(60)
AS
BEGIN
    INSERT INTO proveedor (id_proveedor, dni, nombre, direccion, telefono, ciudad, tipo_producto)
    VALUES (@id_proveedor, @dni, @nombre, @direccion, @telefono, @ciudad, @tipo_producto)
END

CREATE PROCEDURE InsertarEmpleado
    @id_empleado INT,
    @nif INT,
    @nombre VARCHAR(60),
    @cargo VARCHAR(60),
    @direccion VARCHAR(60),
    @telefono INT
AS
BEGIN
    INSERT INTO empleado (id_empleado, nif, nombre, cargo, direccion, telefono)
    VALUES (@id_empleado, @nif, @nombre, @cargo, @direccion, @telefono)
END

CREATE PROCEDURE InsertarVenta
    @idventas INT,
    @cantidad INT,
    @descuento INT,
    @total_venta DECIMAL(10, 2),
    @fecha DATE,
    @id_empleado INT,
    @id_cliente INT,
    @id_producto INT
AS
BEGIN
    INSERT INTO ventas (idventas, cantidad, descuento, total_venta, fecha, id_empleado, id_cliente, id_producto)
    VALUES (@idventas, @cantidad, @descuento, @total_venta, @fecha, @id_empleado, @id_cliente, @id_producto)
END

EXEC insertarcliente  1, 123456789, 'Juan Pérez', 'Calle Principal', 5551234567, '1990-05-15'
EXEC insertarcliente 2, 2000, 'Laura', 'Calle Principal 789', 5558889, '1993-06-25'
EXEC insertarcliente 3,3000, 'Laura', 'Calle Principal 789', 89999, '1993-06-25'

EXEC InsertarProveedor 1, 123456789, 'Proveedor A', 'Calle Principal 123', 55517, 'Ciudad A', 'Ropa'
EXEC InsertarProveedor 3, 456789123, 'Proveedor C', 'Calle Secundaria 789', 55543, 'Ciudad C', 'Muebles'
EXEC InsertarEmpleado 1, 123456789, 'Juan Pérez', 'Gerente', 'Calle Principal 123', 34567

EXEC InsertarEmpleado 3, 456789123, 'Carlos Ramírez', 'Vendedor', 'Calle Secundaria 789', 21098
EXEC InsertarVenta 1, 5, 10, 500.00, '2023-05-10', 1, 1, 1
EXEC InsertarVenta 2, 3, 5, 250.00, '2023-05-10', 2, 3, 2

CREATE PROCEDURE sp_VerEmpleados
AS
BEGIN
    SELECT *
    FROM empleado;
END
 exec sp_VerEmpleados

 CREATE PROCEDURE sp_ProveedorPorDireccion
    @letra CHAR(1)
AS
BEGIN
    SELECT *
    FROM proveedor
    WHERE direccion LIKE @letra + '%';
END
exec sp_ProveedorPorDireccion

drop procedure sp_DireccionPorLetra

CREATE PROCEDURE sp_DireccionPorLetra
    @direccion VARCHAR(60)
AS
BEGIN
       SELECT direccion
   FROM proveedor

    WHERE direccion LIKE  '%';
END
exec sp_DireccionPorLetra 'c'
drop procedure sp_DireccionPorLetra

CREATE PROCEDURE sp_BorrarEmpleado
    @id_empleado INT
AS
    BEGIN
        DELETE FROM empleado WHERE id_empleado = @id_empleado;
       
    END

	exec sp_BorrarEmpleado 1
	ALTER TABLE producto
ADD CONSTRAINT FK_producto_proveedor
FOREIGN KEY (id_proveedor)
REFERENCES proveedor (id_proveedor);


-- Agregar clave externa en la tabla factura para enlazar con la tabla empleado
ALTER TABLE factura
ADD CONSTRAINT FK_factura_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado (id_empleado);

-- Agregar clave externa en la tabla factura para enlazar con la tabla cliente
ALTER TABLE factura
ADD CONSTRAINT FK_factura_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes (id_cliente);

-- Agregar clave externa en la tabla factura para enlazar con la tabla producto
ALTER TABLE factura
ADD CONSTRAINT FK_factura_producto
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto);

SELECT v.idventas, c.nombre AS cliente, p.nombre AS producto, e.nombre AS empleado
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN producto p ON v.id_producto = p.id_producto
INNER JOIN empleado e ON v.id_empleado = e.id_empleado;
