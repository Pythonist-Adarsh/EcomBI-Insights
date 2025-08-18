create database ecommerce;
use ecommerce

select * from ecom_data
-- check for duplicates
select ID,COUNT(*) from ecom_data
group by ID having COUNT(*)>1
--Shipment mode distribution
select Mode_of_Shipment,COUNT(*) as shipment_count from ecom_data group by Mode_of_Shipment
order by Mode_of_Shipment desc

-- warehouse block distribution
select Warehouse_block,COUNT(*) as shipment_count from ecom_data group by Warehouse_block
--Delay rate per warehouse
select Warehouse_block,AVG(1-Reached_on_Time_Y_N) as Avg_delay_rate from ecom_data group by Warehouse_block
--Avg product cost per importance
select Product_importance,AVG(Cost_of_the_Product) as average_product_cost from ecom_data
group by Product_importance

--Complaints vs delivery
select Customer_care_calls,AVG(Reached_on_Time_Y_N) as average_time_Y_N from ecom_data
group by Customer_care_calls

--Discount vs delay
select Discount_offered,AVG(1-Reached_on_Time_Y_N) as average_discount_offer from ecom_data
group by Discount_offered
--SELECT Discount_offered, AVG(1 - Reached_on_Time_Y_N) as delayed FROM ecom_data GROUP BY Discount_offered;

----Analyze the distribution of warehouse blocks:
select Warehouse_block,COUNT(*) as warehous_block
from ecom_data
group by Warehouse_block
order by Warehouse_block desc;

----Customer Rating Distribution
select Customer_rating,COUNT(*) as rating  
from ecom_data
group by  Customer_rating 
order by Customer_rating Asc

----Product Importance
select Product_importance,COUNT(*) as count_importence
from ecom_data
group by Product_importance
order by Product_importance

-- gender disribution
select Gender,COUNT(*) as gender_distribution
from ecom_data
group by Gender
order by gender_distribution desc

-- --On-Time vs. Late Deliveries
select Reached_on_Time_Y_N,COUNT(*) as on_time
from ecom_data
group by Reached_on_Time_Y_N

----Average Discount by Delivery Status
select Reached_on_Time_Y_N,AVG(Discount_offered) as average_dicount
from ecom_data
group by Reached_on_Time_Y_N

----Average Product Cost by Delivery Status
select Reached_on_Time_Y_N,AVG(Cost_of_the_Product) as average_product
from ecom_data
group by Reached_on_Time_Y_N



 --High-Risk Warehouse Blocks
select Warehouse_block,
round(SUM(Reached_on_Time_Y_N)*100.0 /COUNT(*),1) as delayedpercentage
from ecom_data
group by Warehouse_block
order by delayedpercentage
 --Shipment Mode with Most Delays
select Mode_of_Shipment,
round(SUM(Reached_on_Time_Y_N)*100.0 /COUNT(*),1) as shipment_mode
from ecom_data
group by Mode_of_Shipment
order by shipment_mode desc

--Correlation Between Discounts and Delays
select Reached_on_Time_Y_N,
AVG(Discount_offered) as average_discount,
AVG(Cost_of_the_Product) as averageCostByProduct,
AVG(Weight_in_gms) as average_weight
from ecom_data
group by Reached_on_Time_Y_N

--Cost vs. Rating Analysis
select Customer_rating,
AVG(Cost_of_the_Product)
from ecom_data
group by Customer_rating
order by Customer_rating

----Average Customer Rating by Warehouse
select Warehouse_block,
AVG(Customer_rating) as AvgRating
from ecom_data
group by Warehouse_block
order by AvgRating

--Delays by Shipment Mode
select  Mode_of_Shipment,
COUNT(*) NoOfShipment,
SUM(Reached_on_Time_Y_N) as DelayedSum,
round(SUM(Reached_on_Time_Y_N)*100.0/COUNT(*),2) as DelayedPercent
from ecom_data
group by Mode_of_Shipment
order by DelayedPercent desc

--Correlation Between Customer Care Calls and Delays
select Customer_care_calls,
COUNT(*) as totalorders,
SUM(case when Reached_on_Time_Y_N=1 then  1 else 0 end) as Delays,
round(SUM(case when Reached_on_Time_Y_N=1 then  1 else 0 end)*100.0 /COUNT(*),2) as DelaysPercent
FROM ecom_data
group by Customer_care_calls
order by Customer_care_calls



----Impact of Prior Purchases on Delivery Time
select Prior_purchases,
COUNT(*) as totalPrior,
SUM(case when Reached_on_Time_Y_N=1 then  1 else 0 end) as PriorPurchases,
round(SUM(case when Reached_on_Time_Y_N=1 then  1 else 0 end)*100.0/COUNT(*),2) as PriorPurchasesPercent
from ecom_data
group by Prior_purchases
order by Prior_purchases

--Combining Shipment Mode and Product Importance
select 
Mode_of_Shipment,
Product_importance,COUNT(*) as TotalShipments,
SUM(case when Reached_on_Time_Y_N=1 then 1 else 0 end) as totalDelayed,
round(SUM(case when Reached_on_Time_Y_N=1 then 1 else 0 end)*100.0/COUNT(*),2) as totalDelayedpercent
from ecom_data
group by Mode_of_Shipment,Product_importance
order by totalDelayedpercent desc


























































select * from ecom_data











