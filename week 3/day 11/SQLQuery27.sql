create table sales(
salesid int primary key,
employee varchar(50),
month varchar(50),
amount decimal(10,2)
);

insert into sales
(salesid, employee, month, amount) values
(1, 'Amit', 'Jan', 1000),
(2, 'Amit', 'Feb', 2000),
(3, 'Amit', 'Mar', 3000),
(4, 'Priya', 'Jan', 1500),
(5, 'Priya', 'Feb', 2500),
(6, 'Priya', 'Mar', 3500),
(7, 'Rahul', 'Jan', 3000),
(8, 'Rahul', 'Feb', 3500),
(9, 'Rahul', 'Mar', 4000);