-- KPI

select sum(total_price) as Total_Revenue from pizza_sales;

select round(sum(total_price)/count(distinct order_id),2) as avg_order_value from pizza_sales;

select sum(quantity) as total_pizza_sold from pizza_sales;

select count(distinct order_id) from pizza_sales;

select count(quantity)/ count(distinct order_id) as avg_quantity_per_order from pizza_sales;



-- order by day
set datefirst 1;

select COUNT(distinct order_id) as order_count,datename(WEEKDAY,order_date) as weekday from pizza_sales
group by datepart(WEEKDAY,order_date),datename(WEEKDAY,order_date)
order by datepart(WEEKDAY,order_date);

-- monthly-year order trend
select  count(distinct order_id) as total_order, format(order_date, 'MM-yyyy') as order_date from pizza_sales
group by format(order_date, 'MM-yyyy')
order by order_date;

-- monthly order trend
select  count(distinct order_id) as total_order, datename(MONTH, order_date) as order_month from pizza_sales
group by datename(MONTH, order_date), month(order_date)
order by month(order_date);

-- percentage pizza category
select pizza_category,
cast(
	sum(total_price)/(select sum(total_price) from pizza_sales)*100
	as decimal(10,2)
	) as pct
from pizza_sales 
group by pizza_category

-- percentage pizza size
select pizza_size,
cast(
	sum(total_price)/(select sum(total_price) from pizza_sales)*100
	as decimal(10,2)
	) as pct
from pizza_sales 
group by pizza_size
order by pct desc

-- top 5 best sellers by revenue
select top 5 pizza_name, sum(total_price) as total_revenue from pizza_sales 
group by pizza_name order by total_revenue desc

-- bottom 5 best sellers by price
select top 5 pizza_name, sum(total_price) as total_revenue from pizza_sales 
group by pizza_name order by total_revenue

-- top 5 best sellers by orders
select top 5 pizza_name, sum(quantity) as total_orders from pizza_sales 
group by pizza_name order by total_orders desc

-- bottom 5 best sellers by orders
select top 5 pizza_name, sum(quantity) as total_orders from pizza_sales 
group by pizza_name order by total_orders

