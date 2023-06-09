/* Proyecto para la clase de base de datos
creacion de una base de datos para una pizzeria*/

create database Pizzeria
use Pizzeria

create table Clientes(
Id_Cliente int identity(1,1) primary key not null,
PNC nvarchar(30) not null,
SNC nvarchar(30),
PAC nvarchar(30) not null,
SAC nvarchar(30),
cedula_C nvarchar(15) check (cedula_C LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
Tel_C nvarchar(8) check (Tel_C LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Dir_C nvarchar(100),
Email nvarchar(100),
),

create table Pedido(
 Id_Pedido int identity(1,1) primary key not null,
 Num_Pedido int identity(1,1),
 Fecha_Pedido datetime default getdate() not null,
 PNC nvarchar(30),
 Id_Cliente int,
 foreign key (Id_Cliente) references Clientes(Id_Cliente),
 Total_pago money,
 Id_pizza int,
 foreign key (Id_pizza) references Pizzas(Id_pizza)
 ),
 
 create table Pizzas(
  Id_Pizza int identity(1,1) primary key not null,
  precio_Pizza money not null,
  Tamano int check (Tamano in (10, 14, 18)),
  Ingredientes_Pizza nvarchar(60) not null,
  Descripcion nvarchar(50) not null,
  )
  
  create table Empleado(
   Id_Empleado  int identity(1,1) primary key not null,
   PN_Empleado nvarchar(30) not null,
   SN_Empleado nvarchar(30),
   PA_Empleado nvarchar(30) not null,
   SA_Empleado nvarchar(30),
   cedula_Empleado nvarchar(15) check (cedula_Empleado LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
   Tel_E nvarchar(8) check (Tel_E LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
   Email nvarchar(100),
   FechaContratacion DATE,
   Puesto nvarchar(50),
   
   Salario DECIMAL(10, 2),
   HorasTrabajo INT,
   FechaNacimiento DATE,
   EstadoCivil VARCHAR(20),
   Genero VARCHAR(10),
   NumeroCuentaBancaria VARCHAR(20),
   Supervisor INT,
   )
   
  CREATE TABLE PuestoEmpleado (
  IDPuesto INT PRIMARY KEY,
  Puesto nvarhar(50)
  )


CREATE TABLE Empleado_Puesto (
  Id_Empleado INT,
  IDPuesto INT,
  FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado),
  FOREIGN KEY (IDPuesto) REFERENCES PuestoEmpleado(IDPuesto)
)

-- Insertar registros de ejemplo en la tabla PuestoEmpleado
INSERT INTO PuestoEmpleado (IDPuesto, Puesto) VALUES
(1, 'Cocinero'),
(2, 'Repartidor'),
(3, 'Supervisor'),
(4, 'Mercadeo')


INSERT INTO Empleado_Puesto (Id_Empleado, Id_Puesto) VALUES
(1, 1), -- Juan Perez es cocinero
(2, 2), -- Maria Gomez es repartidora
(3, 3), -- Pedro Lopez es supervisor
(4, 4); -- Laura Torres está en mercadeo
   
    create table Repartidor(
    Id_Repartidor int identity(1,1) primary key not null,
    Id_Empleado int,
    foreign key (Id_Empleado) references Empleado(Id_Empleado),
    )
   
  
  create table Entrega(
   Id_Pedido int,
   foreign key(Id_Pedido) references Pedido(Id_Pedido),
   FechaHoraEntrega DATETIME DEFAULT GETDATE(),
   Dir_entrega nvarchar(50) not null,
   Id_Empleado int,
   foreign key(Id_Empleado) references Empleados(Id_Empleado),
   Id_Pedido int,
   foreign key(Id_Pedido) references Pedido(Id_Pedido),
   Tipo_Entrega nvarchar(20)
   )
   
   create table Pago(
    Id_pago int identity(1,1) primary key,
    Id_Pedido int,
    foreign key(Id_Pedido) references Pedido(Id_Pedido),
    Id_Cliente int,
    foreign key (Id_Cliente) references Clientes(Id_Cliente),
    Metodo_pago nvarchar(20)
    )
    
    create table Topping(
     Id_Materiaprima int identity(1,1) primary key,
     Est_Ingrediente int not null default 1,
     )
    
   
  
    
   
   
 
 
 /*que mas podemos agregar?*/
