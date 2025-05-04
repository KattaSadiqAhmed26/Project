create database website;
use website;

create table return_rate
(
Return_Id varchar(15),
Order_Id varchar(15),
Customer_Id varchar(15),
Product_Name text,
Category text,
Geography text,
Marketing_Channel varchar(20),
Return_Reason varchar(15)
);

select * from return_rate;

-- Data Cleaning Process
select * from return_rate where Return_reason = 'Null';

-- Business Insight Questions.
-- 1. Which product categories have the highest return rates?
create view Product_count as 
select Category,count(*) as Return_count from return_rate
group by category
order by return_count desc;
select * from Product_count;

-- 2. What are the top 5 most frequently cited return reasons?
create view frequency as 
select return_reason,count(*) as Frequency from return_rate
group by return_reason
order by Frequency desc
limit 5;
select * from frequency;

-- 3. Which marketing channels are associated with the most returns?
create view channel as 
select Marketing_channel,count(*) as Return_count from return_rate
group by Marketing_Channel
order by return_count desc;
select * from channel;

-- 4. Which geography has the highest volume of returns per category?
create view Return_by_Geography as 
select Geography,category,count(*) as Return_Count 
from return_rate
group by Geography,Category
order by Return_count desc;
select * from Return_by_Geography;

-- 5. Which countries or regions most often report “Item defective or damaged”?
create view Return_by_damage as 
select Geography,Return_reason,count(*) as Return_Count
from return_rate
where Return_reason = 'Item defective or damaged'
group by Geography
order by Return_Count desc;
select * from Return_by_damage;

-- 6. Which top 10 products are returned most frequently?
create view return_by_Product_name as
select Product_Name,Category,count(*) as return_count
from return_rate
group by Product_Name,category
order by return_count desc
limit 10;
select * from return_by_Product_name;

-- 7. Do certain products get returned more often for specific reasons?
create view Specific_reason as 
select Product_Name,Return_Reason,count(*) as count
from return_rate
group by Product_Name,Return_reason
order by count desc;
select * from specific_reason;

-- 8. Which customers have the highest number of returns?
create view top_customers as 
select customer_Id,count(*) as Return_count
from return_rate
group by Customer_Id
order by Return_count desc
limit 10;
select * from top_customers;

-- 9. Is there a pattern in return reasons based on marketing channel?
create view Marketing_channel_pattern as 
select Marketing_channel, Return_reason, count(*) as frequency
from return_rate
group by Marketing_channel, return_reason
order by Marketing_channel, frequency desc;
select * from Marketing_channel_pattern;

-- 10. Do return reasons vary significantly across product categories?
create view Category_Pattern as
select category,Return_reason,count(*) as Return_count
from return_rate
group by Category, return_reason
order by Category, return_count desc;
select * from Category_Pattern;