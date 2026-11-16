create table factsales(
salesid int primary key,
productid int,
customerid int,
quantity int,
amount decimal(10,2)
);

insert into factsales(salesid,productid,customerid,quantity,amount) values
(1, 101, 1, 2, 100000),
(2, 102, 2, 3, 60000),
(3, 103, 3, 4, 20000),
(4, 104, 4, 2, 30000),
(5, 101, 2, 1, 50000),
(6, 102, 3, 2, 40000);