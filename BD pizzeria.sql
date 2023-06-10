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
  Id_Empleado INT,
  Id_Puesto INT,
  FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado),
  FOREIGN KEY (Id_Puesto) REFERENCES PuestoEmpleado(Id_Puesto)
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
  
  create procedure In_Toppping(
    @Ingr_Pizza nvarchar(16),
    
    
  



   
  
    
 
 
 /*que mas podemos agregar?*/
