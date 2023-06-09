/* Proyecto para la clase de base de datos
creacion de una base de datos para una pizzeria*/

create table Clientes(
cedula_C nvarchar(15) check (cedula_C LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
Id_Cliente int identity(1,1) primary key,
Tel_C nvarchar(8) check (Tel_C LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Dir_C nvarchar(100),
PNC nvarchar(30) not null,
SNC nvarchar(30),
PAC nvarchar(30) not null,
SAC nvarchar(30),
foreign key (Num_pedido) references Pedido(Num_pedido),
foreign key (Id_pedido) references Pedido(Id_pedido),
),

create table Pedido(
 Id_pedido int identity(1,1) primary key,
 Fecha_pedido datetime default getdate() not null,
 foreign key (PNC) references Clientes(PNC),
 foreign key (Id_Cliente) references Clientes(Id_Cliente),
 Metodo_pago nvarchar(20),
 Total_pago money,
 foreign key (Id_producto) references Productos(Id_producto)
 
 
 /*que mas podemos agregar?*/
