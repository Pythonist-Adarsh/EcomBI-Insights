# EcomBI-Insights
E-commerce Shipping Analysis project using SQL &amp; Power BI to explore customer behavior, shipping performance, and revenue trends. The dashboard tracks KPIs like orders, revenue, delivery status, and ratings, offering insights to optimize logistics, improve customer satisfaction, and boost efficiency.

# 📦 E-Commerce Shipping Data Analysis (SQL + Power BI)

Welcome to this **data analytics project**! 🚀  
This project analyzes **E-commerce shipping data** using **SQL for data preprocessing** and **Power BI for visualization**.  
The goal is to identify patterns, highlight operational bottlenecks, and provide **business insights** for improving logistics and customer satisfaction.  

---

## 📌 Project Overview
This project focuses on identifying **key patterns and trends** in shipping data:  
- ✅ Data Cleaning and Preprocessing with SQL  
- ✅ Shipment Mode and Warehouse Analysis  
- ✅ Customer Ratings, Care Calls, and Delay Analysis  
- ✅ Product Cost, Discounts, and Importance Insights  
- ✅ Power BI Dashboards for business decision-making  

---

## 📂 Dataset Description
Dataset sourced from **Kaggle – EDA: E-commerce Shipping Data**  
- **Rows:** 10,999  
- **Columns:** 12  

**Key Features:**
- `ID` – Unique identifier for each customer  
- `Warehouse Block` – Blocks A, B, C, D, E  
- `Mode of Shipment` – Ship, Flight, Road  
- `Customer Care Calls` – Support calls count  
- `Customer Rating` – Scale 1 to 5  
- `Cost of the Product` – USD value  
- `Prior Purchases` – Count of previous purchases  
- `Product Importance` – Low, Medium, High  
- `Gender` – Male / Female  
- `Discount Offered` – Discount applied  
- `Weight in Grams` – Product weight  
- `Reached on Time` – Delivery status (0 = On-time, 1 = Delayed)  

---

## 🏗️ Step-by-Step Guidelines  

### 🔎 Check for Duplicates
```sql
SELECT ID, COUNT(*) 
FROM ecom_data
GROUP BY ID HAVING COUNT(*) > 1;
```
### Shipment Mode Distribution
```sql
SELECT Mode_of_Shipment, COUNT(*) AS shipment_count 
FROM ecom_data 
GROUP BY Mode_of_Shipment;
```
### Warehouse Block Distribution
```sql
SELECT Warehouse_block, COUNT(*) AS shipment_count 
FROM ecom_data 
GROUP BY Warehouse_block;
```
### Delay Rate per Warehouse
```sql
SELECT Warehouse_block, AVG(1-Reached_on_Time_Y_N) AS Avg_delay_rate 
FROM ecom_data 
GROUP BY Warehouse_block;

```
### Average Product Cost by Importance
```sql
SELECT Product_importance, AVG(Cost_of_the_Product) AS average_product_cost 
FROM ecom_data 
GROUP BY Product_importance;
```
### Complaints vs Delivery
```sql
SELECT Customer_care_calls, AVG(Reached_on_Time_Y_N) AS average_time_Y_N 
FROM ecom_data 
GROUP BY Customer_care_calls;
```
### Discount vs Delay
```sql
SELECT Discount_offered, AVG(1-Reached_on_Time_Y_N) AS average_discount_offer 
FROM ecom_data 
GROUP BY Discount_offered;
```

### Customer Rating Distribution
```sql
SELECT Customer_rating, COUNT(*) AS rating  
FROM ecom_data 
GROUP BY Customer_rating 
ORDER BY Customer_rating ASC;
```
### Product Importance Distribution
```sql
SELECT Product_importance, COUNT(*) AS count_importance 
FROM ecom_data 
GROUP BY Product_importance 
ORDER BY Product_importance;
```

### Gender Distribution
```sql
SELECT Gender, COUNT(*) AS gender_distribution 
FROM ecom_data 
GROUP BY Gender 
ORDER BY gender_distribution DESC;
```

### On-Time vs Late Deliveries
```sql
SELECT Reached_on_Time_Y_N, COUNT(*) AS total 
FROM ecom_data 
GROUP BY Reached_on_Time_Y_N;
```

### Average Discount by Delivery Status
```sql
SELECT Reached_on_Time_Y_N, AVG(Discount_offered) AS average_discount 
FROM ecom_data 
GROUP BY Reached_on_Time_Y_N;
```

