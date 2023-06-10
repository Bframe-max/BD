/* Proyecto para la clase de base de datos
creacion de una base de datos para una pizzeria*/

CREATE DATABASE Pizzeria
USE Pizzeria

CREATE TABLE Clientes (
  Id_Cliente INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  PNC NVARCHAR(30) NOT NULL,
  SNC NVARCHAR(30),
  PAC NVARCHAR(30) NOT NULL,
  SAC NVARCHAR(30),
  cedula_C NVARCHAR(15) CHECK (cedula_C LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
  Tel_C NVARCHAR(8) CHECK (Tel_C LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  Dir_C NVARCHAR(100),
  Email NVARCHAR(100)
  Id_Municipio int,
  foreign key (Id_Municipio) references Municipios (Id_Municipio)
)

CREATE TABLE Empleado (
  Id_Empleado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  PN_Empleado NVARCHAR(30) NOT NULL,
  SN_Empleado NVARCHAR(30),
  PA_Empleado NVARCHAR(30) NOT NULL,
  SA_Empleado NVARCHAR(30),
  cedula_Empleado NVARCHAR(15) CHECK (cedula_Empleado LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
  Tel_E NVARCHAR(8) CHECK (Tel_E LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  Email NVARCHAR(100),
  FechaContratacion DATE,
  Salario DECIMAL(10, 2),
  HorasTrabajo INT,
  FechaNacimiento DATE,
  EstadoCivil VARCHAR(20),
  Genero VARCHAR(10),
  NumeroCuentaBancaria VARCHAR(20)
)

CREATE TABLE PuestoEmpleado (
  Id_Puesto INT PRIMARY KEY NOT NULL,
  Puesto NVARCHAR(50)
)

CREATE TABLE Empleado_Puesto (
  Id_Empleado_Puesto int,
  Id_Empleado INT,
  Id_Puesto INT,
  FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado),
  FOREIGN KEY (Id_Puesto) REFERENCES PuestoEmpleado(Id_Puesto),
  CONSTRAINT UQ_Id_Empleado_Puesto UNIQUE (Id_Empleado_Puesto)
)

INSERT INTO PuestoEmpleado (Id_Puesto, Puesto) VALUES
(1, 'Cocinero'),
(2, 'Repartidor'),
(3, 'Supervisor'),
(4, 'Mercadeo')

INSERT INTO Empleado_Puesto (Id_Empleado, Id_Puesto) VALUES
(DEFAULT, 1), -- Juan Perez es cocinero
(DEFAULT, 2), -- Maria Gomez es repartidora
(DEFAULT, 3), -- Pedro Lopez es supervisor
(DEFAULT, 4) -- Laura Torres está en mercadeo

CREATE TABLE Topping (
  Id_Topping INT identity(1,1) primary key not null,
  Ingredientes_Pizza NVARCHAR(60) NOT NULL,
  Est_Topping INT NOT NULL DEFAULT 1
  IDMateriaPrima INT,
  FOREIGN KEY (IDMateriaPrima) REFERENCES MateriaPrima(IDMateriaPrima),
)

CREATE TABLE Pizzas (
  Id_Pizza INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  precio_Pizza MONEY NOT NULL,
  Nombre_Pizza nvarchar(30) not null,
  slice INT NOT NULL,
  Id_Topping INT,
  Descripcion NVARCHAR(50),
  FOREIGN KEY (Id_Topping) REFERENCES Topping(Id_Topping)
)

CREATE TABLE Extras (
  Id_Extra INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Id_Topping INT,
  FOREIGN KEY (Id_Topping) REFERENCES Topping(Id_Topping)
)

CREATE TABLE MateriaPrima (
  IDMateriaPrima INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Nombre VARCHAR(50),
  Stock INT,
  UnidadMedida VARCHAR(20)
)

CREATE TABLE Pedido (
  Id_Pedido INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Num_Pedido INT,
  Fecha_Pedido DATETIME DEFAULT GETDATE() NOT NULL,
  Id_Cliente INT not null,
  FOREIGN KEY (Id_Cliente) REFERENCES Clientes(Id_Cliente),
  Id_Pizza INT not null,
  FOREIGN KEY (Id_Pizza) REFERENCES Pizzas(Id_Pizza),
  Id_Departamento int not null,
  foreign key (Id_Departamento) references Departamentos (Id_Departamento),
  Id_Municipio int not null,
  foreign key (Id_Municipio) references Municipios (Id_Municipio),
  Dir_P nvarchar(100) not null
)

CREATE TABLE Pago (
  Id_Pago INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Id_Pedido INT,
  ID_Cliente INT,
  Metodo_pago NVARCHAR(20) not null,
  FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido),
  FOREIGN KEY (ID_Cliente) REFERENCES Clientes(Id_Cliente)
)


CREATE TABLE DetallePedido (
  Id_DetalleP INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Id_Pedido INT not null,
  Id_Pizza INT not null,
  Id_Extras INT null,
  Id_Pago INT not null,
  Cantidad INT not null,
  PrecioUnitario MONEY not null,
  Descuento MONEY,
  Subtotal MONEY,
  CostoEnvio MONEY,
  FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido),
  FOREIGN KEY (Id_Extras) REFERENCES Extras(Id_Extra),
  FOREIGN KEY (Id_Pago) REFERENCES Pago(Id_Pago),
  FOREIGN KEY (Id_Pizza) REFERENCES Pizzas(Id_Pizza)
  Id_Municipio int not null,
  foreign key (Id_Municipio) references Municipios(Id_Municipio)
)

CREATE TABLE Entrega (
  ID_Pedido INT not null,
  Estado NVARCHAR(20),
  FechaHoraEntrega DATETIME DEFAULT GETDATE(),
  Dir_Entrega NVARCHAR(50) NOT NULL,
  Id_Empleado INT not null,
  Id_Cliente INT not null,
  Tipo_Entrega NVARCHAR(20),
  FOREIGN KEY (ID_Pedido) REFERENCES Pedido(Id_Pedido),
  FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado),
  FOREIGN KEY (Id_Cliente) REFERENCES Clientes(Id_Cliente)
)

