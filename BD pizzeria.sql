/* Proyecto para la clase de base de datos
creacion de una base de datos para una pizzeria*/

create table Clientes(
cedula_C nvarchar(15) check (cedula_C LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
Id_cliente int identity(1,1) primary key,
Tel_C nvarchar(8) check (Tel_C LIKE '[78][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Dir_C nvarchar(100),
PNC nvarchar(30) not null,
SNC nvarchar(30),
PAC nvarchar(30) not null,
SAC nvarchar(30),
foreign key (Num_pedido) references Pedidos(Num_pedido),
foreign key (Id_pedido) references Pedidos(Id_pedido)
),
 
 /*que mas podemos agregar?*/