### Average Product Cost by Delivery Status
```sql
SELECT Reached_on_Time_Y_N, AVG(Cost_of_the_Product) AS average_product 
FROM ecom_data 
GROUP BY Reached_on_Time_Y_N;
```

### Shipment Mode with Most Delays
```sql
SELECT Mode_of_Shipment,
       ROUND(SUM(Reached_on_Time_Y_N)*100.0 /COUNT(*),1) AS shipment_delay_percentage
FROM ecom_data
GROUP BY Mode_of_Shipment
ORDER BY shipment_delay_percentage DESC;
```
### Correlation Between Discounts and Delays
```sql
SELECT Reached_on_Time_Y_N,
       AVG(Discount_offered) AS average_discount,
       AVG(Cost_of_the_Product) AS average_cost,
       AVG(Weight_in_gms) AS average_weight
FROM ecom_data
GROUP BY Reached_on_Time_Y_N;
```

### Cost vs Rating Analysis
```sql
SELECT Customer_rating, AVG(Cost_of_the_Product) 
FROM ecom_data 
GROUP BY Customer_rating 
ORDER BY Customer_rating;
```

### Delays by Shipment Mode
```sql
SELECT Mode_of_Shipment,
       COUNT(*) AS NoOfShipment,
       SUM(Reached_on_Time_Y_N) AS DelayedSum,
       ROUND(SUM(Reached_on_Time_Y_N)*100.0/COUNT(*),2) AS DelayedPercent
FROM ecom_data
GROUP BY Mode_of_Shipment
ORDER BY DelayedPercent DESC;
```

### Customer Care Calls vs Delays
```sql
SELECT Customer_care_calls,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN Reached_on_Time_Y_N=1 THEN 1 ELSE 0 END) AS Delays,
       ROUND(SUM(CASE WHEN Reached_on_Time_Y_N=1 THEN 1 ELSE 0 END)*100.0 /COUNT(*),2) AS DelaysPercent
FROM ecom_data
GROUP BY Customer_care_calls
ORDER BY Customer_care_calls;

```

### Prior Purchases Impact on Delivery
```sql
SELECT Prior_purchases,
       COUNT(*) AS totalPrior,
       SUM(CASE WHEN Reached_on_Time_Y_N=1 THEN 1 ELSE 0 END) AS PriorPurchases,
       ROUND(SUM(CASE WHEN Reached_on_Time_Y_N=1 THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS PriorPurchasesPercent
FROM ecom_data
GROUP BY Prior_purchases
ORDER BY Prior_purchases;

```
### Shipment Mode & Product Importance Combined
```sql
SELECT Mode_of_Shipment,
       Product_importance,
       COUNT(*) AS TotalShipments,
       SUM(CASE WHEN Reached_on_Time_Y_N=1 THEN 1 ELSE 0 END) AS totalDelayed,
       ROUND(SUM(CASE WHEN Reached_on_Time_Y_N=1 THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS totalDelayedPercent
FROM ecom_data
GROUP BY Mode_of_Shipment, Product_importance
ORDER BY totalDelayedPercent DESC;
```
## Power BI Dashboard

The interactive dashboard highlights:
1)Total Orders & Revenue
2)Shipment Mode & Warehouse Insights
3)Delivery Status (On-time vs Delayed)
4)Customer Ratings & Complaints
5)Discounts vs Delivery Delays

![Dashboard preview screenshot]<img width="1361" height="759" alt="Screenshot (161)" src="https://github.com/user-attachments/assets/bd763af0-c1b0-4a2c-89b9-b75c5f47197e" />
![Dashboard preview screenshot]<img width="1331" height="753" alt="Screenshot (160)" src="https://github.com/user-attachments/assets/693a0927-ee46-4d57-be58-bf8266e142ac" />

# Business Value
*) Identify high-risk warehouses & shipment modes
*) Improve customer satisfaction through rating insights
*) Optimize discount strategies to reduce delays
*) Enhance supply chain efficiency using data

## Show Support
If this project helped you learn, give it a star ⭐ on GitHub and share it with others!
Developed by Adarsh Tiwari 

---

✅ This is a **single complete README.md file** containing:  
- Context (Overview, Dataset)  
- ALL SQL insights from your Word file  
- Power BI Dashboard placeholders  
- Business Value & Conclusion  

Do you want me to also **add an “Insights Summary” table** (like Top 3 Findings in bullet points) so recruiters can quickly see results without scanning all queries?



