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
  Id_Topping INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Ingredientes_Pizza NVARCHAR(60) NOT NULL,
  Est_Topping INT NOT NULL DEFAULT 1
)

CREATE TABLE Pizzas (
  Id_Pizza INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  precio_Pizza MONEY NOT NULL,
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
  Metodo_pago NVARCHAR(20),
  FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido),
  FOREIGN KEY (ID_Cliente) REFERENCES Clientes(Id_Cliente)
)


CREATE TABLE DetallePedido (
  Id_DetalleP INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Id_Pedido INT not null,
  Id_Pizza INT not null,
  Id_Extras INT,
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
  foreign key (Id_Municipio) references Municipios(Id_Municipio),
  Di
)

CREATE TABLE Entrega (
  ID_Pedido INT,
  Estado NVARCHAR(20),
  FechaHoraEntrega DATETIME DEFAULT GETDATE(),
  Dir_Entrega NVARCHAR(50) NOT NULL,
  Id_Empleado INT,
  Id_Cliente INT,
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
  

 /* Procedimiento de Insercion*/
  -------------------------------
CREATE PROCEDURE InsertarTopping
@Ingr_Pizza NVARCHAR(60),
@Est_Topping INT
AS
BEGIN
  IF @Ingredientes_Pizza = ''
  BEGIN
    PRINT 'El ingrediente de la pizza no puede quedar en blanco.'
  END
  ELSE IF EXISTS (SELECT 1 FROM Topping WHERE Ingredientes_Pizza = @Ingredientes_Pizza)
  BEGIN
    PRINT 'El topping ya está registrado.'
  END
  ELSE
  BEGIN
    INSERT INTO Topping (Ingredientes_Pizza, Est_Topping)
    VALUES (@Ingredientes_Pizza, @Est_Topping)
    
    PRINT 'Topping registrado exitosamente.'
  END
END

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
  IF @Id_Empleado IS NULL OR @Id_Puesto IS NULL
  BEGIN
    PRINT 'No puede quedar vacío'
    RETURN
  END

  -- Insertar los datos
  INSERT INTO Empleado_Puesto (Id_Empleado, Id_Puesto)
  VALUES (@Id_Empleado, @Id_Puesto)

  PRINT 'Datos insertados correctamente'
END



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



   
  
    
 
 
 /*que mas podemos agregar?*/
