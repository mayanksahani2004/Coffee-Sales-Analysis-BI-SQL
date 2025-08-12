USE coffee;

SELECT * FROM coffee_sales;

-- ALTER TABLE coffee_sales
-- MODIFY COLUMN transaction_date DATE;

-- UPDATE coffee_sales
-- SET transaction_time = str_to_date(transaction_time,'%H:%i:%s');
-- ALTER TABLE coffee_sales
-- MODIFY COLUMN transaction_time TIME;

-- DESCRIBE coffee_sales;


SELECT SUM(unit_price*transaction_qty) AS Total_Sales
FROM coffee_sales
WHERE MONTH(transaction_date)=5;


SELECT MONTH(transaction_date) AS months, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales,(SUM(unit_price*transaction_qty) - LAG(SUM(unit_price*transaction_qty),1)
OVER (ORDER BY MONTH(transaction_date)))/LAG(SUM(unit_price*transaction_qty),1) OVER (ORDER BY MONTH(transaction_date))*100 AS mom_increase_percentage
FROM coffee_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);


SELECT COUNT(transaction_id) AS Total_Orders
FROM coffee_sales
WHERE MONTH(transaction_date) = 5;


SELECT SUM(transaction_qty) AS Total_Orders
FROM coffee_sales
WHERE MONTH(transaction_date) = 5;


SELECT MONTH(transaction_date) AS months, ROUND(SUM(transaction_qty),2) AS total_sales,(SUM(transaction_qty) - LAG(SUM(transaction_qty),1)
OVER (ORDER BY MONTH(transaction_date)))/LAG(SUM(transaction_qty),1) OVER (ORDER BY MONTH(transaction_date))*100 AS mom_increase_percentage
FROM coffee_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);


SELECT SUM(unit_price*transaction_qty) AS Total_Sales, SUM(transaction_qty) AS Total_Quantity, COUNT(transaction_id) AS Total_Orders
FROM coffee_sales
WHERE transaction_date = "2023-05-18";


SELECT AVG(total_sales) AS average_sales
FROM ( 
SELECT SUM(unit_price*transaction_qty) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date) =5
GROUP BY transaction_date
) AS subquery;


SELECT DAY(transaction_date) AS day_of_month, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date)
ORDER BY DAY(transaction_date);


SELECT day_of_month, CASE WHEN total_sales > avg_sales THEN "Above Average" WHEN total_sales<avg_sales THEN "Below Average" ELSE "Average" END AS sales_status, total_sales
FROM (SELECT DAY(transaction_date) AS day_of_month, SUM(unit_price*transaction_qty) AS total_sales, AVG(SUM(unit_price*transaction_qty)) OVER() AS avg_sales
FROM coffee_sales
WHERE MONTH(transaction_date) = 5 
GROUP BY DAY(transaction_date)) AS sales_Date
ORDER BY day_of_month;


SELECT CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN "Weekends" ELSE "Weekdays" END AS day_type,ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date)=5
GROUP BY CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN "Weekends" ELSE "Weekdays" END;


SELECT store_location, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date) = 5
GROUP BY store_location
ORDER BY total_sales DESC;


SELECT product_category, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY total_sales DESC;


SELECT product_type, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_type
ORDER BY total_sales DESC
LIMIT 10;


SELECT ROUND(SUM(unit_price*transaction_qty),2) AS total_sales, SUM(transaction_qty) AS Total_Quantity, COUNT(*) AS Total_Orders
FROM coffee_sales
WHERE DAYOFWEEK(transaction_date) = 3 AND HOUR(transaction_time) = 8 AND MONTH(transaction_date) = 5;


SELECT CASE WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
            WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
            WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
            WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
            WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
            WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
            ELSE 'Sunday' END AS day_of_week, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date)=5
GROUP BY CASE WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
            WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
            WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
            WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
            WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
            WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
            ELSE 'Sunday' END;
            
            
SELECT HOUR(transaction_time) AS Hour_of_Day, ROUND(SUM(unit_price*transaction_qty),2) AS total_sales
FROM coffee_sales
WHERE MONTH(transaction_date) = 5
GROUP BY HOUR(transaction_time)
ORDER BY HOUR(transaction_time);