create table Departamentos (
  Id_Departamento int identity(1,1) primary key,
  ND nvarchar(30) not null
  )

create table Municipios (
  Id_Municipio int identity(1,1) primary key,
  NM nvarchar(30) not null,
  Id_departamento int,
  foreign key (Id_Departamento) references Departamentos(Id_Departamento)
  )
  
CREATE TABLE Proveedores (
  Id_Proveedor INT IDENTITY(1,1) PRIMARY KEY,
  Nombre NVARCHAR(50) NOT NULL,
  Direccion NVARCHAR(100),
  Telefono NVARCHAR(20),
  Email NVARCHAR(50)
)

CREATE TABLE Pdts_Suministrados (
  Id_Producto INT IDENTITY(1,1) PRIMARY KEY,
  Nombre NVARCHAR(50) NOT NULL,
  Precio MONEY NOT NULL,
  Id_Proveedor INT,
  FOREIGN KEY (Id_Proveedor) REFERENCES Proveedores(Id_Proveedor)
)



---------------------------------
/* Procedimiento de insercion */
-------------------------------
CREATE PROCEDURE InsertarCliente
  @PNC NVARCHAR(30),
  @SNC NVARCHAR(30),
  @PAC NVARCHAR(30),
  @SAC NVARCHAR(30),
  @cedula_C NVARCHAR(15),
  @Tel_C NVARCHAR(8),
  @Dir_C NVARCHAR(100),
  @Email NVARCHAR(100),
  @Id_Municipio INT
AS
BEGIN
  SET NOCOUNT ON

  -- Verificar si cedula_C ya existe
  IF EXISTS(SELECT 1 FROM Clientes WHERE cedula_C = @cedula_C)
  BEGIN
    PRINT 'Cédula ya registrada'
    RETURN
  END

  -- Verificar que las columnas no estén en blanco
  IF @PNC = '' OR @SNC = '' OR @PAC = '' OR @cedula_C = '' OR @Dir_C = ''
  BEGIN
    PRINT 'No pueden quedar en blanco'
    RETURN
  END

  -- Verificar si el municipio existe
  IF NOT EXISTS(SELECT 1 FROM Municipios WHERE Id_Municipio = @Id_Municipio)
  BEGIN
    PRINT 'Municipio no existe'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Clientes (PNC, SNC, PAC, SAC, cedula_C, Tel_C, Dir_C, Email, Id_Municipio)
  VALUES (@PNC, @SNC, @PAC, @SAC, @cedula_C, @Tel_C, @Dir_C, @Email, @Id_Municipio)

  PRINT 'Datos insertados correctamente'
END


/* Procedimiento Insercion */
-----------------------------
CREATE PROCEDURE InsertarEmpleado
  @PN_Empleado NVARCHAR(30),
  @SN_Empleado NVARCHAR(30),
  @PA_Empleado NVARCHAR(30),
  @SA_Empleado NVARCHAR(30),
  @cedula_Empleado NVARCHAR(15),
  @Tel_E NVARCHAR(8),
  @Email NVARCHAR(100),
  @FechaContratacion DATE,
  @Salario DECIMAL(10, 2),
  @HorasTrabajo INT,
  @FechaNacimiento DATE,
  @EstadoCivil VARCHAR(20),
  @Genero VARCHAR(10),
  @NumeroCuentaBancaria VARCHAR(20)
AS
BEGIN
  -- Verificar si cedula_Empleado ya existe
  IF EXISTS(SELECT 1 FROM Empleado WHERE cedula_Empleado = @cedula_Empleado)
  BEGIN
    PRINT 'Empleado ya registrado'
    RETURN
  END

  -- Verificar que las columnas no estén en blanco
  IF @PN_Empleado = '' OR @PA_Empleado = '' OR @cedula_Empleado = '' OR @FechaContratacion IS NULL OR @Salario IS NULL
  BEGIN
    PRINT 'No pueden quedar vacios'
    RETURN
  END

  -- Verificar que el salario no sea negativo ni cero
  IF @Salario <= 0
  BEGIN
    PRINT 'Salario no puede ser negativo ni cero'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Empleado (PN_Empleado, SN_Empleado, PA_Empleado, SA_Empleado, cedula_Empleado, Tel_E, Email, FechaContratacion, Salario, HorasTrabajo, FechaNacimiento, EstadoCivil, Genero, NumeroCuentaBancaria)
  VALUES (@PN_Empleado, @SN_Empleado, @PA_Empleado, @SA_Empleado, @cedula_Empleado, @Tel_E, @Email, @FechaContratacion, @Salario, @HorasTrabajo, @FechaNacimiento, @EstadoCivil, @Genero, @NumeroCuentaBancaria)

  PRINT 'Datos insertados correctamente'
END


/* Procedimiento Insercion */
-----------------------------

