--create books table
drop table if exists books;
create table books
(Book_ID int primary key,	
Title varchar(100),
Author varchar(100),	
Genre varchar(50),
Published_Year int,	
Price numeric (10,2),
Stock int);
select *from books;

--create customer table
drop table if exists customer;
create table customer
(Customer_ID int primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),	
City varchar(100),
Country varchar(100));
select *from customer;

--create order table
drop table if exists orders;
create table orders 
(Order_ID int primary key,
Customer_ID	int references customer(Customer_ID	),
Book_ID	int references books(Book_ID),
Order_Date date,
Quantity int,	
Total_Amount numeric(10,2)
);
select *from orders;

--basic questions

-- 1) Retrieve all books in the "Fiction" genre:
select*from books
where genre='Fiction';

-- 2) Find books published after the year 1950:
select  * from books
where published_year>1950;

--3)List all customers from the Canada:
select*from customer
where country='Canada';

--4)Show orders placed in November 2023:
select*from orders
where order_date between '2023-10-1' and '2023-10-30';

-- 5) Retrieve the total stock of books available:
select sum (stock) from books;

-- 6) Find the details of the most expensive book:
select *from books
order by price desc 
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders 
where quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select*from orders
where total_amount >20;

-- 9) List all genres available in the Books table:
select genre from books;

-- 10) Find the book with the lowest stock
select * from books
order by  stock asc
limit 1;
-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount)from orders;

--Advance questions

-- 1) Retrieve the total number of books sold for each genre:
select b.genre,sum(o.quantity)as total_book_sold
from orders o
join books b
on b.book_id=o.book_id
group by b.genre;

--Find the average price of books in the "Fantasy" genre:
select avg(price) as avg_price_book from books
where genre ='Fantasy';

-- 3) List customers who have placed at least 2 orders:
select customer_id ,count(order_id) from orders
group by customer_id 
having count(order_id)>=2;

-- 4) Find the most frequently ordered book:
select b.title ,o.book_id ,count(o.order_id) as order_count
from orders o
join books b
on b.book_id=o.book_id
group by b.title, o.book_id 
order by order_count desc 
limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books 
where genre='Fantasy'
order by price desc 
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author ,b.book_id,count(o.quantity)as book_sold
from orders o
join books b
on b.book_id=o.book_id
group by  b.author ,b.book_id; 

-- 7) List the cities where customers who spent over $30 are located:
select city ,total_amount
from orders o
join customer c
on o.customer_id =c.customer_id
where total_amount>30; 

-- 8) Find the customer who spent the most on orders:
select c.name ,sum(total_amount)as most_expensive 
from orders o
join customer c
on c.customer_id= o.customer_id
group  by c.name 
order by most_expensive desc;















