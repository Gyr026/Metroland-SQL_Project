create database UAS_DB
go
use UAS_DB
go

CREATE TABLE ToyType (
ToyTypeID char(5) NOT NULL CHECK(ToyTypeID like 'TT[0-9][0-9][0-9]'), 
ToyTypeName varchar(255) NOT NULL, 
PRIMARY KEY (ToyTypeID));

CREATE TABLE Staff (
StaffID char(5) NOT NULL CHECK(StaffID like 'ST[0-9][0-9][0-9]'), 
StaffName varchar(255) NOT NULL, 
StaffPhone varchar(255) NOT NULL, 
StaffEmail varchar(255) NOT NULL, 
PRIMARY KEY (StaffID));

CREATE TABLE Supplier (
SupplierID char(5) NOT NULL CHECK(SupplierID like 'SP[0-9][0-9][0-9]'), 
SupplierName varchar(255) NOT NULL, 
SupplierPhone varchar(255) NOT NULL, 
SupplierEmail varchar(255) NOT NULL, 
PRIMARY KEY (SupplierID));

CREATE TABLE Customer (
CustomerID char(5) NOT NULL CHECK(CustomerID like 'CS[0-9][0-9][0-9]'), 
CustomerName varchar(255) NOT NULL, 
CustomerPhone varchar(255) NOT NULL, 
CustomerEmail varchar(255) NOT NULL, 
PRIMARY KEY (CustomerID));

CREATE TABLE PurchaseTransaction (
PurchaseID char(5) NOT NULL CHECK(PurchaseID like 'PA[0-9][0-9][0-9]'), 
StaffID char(5) FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL, 
SupplierID char(5) FOREIGN KEY REFERENCES Supplier(SupplierID) NOT NULL, 
PurchasedDate date NOT NULL, 
PRIMARY KEY (PurchaseID));

CREATE TABLE SalesTransaction (
SalesID char(5) NOT NULL CHECK(SalesID like 'SA[0-9][0-9][0-9]'), 
StaffID char(5) FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL, 
CustomerID char(5) FOREIGN KEY REFERENCES Customer(CustomerID) NOT NULL, 
SalesDate date NOT NULL, 
PRIMARY KEY (SalesID));

CREATE TABLE Toy (
ToyID char(5) NOT NULL CHECK(ToyID like 'TY[0-9][0-9][0-9]'), 
ToyTypeID char(5) FOREIGN KEY REFERENCES ToyType(ToyTypeID) NOT NULL, 
ToyName varchar(255) NOT NULL, 
PRIMARY KEY (ToyID));

CREATE TABLE PurchaseTransactionDetail (
PurchaseID char(5) FOREIGN KEY REFERENCES PurchaseTransaction(PurchaseID) NOT NULL, 
ToyID char(5) FOREIGN KEY REFERENCES Toy(ToyID) NOT NULL, 
QtyPurchased int NOT NULL, 
PurchasePrice int NOT NULL, 
PRIMARY KEY (PurchaseID, ToyID));

CREATE TABLE SalesTransactionDetail (
SalesID char(5) FOREIGN KEY REFERENCES SalesTransaction(SalesID) NOT NULL, 
ToyID char(5) FOREIGN KEY REFERENCES Toy(ToyID) NOT NULL, 
QtySold int NOT NULL, 
SalesPrice int NOT NULL, 
PRIMARY KEY (SalesID, ToyID));

insert into ToyType values
('TT001', 'Action Figure'),
('TT002', 'RC-Cars'),
('TT003', 'Portable Console'),
('TT004', 'Board Game')

insert into Staff values
('ST001', 'Usman Nainggolan', '0-21-315-4855', 'metroland@gmail.co.id'),
('ST002', 'Oni Zulaika', '0-21-691-1090', 'metroland@gmail.co.id'),
('ST003', 'Sidiq Budiman', '0-21-661-4712', 'metroland@gmail.co.id'),
('ST004', 'Mursinin Suwarno', '0-21-769-7441', 'metroland@gmail.co.id'),
('ST005', 'Hamima Mandasari', '0-21-351-1522', 'metroland@gmail.co.id')

insert into Supplier values
('SP001', 'Syarif Afonzo', '0-21-470-1479', 'syarif_afonzo@gmail.com'),
('SP002', 'Prima Irawan', '0-21-470-4107', 'prima_irawan@gmail.com'),
('SP003', 'Patricia Lestari', '0-22-601-5762', 'patricia_lestari@gmail.com'),
('SP004', 'Zahra Purnawati', '0-21-522-1255', 'zahra_purnawati@gmail.com'),
('SP005', 'Diana Novitasari', '0-21-472-2820', 'diana_novitasari@gmail.com')

insert into Customer values
('CS001', 'Ibun Rajata', '0-21-566-6693', 'ibun_rajata@gmail.com'),
('CS002', 'Lena Rahmawati', '0-21-585-0243', 'lena_rahmawati@gmail.com'),
('CS003', 'Umi Utami', '0-21-720-7576', 'umi_utami@gmail.com')

insert into Toy values
('TY001', 'TT001', 'Figur Superman'),
('TY002', 'TT002', 'WL Toys RC Car'),
('TY003', 'TT003', 'Gameboy Advance'),
('TY004', 'TT004', 'Monopoly'),
('TY005', 'TT004', 'Ular Tangga')

insert into PurchaseTransaction values
('PA001', 'ST001', 'SP001', '2021-10-23'),
('PA002', 'ST002', 'SP002', '2021-11-10'),
('PA003', 'ST003', 'SP003', '2021-11-15'),
('PA004', 'ST004', 'SP004', '2021-12-07'),
('PA005', 'ST005', 'SP005', '2021-12-28')

insert into SalesTransaction values
('SA001', 'ST001', 'CS001', '2022-01-05'),
('SA002', 'ST002', 'CS002', '2022-02-15'),
('SA003', 'ST004', 'CS003', '2022-03-14')

insert into PurchaseTransactionDetail values
('PA001', 'TY001', '20', '43500'),
('PA002', 'TY002', '10', '105000'),
('PA003', 'TY003', '5', '675000'),
('PA004', 'TY004', '20', '50000'),
('PA005', 'TY005', '15', '35000')

insert into SalesTransactionDetail values
('SA001', 'TY004', '5', '65000'),
('SA002', 'TY003', '1', '725000'),
('SA003', 'TY002', '2', '130000')

--no 6
select std.QtySold, t.ToyTypeID, ptd.PurchasePrice, std.SalesPrice,
[Profit for each type] = std.SalesPrice - ptd.PurchasePrice,
[Profitability Percentage] = concat(left((
cast(std.SalesPrice as float) - cast(ptd.PurchasePrice as float)) 
/ cast(PurchasePrice as float) * 100, '4'), '%')
from SalesTransactionDetail std
join Toy t on std.ToyID = t.ToyID
join PurchaseTransactionDetail ptd on t.ToyID = ptd.ToyID

--no 7
select ToyID, ToyName
from Toy
where not exists
(
	select ToyID
	from SalesTransactionDetail std
	join SalesTransaction st on std.SalesID = st.SalesID
	where std.ToyID = Toy.ToyID
	and month(st.SalesDate) between 1 and 3
)

--no 8
go
create view DisplayCustomerData as
select CustomerName, CustomerPhone
from Customer
go

select * from DisplayCustomerData