CREATE PROCEDURE InsertarPuestoEmpleado
  @Id_Puesto INT,
  @Puesto NVARCHAR(50)
AS
BEGIN
  -- Verificar si el Id_Puesto ya existe
  IF EXISTS(SELECT 1 FROM PuestoEmpleado WHERE Id_Puesto = @Id_Puesto)
  BEGIN
    PRINT 'Puesto ya existe'
    RETURN
  END

  -- Verificar que el Id_Puesto no esté vacío
  IF @Id_Puesto IS NULL
  BEGIN
    PRINT 'El Id_Puesto no puede quedar vacío';
    RETURN
  END

  -- Verificar que el Puesto no esté vacío
  IF @Puesto = ''
  BEGIN
    PRINT 'El Puesto no puede quedar vacío'
    RETURN;
  END;

  -- Insertar los datos
  INSERT INTO PuestoEmpleado (Id_Puesto, Puesto)
  VALUES (@Id_Puesto, @Puesto);

  PRINT 'Datos insertados correctamente'
END


/* Procedimiento de Insercion */
----------------------------------
CREATE PROCEDURE InsertarEmpleadoPuesto
  @Id_Empleado INT,
  @Id_Puesto INT
AS
BEGIN
  -- Verificar si el Id_Empleado existe
  IF NOT EXISTS(SELECT 1 FROM Empleado WHERE Id_Empleado = @Id_Empleado)
  BEGIN
    PRINT 'Empleado no registrado'
    RETURN
  END

  -- Verificar si el Id_Puesto existe
  IF NOT EXISTS(SELECT 1 FROM PuestoEmpleado WHERE Id_Puesto = @Id_Puesto)
  BEGIN
    PRINT 'Puesto no existe'
    RETURN
  END

  -- Verificar que el Id_Empleado y el Id_Puesto no estén vacíos
  IF @Id_Empleado='' OR @Id_Puesto=''
  BEGIN
    PRINT 'No puede quedar vacío'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Empleado_Puesto (Id_Empleado, Id_Puesto)
  VALUES (@Id_Empleado, @Id_Puesto)

  PRINT 'Datos insertados correctamente'
END



/* Procedimiento Insercion */
------------------------------
CREATE PROCEDURE InsertarTopping
  @Ingredientes_Pizza NVARCHAR(60),
  @IDMateriaPrima INT
AS
BEGIN
  -- Verificar si el Ingrediente_Pizza ya existe
  IF EXISTS (SELECT 1 FROM Topping WHERE Ingredientes_Pizza = @Ingredientes_Pizza)
  BEGIN
    PRINT 'Ya registrado'
    RETURN
  END

  -- Verificar que los campos no estén vacíos
  IF @Ingredientes_Pizza IS NULL OR @Ingredientes_Pizza = '' OR
     @IDMateriaPrima=''
  BEGIN
    PRINT 'No pueden estar vacíos'
    RETURN
  END

  -- Verificar si el IDMateriaPrima existe
  IF NOT EXISTS (SELECT 1 FROM MateriaPrima WHERE IDMateriaPrima = @IDMateriaPrima)
  BEGIN
    PRINT 'Materia Prima no existe'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Topping (Ingredientes_Pizza, IDMateriaPrima)
  VALUES (@Ingredientes_Pizza, @IDMateriaPrima)

  PRINT 'Datos insertados correctamente'
END



/* Procedimiento Insercion */
---------------------------
CREATE PROCEDURE InsertarPizza
  @Nombre_Pizza NVARCHAR(30),
  @precio_Pizza MONEY,
  @slice INT,
  @Id_Topping INT,
  @Descripcion NVARCHAR(50)
AS
BEGIN
  -- Verificar si el Nombre_Pizza ya existe
  IF EXISTS (SELECT 1 FROM Pizzas WHERE Nombre_Pizza = @Nombre_Pizza)
  BEGIN
    PRINT 'Pizza ya existe'
    RETURN
  END

  -- Verificar que los campos no estén vacíos
  IF @Nombre_Pizza IS NULL OR @Nombre_Pizza = '' OR
     @precio_Pizza='' OR
     @slice='' OR
     @Id_Topping=''
  BEGIN
    PRINT 'No pueden quedar vacíos'
    RETURN
  END

  -- Verificar si el Id_Topping existe
  IF NOT EXISTS (SELECT 1 FROM Topping WHERE Id_Topping = @Id_Topping)
  BEGIN
    PRINT 'Topping no existe'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Pizzas (Nombre_Pizza, precio_Pizza, slice, Id_Topping, Descripcion)
  VALUES (@Nombre_Pizza, @precio_Pizza, @slice, @Id_Topping, @Descripcion)

  PRINT 'Datos insertados correctamente'
END



/* Procedimiento Insercion */
-----------------------------
CREATE PROCEDURE InsertarMateriaPrima
  @Nombre VARCHAR(50),
  @Stock INT,
  @UnidadMedida VARCHAR(20)
AS
BEGIN
  -- Verificar si el Nombre ya existe
  IF EXISTS (SELECT 1 FROM MateriaPrima WHERE Nombre = @Nombre)
  BEGIN
    PRINT 'Ya registrado'
    RETURN
  END

  -- Verificar que los campos no estén vacíos
  IF @Nombre IS NULL OR @Nombre = '' OR
     @Stock=''
     @UnidadMedida IS NULL OR @UnidadMedida = ''
  BEGIN
    PRINT 'No pueden quedar vacíos'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO MateriaPrima (Nombre, Stock, UnidadMedida)
  VALUES (@Nombre, @Stock, @UnidadMedida)

  PRINT 'Datos insertados correctamente'
