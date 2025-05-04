create database Project1;
use Project1;

create table retail_sales(
Order_date date,
Region varchar(20),
Product_Id varchar(20),
Category varchar(20),
sub_category varchar(20),
Sales float,
profit float,
Inventory_Days float
);

select count(*) from retail_sales;

-- Data Cleaning 
select * from retail_sales where sales = '0';

SET SQL_SAFE_UPDATES = 0;
delete from retail_sales where sales='0';

-- profit margin by category
select
	category,
    sum(sales) as Total_sales,
    sum(profit) as Total_profit,
    round(sum(profit) / nullif( sum(sales) , 0) , 4) as profit_margin
from retail_sales
group by category
order by profit_margin asc;

-- Profit margin by sub-category
select
	sub_category,
    sum(sales) as Total_sales,
    sum(profit) as Total_profit,
    round(sum(profit) / nullif(sum(sales) , 0), 4) as Profit_margin
from retail_sales
group by category,sub_category
order by profit_margin asc;

-- Inventory Trunover.
select 
	category,
    sub_category,
    round(avg(Inventory_days), 2) as avg_Inventory_days
from retail_sales
group by category,sub_category
order by Avg_Inventory_days desc;

-- Month Seasonality.
select 
	category,
    month(order_date) as sale_Month,
    sum(sales) as Monthly_sales
from retail_sales
group by category,month(order_date)
order by category, sale_month;
-- regional performance.
select 
	region,
    category,
    sum(sales) as Total_sales,
    sum(profit) as Total_profit,
    round(sum(profit) / nullif(sum(sales) , 0) , 4) as Profit_Margin
from retail_sales
group by region, category
order by region, profit_margin;

-- top region performance
select 
	region,
    sum(sales) as total_sales
from retail_sales
group by region
order by total_sales desc;