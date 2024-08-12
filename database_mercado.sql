create database mercado;

use mercado;

create table mercado (
idMercado int primary key auto_increment not null,
nome varchar (45) not null,
corredor int(2) not null,
cnpj numeric(16,0) not null check (length(cnpj) >=13),
email varchar (45) not null,
tipo_de_produto varchar (45) not null,
quantidade int(3) not null check(length(quantidade) > 0),
id_Marca int null,
id_Endereco_M int not null,

foreign key (id_Marca) references mercado (idMercado),
foreign key (id_Endereco_M) references endereco_M (idEndereco_M)
);

create table endereco_M(
idEndereco_M int primary key auto_increment not null,
uf char (2) not null,
cidade varchar (45) not null,
bairro varchar (45) not null,
rua varchar (45) not null
);

create table telefone_M(
idTelefone_M int primary key auto_increment not null,
tipo enum('cel','com') not null,
numero numeric (15,0) not null check (length(numero) >=7),
id_Mercado int not null,

foreign key (id_Mercado) references mercado (idMercado)
);

create table deposito(
idDeposito int primary key auto_increment not null,
nome varchar (45) not null,
corredor int (2) not null,
tipo_de_produto varchar (45) not null,
quantidade int(3) not null check(length(quantidade) > 0),
id_Marca int null,
id_Endereco_D int not null,

foreign key (id_Marca) references deposito (idDeposito),
foreign key (id_Endereco_D) references endereco_D (idEndereco_D) 
);

create table endereco_D(
idEndereco_D int primary key auto_increment not null,
uf char (2) not null,
cidade varchar (45) not null,
bairro varchar (45) not null,
rua varchar (45) not null
);

create table telefone_D(
idTelefone_D int primary key auto_increment not null,
tipo enum ('cel','com') not null,
numero numeric(15,0) not null  check (length(numero) >=7),
id_Deposito int,

foreign key (id_Deposito) references deposito (idDeposito)
);

create table mercado_deposito(
idMercado_Deposito int primary key auto_increment not null,
id_Mercado int not null,
id_Deposito int not null,

foreign key (id_Mercado) references mercado (idMercado),
foreign key (id_Deposito) references deposito (idDeposito)
);


DELIMITER $ 


create procedure inserir_Mercado (in idMarket int, in identificacao varchar (45), in setor int (3), in cnp_j numeric(16,0), in gmail varchar (100),  in tipo_de_grupo varchar (45), in quantia int (3), in Marca int, in id_Localizacao int)
begin 
    insert into mercado (idMercado, nome, corredor, cnpj, email,tipo_de_Produto,quantidade,id_Marca, id_Endereco_M)
    values (idMarket, identificacao, setor, cnp_j, gmail, tipo_de_grupo, quantia, Marca, id_Localizacao);
end$

DELIMITER ;

DELIMITER $

create procedure inserir_Endereco_M (in idlocalizacao int, in estado char (2), in city varchar (45), in bairros varchar(45), in ruas varchar (45)) 
begin
     insert into  endereco_M (idEndereco_M ,uf ,cidade ,bairro ,rua)
     values (idlocalizacao, estado, city, bairros, ruas) ;
end$

DELIMITER ;

DELIMITER $

create procedure inserir_Telefone_M (in idPhone int, in tipos enum('cel','com'),in numeros numeric (15,0),in id_shop int)
begin
   insert into telefone_M( idTelefone_M, tipo, numero, id_Mercado)
   values (idPhone, tipos, numeros, id_shop);
end $

DELIMITER ;

DELIMITER $

create procedure inserir_Deposito (in idGalpao int, in titulo varchar (45), in setor int(2),in tipo_de_grupo varchar (45), in quantia int (3), in Marca int,in idLocalizacao int )
begin
   insert into deposito (idDeposito, nome, corredor,tipo_de_Produto,quantidade,id_Marca, id_Endereco_D)
   values (idGalpao, titulo, setor, tipo_de_grupo, quantia, Marca, idLocalizacao);
end$

DELIMITER ;

DELIMITER $

create procedure inserir_Endereco_D  (in idlocalizacao int, in estado char (2), in city varchar (45), in bairros varchar(45), in ruas varchar (45)) 
begin
     insert into  endereco_D (idEndereco_D ,uf ,cidade ,bairro ,rua)
     values (idlocalizacao, estado, city, bairros, ruas) ;
end$

DELIMITER ;

DELIMITER $

create procedure inserir_Telefone_D (in idPhone int, in tipos enum('cel','com'),in numeros numeric(15,0),in id_depositos int)
begin
   insert into telefone_D( idTelefone_D, tipo, numero, id_Deposito)
   values (idPhone, tipos, numeros, id_depositos);
end $

DELIMITER ;

CREATE DATABASE BKP_mercado; 

USE BKP_mercado; 