END


/* Procedimiento Insercion */
-----------------------------
CREATE PROCEDURE InsertarPedido
  @Num_Pedido INT,
  @Id_Cliente INT,
  @Id_Pizza INT,
  @Id_Departamento INT,
  @Id_Municipio INT,
  @Dir_P NVARCHAR(100)
AS
BEGIN
  -- Verificar si el número de pedido ya existe
  IF EXISTS (SELECT 1 FROM Pedido WHERE Num_Pedido = @Num_Pedido)
  BEGIN
    PRINT 'Número de pedido ya registrado'
    RETURN
  END

  -- Verificar que los campos no estén vacíos
  IF @Num_Pedido='' OR
     @Id_Cliente='' OR
     @Id_Pizza='' OR
     @Id_Departamento='' OR
     @Id_Municipio='' OR
     @Dir_P IS NULL OR @Dir_P = ''
  BEGIN
    PRINT 'No pueden quedar vacíos'
    RETURN
  END

  -- Verificar si el cliente existe
  IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Id_Cliente = @Id_Cliente)
  BEGIN
    PRINT 'Cliente no registrado'
    RETURN
  END

  -- Verificar si la pizza existe
  IF NOT EXISTS (SELECT 1 FROM Pizzas WHERE Id_Pizza = @Id_Pizza)
  BEGIN
    PRINT 'Pizza no existe'
    RETURN
  END

  -- Verificar si el departamento existe
  IF NOT EXISTS (SELECT 1 FROM Departamentos WHERE Id_Departamento = @Id_Departamento)
  BEGIN
    PRINT 'Departamento no existe'
    RETURN
  END

  -- Verificar si el municipio existe
  IF NOT EXISTS (SELECT 1 FROM Municipios WHERE Id_Municipio = @Id_Municipio)
  BEGIN
    PRINT 'Municipio no existe'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Pedido (Num_Pedido, Fecha_Pedido, Id_Cliente, Id_Pizza, Id_Departamento, Id_Municipio, Dir_P)
  VALUES (@Num_Pedido, GETDATE(), @Id_Cliente, @Id_Pizza, @Id_Departamento, @Id_Municipio, @Dir_P)

  PRINT 'Pedido insertado correctamente'
END


/* Procedimiento Insercion */
-----------------------------
CREATE PROCEDURE InsertarPago
  @Id_Pedido INT,
  @ID_Cliente INT,
  @Metodo_pago NVARCHAR(20)
AS
BEGIN
  -- Verificar la existencia de Id_Pedido y ID_Cliente
  IF NOT EXISTS (SELECT 1 FROM Pedido WHERE Id_Pedido = @Id_Pedido)
  BEGIN
    PRINT 'El pedido no existe.'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Id_Cliente = @ID_Cliente)
  BEGIN
    PRINT 'El cliente no existe.'
    RETURN
  END

  -- Verificar que Metodo_pago no esté vacío
  IF @Metodo_pago='' 
  BEGIN
    PRINT 'El método de pago no puede estar vacío.'
    RETURN
  END

  -- Insertar los datos en la tabla Pago
  INSERT INTO Pago (Id_Pedido, ID_Cliente, Metodo_pago)
  VALUES (@Id_Pedido, @ID_Cliente, @Metodo_pago)

  PRINT 'Pago insertado correctamente.'
END


/* Procedimiento Insercion */
-----------------------------
CREATE PROCEDURE InsertarDetallePedido
  @Id_Pedido INT,
  @Id_Pizza INT,
  @Id_Extras INT = NULL,
  @Id_Pago INT,
  @Cantidad INT,
  @PrecioUnitario MONEY,
  @Descuento MONEY = NULL,
  @Subtotal MONEY,
  @CostoEnvio MONEY,
  @Id_Municipio INT
AS
BEGIN
  -- Verificar existencia de las claves foráneas
  IF NOT EXISTS (SELECT 1 FROM Pedido WHERE Id_Pedido = @Id_Pedido)
  BEGIN
    PRINT 'El pedido no existe'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Pizzas WHERE Id_Pizza = @Id_Pizza)
  BEGIN
    PRINT 'La pizza no existe'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Pago WHERE Id_Pago = @Id_Pago)
  BEGIN
    PRINT 'El pago no existe'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Municipios WHERE Id_Municipio = @Id_Municipio)
  BEGIN
    PRINT 'El municipio no existe'
    RETURN
  END

  -- Verificar campos no vacíos
  IF (@PrecioUnitario= '' OR @Subtotal= '')
  BEGIN
    PRINT 'Campos no pueden quedar vacios'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO DetallePedido (Id_Pedido, Id_Pizza, Id_Extras, Id_Pago, Cantidad, PrecioUnitario, Descuento, Subtotal, CostoEnvio, Id_Municipio)
  VALUES (@Id_Pedido, @Id_Pizza, @Id_Extras, @Id_Pago, @Cantidad, @PrecioUnitario, @Descuento, @Subtotal, @CostoEnvio, @Id_Municipio)

  PRINT 'Inserción exitosa'
END


/* Procedimiento Insercion */
----------------------------
CREATE PROCEDURE InsertarEntrega
  @ID_Pedido INT,
  @Estado NVARCHAR(20),
  @FechaHoraEntrega DATETIME,
  @Dir_Entrega NVARCHAR(50) NOT NULL,
  @Id_Empleado INT,
  @Id_Cliente INT,
  @Tipo_Entrega NVARCHAR(20)
