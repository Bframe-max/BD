/* Proyecto para la clase de base de datos
creacion de una base de datos para una pizzeria*/

create table Clientes(
Id_Cliente int identity(1,1) primary key,
PNC nvarchar(30) not null,
SNC nvarchar(30),
PAC nvarchar(30) not null,
SAC nvarchar(30),
cedula_C nvarchar(15) check (cedula_C LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
Tel_C nvarchar(8) check (Tel_C LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Dir_C nvarchar(100),
Correo nvarchar(100),
),

create table Pedido(
 Id_Pedido int identity(1,1) primary key,
 Num_Pedido int identity(1,1),
 Fecha_Pedido datetime default getdate() not null,
 PNC nvarchar(30),
 foreign key (PNC) references Clientes(PNC),
 Id_Cliente int,
 foreign key (Id_Cliente) references Clientes(Id_Cliente),
 Total_pago money,
 Id_pizza int,
 foreign key (Id_pizza) references Pizzas(Id_pizza)
 ),
 
 create table Pizzas(
  Id_Pizza int identity(1,1) primary key,
  precio_Pizza money not null,
  slice int not null,
  Ingredientes_Pizza nvarchar(60) not null,
  Descripcion nvarchar(50) not null,
  )
  
  create table Empleado(
   Id_Empleado 
  
  
  create table Entrega(
   ID_Pedido int,
   foreign key(Id_pedido) references Pedido(Id_pedido),
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
    foreign key(Id_Pedido) references Pedido(Id_Pedido),
    foreign key (PNC) references Clientes(PNC),
    foreign key (Id_Cliente) references Clientes(Id_Cliente),
    Metodo_pago nvarchar(20)
    )
   
   create table Repartidor(
    Id_Repartidor int identity(1,1) primary key,
    PN_Repartidor nvarchar(30) not null,
    SN_Repartidor nvarchar(30),
    PA_Repartidor nvarchar(30) not null,
    SA_Repartidor nvarchar(30),
    cedula_Repartidor nvarchar(15) check (cedula_Repartdior LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
    Tel_R nvarchar(8) check (Tel_R LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    )
    
   
   
 
 
 /*que mas podemos agregar?*/
