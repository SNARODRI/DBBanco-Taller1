CREATE TABLE Clientes(
	cliente_id INTEGER PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento TIMESTAMP NOT NULL,
    estado VARCHAR (10) NOT NULL CHECK (estado IN ('ACTIVO','INACTIVO'))
);

CREATE TABLE Cuentas(
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES CLientes(cliente_id) NOT NULL,
    numero_cuenta VARCHAR (20) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR (10) NOT NULL CHECK (tipo_cuenta IN ('CORRIENTE','AHORRO')),
    saldo NUMERIC (15, 2) NOT NULL,
    fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR (10) NOT NULL CHECK (estado IN ('ACTIVA','CERRADA'))
);

CREATE TABLE Transacciones(
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id VARCHAR (20) REFERENCES Cuentas(numero_cuenta) NOT NULL,
    tipo_transaccion VARCHAR (15) CHECK (tipo_transaccion IN ('DEPOSITO','RETIRO','TRANSFERENCIA'))NOT NULL,
    monto NUMERIC (15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR (100) 
);

CREATE TABLE Sucursales(
    sucursal_id INTEGER PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL,
    direccion VARCHAR (100),
    telefono VARCHAR (20)
);

CREATE TABLE Empleados(
    empleado_id INTEGER PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_contratacion TIMESTAMP NOT NULL,
    posicion VARCHAR (50) NOT NULL,
    salario NUMERIC (15, 2) NOT NULL,
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL
);

CREATE TABLE Tipos_Productos(
    tipo_producto_id INTEGER PRIMARY KEY,
    descripcion VARCHAR (100) NOT NULL,
    estado VARCHAR (12) NOT NULL CHECK (estado IN ('ACTIVO','INACTIVO'))
);

CREATE TABLE Productos(
    producto_id VARCHAR (25) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto INTEGER REFERENCES Tipos_Productos(tipo_producto_id) NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    tasa_interes NUMERIC (6, 4) NOT NULL
);

CREATE TABLE Prestamos(
    prestamos_id SERIAL PRIMARY KEY,
    cuenta_id VARCHAR (20) REFERENCES Cuentas(numero_cuenta) NOT NULL,
    monto NUMERIC (15, 2) NOT NULL,
    tasa_interes NUMERIC (6, 4) NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL,
    estado VARCHAR(12) NOT NULL CHECK (estado IN ('ACTIVO','BLOQUEADA'))
);

CREATE TABLE Cliente_Productos(
    cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
    producto_id VARCHAR REFERENCES Productos(producto_id) NOT NULL,
    fecha_adquisicion TIMESTAMP NOT NULL
);

INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
Values (1045869521, 'Pedro', 'Perez', 'Carrera 6 # 7 - 58', '3585247962', 'pedro_perez@correo_electronico.com', '1990-05-24', 'ACTIVO'),
       (1025487632,'Juan', 'Diaz', 'Calle 9 # 6 - 36', '3458796524', 'juan_diaz@correo_electronico.com', '1989-06-23', 'ACTIVO'),
       (1150264527,'Daniel', 'Duarte', 'Diagonal 1 # 20 - 45', '3205487621', 'daniel_duarte@correo_electronico.com', '1987-05-23', 'ACTIVO'),
       (1254879562,'Leidy', 'Draco', 'Manzan1 Casa3', '25684521125', 'leidy_draco@correo_electronico.com', '1995-07-10', 'ACTIVO'),
       (1522487947,'Diana', 'Cardozo', 'Manzan1 Casa3', '25684521125', 'diana_cardozo@correo_electronico.com', '1995-07-10', 'ACTIVO');

INSERT INTO Cuentas(cliente_id, numero_cuenta, tipo_cuenta, saldo, estado)
Values(1045869521, '555-777-333-222', 'CORRIENTE', 0, 'ACTIVA'),
      (1045869521, '555-888-999-111', 'AHORRO', 0, 'ACTIVA'),
      (1025487632, '555-222-111-999', 'AHORRO', 0, 'ACTIVA'),
      (1025487632, '555-333-222-000', 'CORRIENTE', 0, 'ACTIVA'),
      (1150264527, '111-777-555-222', 'CORRIENTE', 0, 'CERRADA'),
      (1150264527, '111-444-333-222', 'AHORRO', 0, 'ACTIVA'),
      (1254879562, '333-555-777-444', 'AHORRO', 0, 'ACTIVA'),
      (1254879562, '000-333-444-444', 'AHORRO', 0, 'CERRADA');

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto,  descripcion)
Values('555-777-333-222', 'DEPOSITO', 100000, 'SUCURSAL DEL SOL'),
      ('555-777-333-222', 'RETIRO', 50000, 'SUCURSAL AMERICAS'),
      ('555-888-999-111', 'DEPOSITO', 150000, 'SUCURSAL LAS VEGAS'),
      ('555-888-999-111', 'DEPOSITO', 200000, 'SUCURSAL LAS VEGAS'),
      ('555-222-111-999', 'DEPOSITO', 300000, 'SUCURSAL DEL ACERO'),
      ('555-222-111-999', 'RETIRO', 20000, 'SUCURSAL PRINCIPAL'),
      ('555-333-222-000', 'DEPOSITO', 350000, 'SUCURSAL DEL SOL'),
      ('555-333-222-000', 'TRANSFERENCIA', 35000, 'SUCURSAL DEL SOL'),
      ('111-444-333-222', 'DEPOSITO', 450000, 'SUCURSAL PRINCIPAL'),
      ('111-444-333-222', 'TRANSFERENCIA', 50000, 'SUCURSAL PRINCIPAL'),
      ('333-555-777-444', 'DEPOSITO', 500000, 'SUCURSAL PRINCIPAL'),
      ('000-333-444-444', 'DEPOSITO', 650000, 'SUCURSAL PRINCIPAL'),
      ('000-333-444-444', 'RETIRO', 250000, 'SUCURSAL PRINCIPAL');