AS
BEGIN
  -- Verificar existencia de las claves foráneas
  IF @ID_Pedido=''
  BEGIN
    PRINT 'El ID del pedido no puede estar vacío'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Pedido WHERE Id_Pedido = @ID_Pedido)
  BEGIN
    PRINT 'El pedido no existe'
    RETURN
  END

  IF @Id_Empleado=''
  BEGIN
    PRINT 'El ID del empleado no puede estar vacío'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Empleado WHERE Id_Empleado = @Id_Empleado)
  BEGIN
    PRINT 'El empleado no existe'
    RETURN
  END

  IF @Id_Cliente=''
  BEGIN
    PRINT 'El ID del cliente no puede estar vacío'
    RETURN
  END

  IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Id_Cliente = @Id_Cliente)
  BEGIN
    PRINT 'El cliente no existe'
    RETURN
  END

  -- Verificar campo no vacío
  IF @Dir_Entrega=''
  BEGIN
    PRINT 'La dirección de entrega no puede estar vacía'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Entrega (ID_Pedido, Estado, FechaHoraEntrega, Dir_Entrega, Id_Empleado, Id_Cliente, Tipo_Entrega)
  VALUES (@ID_Pedido, @Estado, ISNULL(@FechaHoraEntrega, GETDATE()), @Dir_Entrega, @Id_Empleado, @Id_Cliente, @Tipo_Entrega)

  PRINT 'Inserción exitosa'
END

/* Procedimiento Insercion */
------------------------------
CREATE PROCEDURE InsertarDepartamento
  @ND NVARCHAR(30)
AS
BEGIN
  -- Verificar campo no vacío
  IF @ND=''
  BEGIN
    PRINT 'El nombre del departamento no puede estar vacío'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Departamentos (ND)
  VALUES (@ND)

  PRINT 'Inserción exitosa'
END

/* Procedimiento Insercion */
CREATE PROCEDURE InsertarMunicipio
  @NM NVARCHAR(30),
  @Id_Departamento INT
AS
BEGIN
  -- Verificar campo no vacío
  IF @NM= ''
  BEGIN
    PRINT 'El nombre del municipio no puede estar vacío'
    RETURN
  END

  -- Verificar existencia del departamento
  IF NOT EXISTS (SELECT 1 FROM Departamentos WHERE Id_Departamento = @Id_Departamento)
  BEGIN
    PRINT 'El departamento especificado no existe'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Municipios (NM, Id_Departamento)
  VALUES (@NM, @Id_Departamento)

  PRINT 'Inserción exitosa'
END


CREATE PROCEDURE In_Pdts_S (
  @Nombre NVARCHAR(50),
  @Precio MONEY,
  @IdProveedor INT
)
AS
BEGIN
  -- Verificar si el proveedor existe
  IF NOT EXISTS (SELECT * FROM Proveedores WHERE Id_Proveedor = @IdProveedor)
  BEGIN
    PRINT 'El proveedor no existe'
    RETURN
  END

  -- Verificar si el nombre del producto ya existe
  IF EXISTS (SELECT * FROM Pdts_Suministrados WHERE Nombre = @Nombre)
  BEGIN
    PRINT 'El nombre del producto ya está registrado'
    RETURN
  END

  -- Verificar si el nombre del producto y el precio no están vacíos
  IF @Nombre= '' OR @Precio= ''
  BEGIN
    PRINT 'Campos vacíos'
    RETURN
  END

  -- Insertar el nuevo producto suministrado
  INSERT INTO Pdts_Suministrados (Nombre, Precio, Id_Proveedor)
  VALUES (@Nombre, @Precio, @IdProveedor)

  PRINT 'Producto suministrado insertado correctamente'
END


-- Listar Empleados Activos
create procedure LEA
as
select * from Empleado where EstadoE=1


-- Listar Topping Activos
create procedure LTA
as
select * from Toppping where Est_Topping=1


-- Listar Pizzas Activas
create procedure LPZA
as
select * from Pizzas where EstadoP=1


-- Listar Pedido Activos
create procedure LPA
as
select * from Pedido where EstadoPedido=1


-- Listar Clientes Inactivos
create procedure LCI
as
select * from Clientes where EstadoC=0


-- Listar Empleado Inactivos
create procedure LEI
as
select * from Empleado where EstadoE=0


-- Listar Topping Inactivos
create procedure LTI
as
select * from Topping where Est_Topping=0


-- Listar Pizzas Inactivas
create procedure LPZI
as
select * from Pizzas where EstadoP=0


-- Listar Pedido Inactivos
create procedure LPI
as
select * from Pedido where EstadoPedido=0




--------------------------------------------  
/*Procedimientos almacenado de modificacion*/
--------------------------------------------