CREATE TABLE BKP_Mercados( 

idBkpMercado INT PRIMARY KEY AUTO_INCREMENT, 
idMercado int ,
nome varchar (45),
corredor int(2),
cnpj numeric(16,0) ,
email varchar (45) ,
tipo_de_produto varchar (45) ,
quantidade int(3) ,
id_Marca int null,
id_Endereco_M int
); 


DELIMITER $ 

CREATE TRIGGER BKP_MERCADO	
AFTER INSERT ON  mercado
FOR EACH ROW 
BEGIN 
INSERT INTO BKP_mercado.BKP_Mercados VALUES(NULL, NEW.idMercado, NEW.nome, NEW.corredor, NEW.cnpj, NEW.email, NEW.tipo_De_Produto, NEW.quantidade, NEW.id_Marca, NEW.id_Endereco_M); 
END$ 

DELIMITER ;

DELIMITER $

CREATE TRIGGER BKP_MERCADO_Delete	
before delete ON  mercado
FOR EACH ROW 
BEGIN 
INSERT INTO BKP_mercado.BKP_Mercados VALUES(NULL, old.idMercado, old.nome, old.corredor, old.cnpj, old.email, old.tipo_De_Produto, old.quantidade, old.id_Marca, old.id_Endereco_M); 
END$ 

DELIMITER ;

call inserir_Mercado (null,'verdi',1,13541352154645,'verdi@gmail.com','higiene',99,null,1);
call inserir_Mercado (null,'verdi',1,13541352154645,'verdi@gmail.com','omo',30,1,1);
call inserir_Mercado (null,'verdi',1,13541352154645,'verdi@gmail.com','ype',69,1,1);
call inserir_Mercado (null,'verdi',2,13541352154645,'verdi@gmail.com','consumiveis',299,null,1);
call inserir_Mercado (null,'verdi',2,13541352154645,'verdi@gmail.com','nescau',249,4,1);
call inserir_Mercado (null,'verdi',2,13541352154645,'verdi@gmail.com','coca cola',50,4,1);
call inserir_Mercado (null,'verdi',3,13541352154645,'verdi@gmail.com','adega',499,null,1);
call inserir_Mercado (null,'verdi',3,13541352154645,'verdi@gmail.com','vinho do porto',245,7,1);
call inserir_Mercado (null,'verdi',3,13541352154645,'verdi@gmail.com','pergola',253,7,1);
call inserir_Mercado (null,'verdi',4,13541352154645,'verdi@gmail.com','padaria',199,null,1);
call inserir_Mercado (null,'verdi',4,13541352154645,'verdi@gmail.com','pao',99,10,1);
call inserir_Mercado (null,'verdi',4,13541352154645,'verdi@gmail.com','pao de queijo',100,10,1);
call inserir_Mercado (null,'verdi',5,13541352154645,'verdi@gmail.com','ortifruty',246,null,1);
call inserir_Mercado (null,'verdi',5,13541352154645,'verdi@gmail.com','abacaxi',147,13,1);
call inserir_Mercado (null,'verdi',5,13541352154645,'verdi@gmail.com','laranja',99,13,1);
call inserir_Mercado (null,'verdi',6,13541352154645,'verdi@gmail.com','frios',254,null,1);
call inserir_Mercado (null,'verdi',6,13541352154645,'verdi@gmail.com','frango',253,16,1);
call inserir_Mercado (null,'verdi',6,13541352154645,'verdi@gmail.com','carne',47,16,1);


insert into mercado_deposito 
select null, mercado.idMercado, deposito.idDeposito
from mercado 
cross join deposito ;


create view vw_Dados_Mercado
as
select idMercado as identificacao ,nome,cnpj,email 
from mercado;

select * from vw_Dados_Mercado;

create view vw_Dados_Deposito
as
select nome, id_Endereco_d as endereco_Identificacao
from deposito;

select * from vw_Dados_Deposito;


DELIMITER $

CREATE FUNCTION produto_menor()
RETURNS VARCHAR(255) 
DETERMINISTIC 
BEGIN 

    DECLARE produto_tipo VARCHAR(255); 
	
    SELECT CONCAT(m2.tipo_de_produto, ' - ', m2.quantidade,' - ', m1.nome) INTO produto_tipo
    FROM mercado AS m1
    JOIN mercado AS m2 ON m2.id_Marca = m1.idMercado
    ORDER BY m2.quantidade ASC
    LIMIT 1; 

    RETURN produto_tipo; 

END $

DELIMITER ;

select produto_menor();

DELIMITER $

CREATE FUNCTION produto_maior()
RETURNS VARCHAR(255) 
DETERMINISTIC 
BEGIN 

    DECLARE produto_tipo VARCHAR(255); 
	
    SELECT CONCAT(m2.tipo_de_produto, ' - ', m2.quantidade,' - ', m1.nome) INTO produto_tipo
    FROM mercado AS m1
    JOIN mercado AS m2 ON m2.id_Marca = m1.idMercado
    ORDER BY m2.quantidade desc
    LIMIT 1; 

    RETURN produto_tipo; 

END $

DELIMITER ;

select produto_maior();