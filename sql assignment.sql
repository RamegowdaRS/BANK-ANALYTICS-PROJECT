# assignment 1
select *from employees;
select employeeNumber,firstName,lastName from employees where reportsTo=1102 and jobTitle='Sales Rep';
select *from products;
select distinct productline from products where productline like '% Cars';

# assignment 2
select *from customers;
select customerNumber,customerName, 
case when country in ('USA','Canada') then "North America" 
when country in ('France','Germany','UK') then "Europe" 
else "Other" end as Customersegment from customers;

# assignment 3
select *from orderdetails;
select productcode, sum(quantityordered) as total_ordered from orderdetails group by productcode having count(*)>10 order by total_ordered desc;
select *from payments;
select monthname(paymentdate) as payment_month,count(*) as num_payments from payments 
group by payment_month 
having count(*)>20 
order by num_payments desc; 

# assignment 4
create database Customers_Oders;
create table Customers(customer_id int unique auto_increment, first_name varchar(50) not null, last_name varchar(50) not null, email varchar(255) unique, phone_number varchar(20),primary key (customer_id));
select *from customers;
create table orders(order_id int unique auto_increment, customer_id int,order_date date,total_amount decimal(10,2) check(total_amount>0),primary key(order_id),foreign key(customer_id) references customers(customer_id));
select *from orders;

# assignment 5
select *from customers;
select *from orders;
select country,count(*) as order_count from customers 
join orders on customers.customernumber=orders.customerNumber 
group by country order by count(*) desc limit 5;

# assignment 6
create table project(EmployeeID int unique auto_increment,FullName varchar(50) not null,gender varchar(10),ManagerID int,check(gender in('male','female'))); 
insert into project values(1,'pranaya','male',3),(2,'priyanka','female',1),(3,'preety','female',null),(4,'anurag','male',1),(5,'sambit','male',1),(6,'rajesh','male',3),(7,'hina','female',3);
select *from project;
select manager.fullname as manager_name,projects.FullName as emp_name from project as projects inner join project as manager on projects.ManagerID=manager.EmployeeID;

# assignment 7
create table facility(facilityID int not null,Name varchar(100),state varchar(100),country varchar(100));
select *from facility;
alter table facility modify facilityID int auto_increment primary key;
alter table facility add column city varchar(100) not null after Name;
desc facility;

# assignment 8
select *from productlines;
select *from orders;
select *from orderdetails;
select *from products;
create view product_category_sales as 
select productLine,sum(orderdetails.quantityOrdered*orderdetails.priceEach) as total_sales,count(orderdetails.orderNumber) as number_of_orders 
from productlines 
inner join (products inner join orderdetails on products.productCode=orderdetails.productCode) on productlines.productLine=products.productLine 
group by products.productLine 
order by productlines.productLine;
select *from product_category_sales;

# assignment 9
select *from customers;
select *from payments;
#procedure
SELECT YEAR(paymentDate) AS Year, country AS Country, 
CONCAT(FORMAT(SUM(amount)/1000, 0), 'K') AS 'Total Amount' 
FROM Payments JOIN Customers  ON payments.customerNumber = Customers.customerNumber 
WHERE YEAR(paymentDate) = inputYear AND country = inputCountry group by year, country;
call classicmodels.get_country_payments(2004, 'france');

# assignment 10,a
select *from orders;
select *from customers;
select customername,count(*), rank() over(order by count(*) desc) as order_frequency_rnk from customers as a inner join orders as b on a.customerNumber=b.customerNumber group by a.customerNumber;  

# assignment 10,b
with x as (
select 
year(orderdate) as year,
monthname(orderdate) as month,
count(orderdate) as total_orders 
from orders 
group by year,month
)
select 
year,
month,
total_orders as 'Total orders',
concat(
round(
100*(
(total_orders - LAG(total_orders) over (order by year)) / LAG(total_orders)over(order by year)
),
0
),
'%')as 
"% YOY changes"
from
x;


# assignment 11
select *from products;
select productline,count(buyPrice) as total from products 
where buyPrice>(select avg(buyPrice) from products) 
group by productLine order by count(*) desc;

# assignment 12
create table Emp_EH(EmpID int,EmpName varchar(50) not null,emailaddress varchar(100),primary key(EmpID));
call customers_oders.empEH(2, null, 'cde@gmail.com');

create table fraud(id int not null auto_increment,EmpID int,message varchar(255),time_of_fraud datetime,primary key(id));
call customers_oders.proc_fraud(2, 'bcd', 'bcd@gmail.com');
call customers_oders.proc_fraud(3, null, 'cde@gmail.com');
select *from emp_eh;
#procedure
#CREATE DEFINER=`root`@`localhost` PROCEDURE `empEH`(eid int, empnm varchar(50),emailadd varchar(100))
#BEGIN
#insert into emp_eh values(eid,empnm,emailadd);
#END;

# assignment 13
create table Emp_BIT(name varchar(100),occupation varchar(100),working_date date,working_hours int);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);
select *from emp_bit;
INSERT INTO Emp_BIT VALUES('Aonio', 'Biness', '2020-11-04', -11);