CREATE PROCEDURE ModificarClientes (
    @PNC NVARCHAR(30),
    @SNC NVARCHAR(30),
    @PAC NVARCHAR(30),
    @SAC NVARCHAR(30),
    @cedula_C NVARCHAR(15),
    @Tel_C NVARCHAR(8),
    @Dir_C NVARCHAR(100),
    @Email NVARCHAR(100),
    @IdCliente INT
)
AS
BEGIN
    DECLARE @idcliente AS INT
    SET @idcliente = (SELECT Id_Cliente FROM Clientes WHERE Id_Cliente = @IdCliente)

    IF (@IdCliente = @idcliente)
    BEGIN
        IF (@PNC IS NOT NULL AND @PAC IS NOT NULL AND @cedula_C IS NOT NULL AND @Tel_C IS NOT NULL AND @Dir_C IS NOT NULL AND @Email IS NOT NULL)
        BEGIN
            UPDATE Clientes
            SET PNC = @PNC, SNC = @SNC, PAC = @PAC, SAC = @SAC, cedula_C = @cedula_C, Tel_C = @Tel_C, Dir_C = @Dir_C, Email = @Email
            WHERE Id_Cliente = @IdCliente

            PRINT 'Los datos del cliente han sido modificados correctamente.'
        END
        ELSE
        BEGIN
            PRINT 'No se permiten valores nulos para PNC, PAC, cedula_C, Tel_C, Dir_C y Email.'
        END
    END
    ELSE
    BEGIN
        PRINT 'Cliente no encontrado.'
    END
END


CREATE PROCEDURE ModificarEmpleado (
    @PN_Empleado NVARCHAR(30),
    @SN_Empleado NVARCHAR(30),
    @PA_Empleado NVARCHAR(30),
    @SA_Empleado NVARCHAR(30),
    @cedula_Empleado NVARCHAR(15),
    @Tel_E NVARCHAR(8),
    @Email NVARCHAR(100),
    @FechaContratacion DATE,
    @Salario DECIMAL(10, 2),
    @HorasTrabajo INT,
    @FechaNacimiento DATE,
    @EstadoCivil VARCHAR(20),
    @Genero VARCHAR(10),
    @NumeroCuentaBancaria VARCHAR(20),
    @IdEmpleado INT
)
AS
BEGIN
    DECLARE @idempleado AS INT
    SET @idempleado = (SELECT Id_Empleado FROM Empleado WHERE Id_Empleado = @IdEmpleado)

    IF (@IdEmpleado = @idempleado)
    BEGIN
        IF (@PN_Empleado IS NOT NULL AND @PA_Empleado IS NOT NULL AND @cedula_Empleado IS NOT NULL AND @Tel_E IS NOT NULL AND @Email IS NOT NULL)
        BEGIN
            UPDATE Empleado
            SET PN_Empleado = @PN_Empleado, SN_Empleado = @SN_Empleado, PA_Empleado = @PA_Empleado, SA_Empleado = @SA_Empleado,
                cedula_Empleado = @cedula_Empleado, Tel_E = @Tel_E, Email = @Email, FechaContratacion = @FechaContratacion,
                Salario = @Salario, HorasTrabajo = @HorasTrabajo, FechaNacimiento = @FechaNacimiento, EstadoCivil = @EstadoCivil,
                Genero = @Genero, NumeroCuentaBancaria = @NumeroCuentaBancaria
            WHERE Id_Empleado = @IdEmpleado

            PRINT 'Los datos del empleado han sido modificados correctamente.'
        END
        ELSE
        BEGIN
            PRINT 'No se permiten valores nulos para PN_Empleado, PA_Empleado, cedula_Empleado, Tel_E y Email.'
        END
    END
    ELSE
    BEGIN
        PRINT 'Empleado no encontrado.'
    END
END


CREATE PROCEDURE ModificarPedido (
    @Num_Pedido INT,
    @Fecha_Pedido DATETIME,
    @Id_Cliente INT,
    @Id_Pizza INT,
    @Id_Pedido INT
)
AS
BEGIN
    DECLARE @idpedido AS INT
    SET @idpedido = (SELECT Id_Pedido FROM Pedido WHERE Id_Pedido = @Id_Pedido)

    IF (@Id_Pedido = @idpedido)
    BEGIN
        IF (@Fecha_Pedido IS NOT NULL AND @Id_Cliente IS NOT NULL AND @Id_Pizza IS NOT NULL)
        BEGIN
            UPDATE Pedido
            SET Num_Pedido = @Num_Pedido, Fecha_Pedido = @Fecha_Pedido, Id_Cliente = @Id_Cliente, Id_Pizza = @Id_Pizza
            WHERE Id_Pedido = @Id_Pedido

            PRINT 'Los datos del pedido han sido modificados correctamente.'
        END
        ELSE
        BEGIN
            PRINT 'No se permiten valores nulos para Fecha_Pedido, Id_Cliente y Id_Pizza.'
        END
    END
    ELSE
    BEGIN
        PRINT 'Pedido no encontrado.'
    END
END

CREATE PROCEDURE ModificarPizza (
    @Id_Pizza INT,
    @Precio_Pizza MONEY,
    @Tamaño_Pizza INT,
    @Slice INT,
    @Id_Topping INT,
    @Descripcion NVARCHAR(50)
)
AS
BEGIN
    IF (@Precio_Pizza > 0)
    BEGIN
        IF (@Tamaño_Pizza = 10 OR @Tamaño_Pizza = 14 OR @Tamaño_Pizza = 18)
        BEGIN
            IF EXISTS (SELECT 1 FROM Pizzas WHERE Id_Pizza = @Id_Pizza)
            BEGIN
                UPDATE Pizzas
                SET precio_Pizza = @Precio_Pizza,
                    @Tamaño_Pizza = @Tamaño_Pizza,
                    slice = @Slice,
                    Id_Topping = @Id_Topping,
                    Descripcion = @Descripcion
                WHERE Id_Pizza = @Id_Pizza
            END
            ELSE
            BEGIN
                PRINT 'Pizza no encontrada'
            END
        END
        ELSE
        BEGIN
            PRINT 'El tamaño de la pizza debe ser 10, 14 o 18 pulgadas'
        END
    END
    ELSE
    BEGIN
        PRINT 'El precio de la pizza debe ser mayor a cero'
    END
