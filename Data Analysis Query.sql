Select * from df_orders;


--Ques1  Find top 10 highest revenue generating products 
Select top 10 product_id, sum(sale_price) as revenue 
from df_orders
group by (product_id)
order by revenue desc;

--Ques 2 Find top 5 highest selling products in each region
with region_group as (
Select region, product_id , sum(sale_price) as revenue
from df_orders
group by region, product_id
), region_partion as (
Select *, ROW_NUMBER () over (partition by region order by revenue desc) as ranking
from region_group)
Select * from region_partion
where ranking <=5;

--Ques 3. Find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
with cte1 as (
Select (datepart (year, order_date)) as order_year, (datepart (month, order_date)) as order_month, sum(sale_price) as sales  from df_orders
group by (datepart (year, order_date)) , (datepart (month, order_date)) 
--order by order_year, order_month 
)
Select order_month
, sum (case when order_year = 2022 then sales else 0 end)  as sales_2022
, sum (case when order_year = 2023 then sales else 0 end) as sales_2023
, (((sum (case when order_year = 2023 then sales else 0 end)) - (sum (case when order_year = 2022 then sales else 0 end)))/ (sum (case when order_year = 2022 then sales else 0 end)))*100 as percentage_growth
from cte1 
group by order_month
order by order_month;

--Ques 4 For each category which month had highest sales
with cte2 as
(Select category , format(order_date,'yyyyMM') as order_yy_mm , sum(sale_price) as sales
from df_orders
group by category,  format(order_date,'yyyyMM')),
cte3 as (
Select *,
ROW_NUMBER () over (partition by category order by sales desc) as rn
from cte2 )
Select * from cte3
where rn =1;

--Ques 5 Which sub category had highest growth by profit in 2023 compare to 2022
with cte1 as (
Select sub_category, year (order_date) as order_year, sum(profit) as order_profit
from df_orders
group by sub_category, year (order_date) ),
cte2 as (
Select sub_category,
sum(case when order_year= 2022 then order_profit else 0 end) as profit_2022,
sum(case when order_year= 2023 then order_profit else 0 end) as profit_2023
from cte1
group by sub_category, order_year)
Select top 1 *, (profit_2023 - profit_2022) as profit_diff from cte2
order by (profit_2023 - profit_2022) desc


---Ques 6 Which sub category had highest growth by sales in 2023 compare to 2022
with cte as (
select sub_category,year(order_date) as order_year,
sum(sale_price) as sales
from df_orders
group by sub_category,year(order_date)
--order by year(order_date),month(order_date)
	)
, cte2 as (
select sub_category
, sum(case when order_year=2022 then sales else 0 end) as sales_2022
, sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte 
group by sub_category
)
select top 1 *
,(sales_2023-sales_2022) as sales_diff
from  cte2
order by (sales_2023-sales_2022) desc