INSERT INTO Sucursales (sucursal_id, nombre, direccion, telefono)
Values(1, 'SUCURSAL DEL SOL', 'Avenida 1 # 10 - 05', '6015487624'),
      (2, 'SUCURSAL AMERICAS', 'Diagonal 3 Transversal 2', '604215876'),
      (3, 'SUCURSAL DEL ACERO', 'Carrera 5 # 3 -45', '6084568921'),
      (4, 'SUCURSAL PRINCIPAL', 'Calle 30 # 37 - 35', '6045897561'),
      (5, 'SUCURSAL LAS VEGAS', 'Barrio Colombia', '6045689421');

INSERT INTO Empleados (empleado_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
Values (1548762001, 'Augustin', 'Codazi', 'Carrera 6 # 7 - 58', '3585247962', 'paugustin_codazi@banco.com', '2020-05-24', 'Asistente',1500000, 1),
       (1567912354, 'Antonio', 'Pedraza', 'Calle 9 # 6 - 36', '3458796524', 'antoni_pedraza@banco.com', '2021-06-23', 'Cordianador',3500000, 2),
       (1024876521, 'Vicente', 'Anibal', 'Diagonal 1 # 20 - 45', '3205487621', 'vicente_anibal@banco.com', '2022-05-23', 'Gerente',5500000, 3),
       (1154796324, 'Antoni', 'Lopez', 'Manzan1 Casa3', '25684521125', 'antoni_lopez@banco.com', '2023-07-10', 'Analista',3500000, 1),
       (1548623789, 'Diego', 'Cuadril', 'Manzan1 Casa3', '25684521125', 'diego_cuadril@banco.com', '2024-07-10', 'Profesional',2500000, 2);

INSERT INTO Tipos_Productos(tipo_producto_id, descripcion, estado)
Values(1, 'CREDITO ROTATIVO', 'ACTIVO'),
      (2, 'CREDITO HIPOTECARIO', 'ACTIVO'),
      (3, 'CREDITO EDUCATIVO', 'ACTIVO'),
      (4, 'LIBRE INVERSION', 'ACTIVO'),
      (5, 'CREDITO VEHICULO', 'ACTIVO'),
      (6, 'LEASING HABITACIONAL', 'ACTIVO'),
      (7, 'COMPRA DE CARTERA', 'ACTIVO');

INSERT INTO Productos (producto_id, nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES('TJ1', 'TARJETA DE CREDITO', 1, 'ROTATIVO', 15.00),
      ('TJ2', 'TARJETA DE CREDITO JOVEN', 1, 'ROTATIVO', 14.00),
      ('PR1', 'PRESTAMO', 4, 'CREDITO', 11.00),
      ('CV1', 'PRESTAMO VIVIENDA', 2, 'VIVIENDA', 11.00),
      ('CC1', 'COMPRA CARTERA', 7, 'CARTERA', 11.00),
      ('CV2', 'COMPRA VEHICULO', 5, 'CARTERA', 11.00);

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
Values ('555-777-333-222', 15000000, 11.00, '2024-05-03', '2029-05-03','ACTIVO'),
       ('555-888-999-111', 30000000, 11.00, '2023-04-03', '2030-04-03','ACTIVO'),
       ('555-222-111-999', 20000000, 11.00, '2021-07-17', '2025-07-17','ACTIVO'),
       ('555-333-222-000', 50000000, 11.00, '2022-08-23', '2029-08-23','ACTIVO'),
       ('111-444-333-222', 80000000, 11.00, '2025-03-23', '2035-03-23','ACTIVO');

INSERT INTO Cliente_Productos(cliente_id, producto_id, fecha_adquisicion)
Values  (1045869521, 'TJ1', '2024-05-03'),
        (1025487632, 'TJ2', '2024-04-15'),
        (1150264527, 'PR1', '2023-08-30'),
        (1254879562, 'CV2', '2020-06-23'),
        (1254879562, 'CV1', '2025-07-17'),
        (1522487947, 'CC1', '2024-03-05');