END


  CREATE PROCEDURE ModificarPago (
    @Id_Pago INT,
    @Id_Pedido INT,
    @ID_Cliente INT,
    @Metodo_pago NVARCHAR(20)
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Pago WHERE Id_Pago = @Id_Pago)
    BEGIN
        UPDATE Pago
        SET Id_Pedido = @Id_Pedido,
            ID_Cliente = @ID_Cliente,
            Metodo_pago = @Metodo_pago
        WHERE Id_Pago = @Id_Pago
    END
    ELSE
    BEGIN
        PRINT 'Pago no encontrado'
    END
END

    CREATE PROCEDURE ModificarEntrega (
    @ID_Pedido INT,
    @Estado NVARCHAR(20),
    @FechaHoraEntrega DATETIME,
    @Dir_Entrega NVARCHAR(50),
    @Id_Empleado INT,
    @Id_Cliente INT,
    @Tipo_Entrega NVARCHAR(20)
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Entrega WHERE ID_Pedido = @ID_Pedido)
    BEGIN
        UPDATE Entrega
        SET Estado = @Estado,
            FechaHoraEntrega = @FechaHoraEntrega,
            Dir_Entrega = @Dir_Entrega,
            Id_Empleado = @Id_Empleado,
            Id_Cliente = @Id_Cliente,
            Tipo_Entrega = @Tipo_Entrega
        WHERE ID_Pedido = @ID_Pedido
    END
    ELSE
    BEGIN
        PRINT 'Entrega no encontrada'
    END
END

-------------------------------------------------------
/* procedimiento almacenado de baja */
------------------------------------------------------


alter table Clientes add EstadoC bit default 1
alter table Empleado add EstadoE bit default 1
alter table Topping add Est_Topping bit default 1
alter table Pizzas add EstadoP bit default 1
alter table Pedido add EstadoPedido bit default 1




CREATE PROCEDURE BajaCliente (
    @Id_Cliente INT
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clientes WHERE Id_Cliente = @Id_Cliente)
    BEGIN
        UPDATE Clientes
        SET EstadoC = 0
        WHERE Id_Cliente = @Id_Cliente AND EstadoC = 1
    END
    ELSE
    BEGIN
        PRINT 'Cliente no encontrado'
    END
END

CREATE PROCEDURE BajaEmpleado (
    @Id_Empleado INT
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Empleado WHERE Id_Empleado = @Id_Empleado)
    BEGIN
        UPDATE Empleado
        SET EstadoE = 0
        WHERE Id_Empleado = @Id_Empleado
    END
    ELSE
    BEGIN
        PRINT 'Empleado no encontrado'
    END
END
CREATE PROCEDURE BajaTopping (
    @Id_Topping INT
)
AS
BEGIN
    -- Verificar si el Topping existe
    IF EXISTS (SELECT 1 FROM Topping WHERE Id_Topping = @Id_Topping)
    BEGIN
        -- Verificar si hay Materia Prima del Ingrediente asociado al Topping
        IF EXISTS (SELECT 1 FROM MateriaPrima WHERE Nombre = (SELECT Ingredientes_Pizza FROM Topping WHERE Id_Topping = @Id_Topping))
        BEGIN
            -- Dar de baja el Topping
            UPDATE Topping
            SET Est_Topping = 0
            WHERE Id_Topping = @Id_Topping

            -- Verificar si hay Pizzas con ese Topping
            IF EXISTS (SELECT 1 FROM Pizzas WHERE Id_Topping = @Id_Topping)
            BEGIN
                -- Marcar las Pizzas con ese Topping como no disponibles
                UPDATE Pizzas
                SET EstadoP= 0
                WHERE Id_Topping = @Id_Topping
            END
        END
        ELSE
        BEGIN
            PRINT 'No hay materia prima disponible para el ingrediente del Topping'
        END
    END
    ELSE
    BEGIN
        PRINT 'Topping no encontrado'
    END
END

CREATE PROCEDURE BajaPedido (
    @Id_Pedido INT
)
AS
BEGIN
    -- Verificar si el Pedido existe
    IF EXISTS (SELECT 1 FROM Pedido WHERE Id_Pedido = @Id_Pedido)
    BEGIN
        -- Verificar si el Cliente ha cancelado el Pedido
        IF EXISTS (SELECT 1 FROM Pago WHERE Id_Pedido = @Id_Pedido AND Metodo_pago = 'Cancelado')
        BEGIN
            -- Actualizar el estado del Pedido a "Dado de baja" (Estado = 0)
            UPDATE Pedido SET EstadoPedido = 0 WHERE Id_Pedido = @Id_Pedido

            PRINT 'Pedido dado de baja correctamente'
        END
        ELSE
        BEGIN
            PRINT 'El pedido no puede ser dado de baja porque el cliente no lo ha cancelado'
        END
    END
    ELSE
    BEGIN
        PRINT 'Pedido no encontrado'
    END
END


--------------------------------------------------------------------------------------------------
/*Procedimiento almacenado de busqueda*/

-----Busqueda por Id Cliente----
CREATE PROCEDURE BuscarClienteById
    @Id_Cliente INT
AS
BEGIN
    -- Verificar si el Cliente existe
    IF EXISTS (SELECT 1 FROM Clientes WHERE Id_Cliente = @Id_Cliente)
    BEGIN
        -- Realizar la búsqueda por Id
        SELECT * FROM Clientes WHERE Id_Cliente = @Id_Cliente
    END
    ELSE
    BEGIN
        PRINT 'Cliente no encontrado'
    END
END

-------Busqueda por nombre Cliente-------
CREATE PROCEDURE BuscarClienteByNombre
    @Nombre NVARCHAR(100)
AS
BEGIN
    -- Verificar si el Nombre está en blanco
    IF @Nombre = ''
    BEGIN
        PRINT 'El campo de nombre no puede estar en blanco'
    END
    ELSE
    BEGIN
        -- Realizar la búsqueda por nombre
        SELECT * FROM Clientes WHERE PAC = @Nombre OR SAC = @Nombre
    END
END


----Busqueda por Id empleado---
CREATE PROCEDURE BuscarEmpleadoById
    @IdEmpleado INT
AS
BEGIN
    -- Verificar si existe el empleado con el ID proporcionado
    IF EXISTS (SELECT 1 FROM Empleado WHERE Id_Empleado = @IdEmpleado)
    BEGIN
        -- Realizar la búsqueda del empleado por su ID
        SELECT * FROM Empleado WHERE Id_Empleado = @IdEmpleado
    END
    ELSE
    BEGIN
        PRINT 'No se encontró ningún empleado con el ID especificado'
    END
END


----Busqueda por Nombre empleado----
CREATE PROCEDURE BuscarEmpleadoByNombre
    @Nombre NVARCHAR(30)
AS
BEGIN
    -- Verificar si existen empleados con el nombre proporcionado
    IF EXISTS (SELECT 1 FROM Empleado WHERE PN_Empleado = @Nombre OR PA_Empleado = @Nombre)
    BEGIN
        -- Realizar la búsqueda de empleados por nombre
        SELECT * FROM Empleado WHERE PN_Empleado = @Nombre OR PA_Empleado = @Nombre
    END
    ELSE
    BEGIN
        PRINT 'No se encontraron empleados con el nombre especificado'
    END
END

----Busqueda por Id o nombre del topping

CREATE PROCEDURE BuscarTopping
    @Id INT = NULL,
    @Nombre NVARCHAR(60) = NULL
AS
BEGIN
    -- Verificar si se proporcionó el identificador y/o el nombre de ingrediente
    IF (@Id IS NULL AND @Nombre IS NULL)
    BEGIN
        PRINT 'Debe proporcionar al menos el identificador o el nombre del ingrediente'
        RETURN
    END

    -- Realizar la búsqueda de toppings según los parámetros proporcionados
    IF (@Id IS NOT NULL)
    BEGIN
        SELECT * FROM Topping WHERE Id_Topping = @Id
    END

    IF (@Nombre IS NOT NULL)
    BEGIN
        SELECT * FROM Topping WHERE Ingredientes_Pizza LIKE '%' + @Nombre + '%'
    END
END

----Busqueda por Id, precio de pizza y tamaño---
CREATE PROCEDURE BuscarPizza
    @Id INT = NULL,
    @IdTopping INT = NULL,
    @Tamaño INT = NULL,
    @Precio MONEY = NULL
AS
BEGIN
    -- Verificar si se proporcionó al menos uno de los parámetros de búsqueda
    IF (@Id IS NULL AND @IdTopping IS NULL AND @Tamaño IS NULL AND @Precio IS NULL)
    BEGIN
        PRINT 'Debe proporcionar al menos uno de los parámetros de búsqueda'
        RETURN
    END

    -- Realizar la búsqueda de pizzas según los parámetros proporcionados
    SELECT *
    FROM Pizzas
    WHERE (@Id IS NULL OR Id_Pizza = @Id)
        AND (@IdTopping IS NULL OR Id_Topping = @IdTopping)
        AND (@Tamaño IS NULL OR Tamaño_Pizza = @Tamaño)
        AND (@Precio IS NULL OR precio_Pizza = @Precio)
END


----Busqueda de pedido por id , total de pedido, y si fue entregado o no----



CREATE PROCEDURE BuscarPedido
    @IdPedido INT = NULL,
    @TotalPedido MONEY = NULL,
    @Entregado BIT = NULL
AS
BEGIN
    -- Verificar si se proporcionó al menos uno de los parámetros de búsqueda
    IF (@IdPedido IS NULL AND @TotalPedido IS NULL AND @Entregado IS NULL)
    BEGIN
        PRINT 'Debe proporcionar al menos uno de los parámetros de búsqueda'
        RETURN
    END

    -- Realizar la búsqueda de pedidos según los parámetros proporcionados
    SELECT P.*, E.Estado
    FROM Pedido AS P
    LEFT JOIN Entrega AS E ON P.Id_Pedido = E.ID_Pedido
    WHERE (@IdPedido IS NULL OR P.Id_Pedido = @IdPedido)
        AND (@TotalPedido IS NULL OR EXISTS (SELECT 1 FROM DetallePedido WHERE Id_Pedido = P.Id_Pedido GROUP BY Id_Pedido HAVING SUM(Subtotal) = @TotalPedido))
        AND (@Entregado IS NULL OR (CASE WHEN E.Estado = 'Entregado' THEN 1 ELSE 0 END) = @Entregado)
END




   
  
    
 
 
 /*que mas podemos agregar?*/
