-- How many sales we have?
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many customer we have?

SELECT COUNT(DISTINCT customer_id) AS customer_count FROM retail_sales;

-- How many categories we have?
SELECT COUNT(DISTINCT category) FROM retail_sales;

--DATA ANALYSIS / BUSINESS KEY PROBLEM

-- Q1) Write the SQL quert to retrive all columns for sales made on "2022-11-05"
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2) write a SQL query to retrive all the transaction where the category is 'clothing' and the quantity sold more than 
 -- 10 in the month of nov-2022

 SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4;

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
   sale_date = '2022-11-05'
    AND
    quantiy >= 4

-- Q3) Write the query to calculate the total sales for each category
SELECT category, SUM(total_sale) AS total_sale FROM retail_sales
GROUP BY category;

-- Q4) Write the SQL query to find the average age of the customer who purchased items from the 'Beauty' category
SELECT 
		ROUND(AVG(age),2) AS Average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5) Write a query to find all transaction where the total sales is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale >1000;


-- Q6) Write a SQL query to find the total number of transaction (transaction_id) made by each gender and each category
SELECT 
		category,
		gender,
		COUNT(*)
FROM retail_sales
GROUP 
	BY 
	category,
	gender
	ORDER BY 1;


-- Q7) Write the SQL query to calculate the average sale of each month. Find out the best selling month in each year
SELECT 
			year,
			month,
			avg_sale
FROM		
(
	SELECT 
			EXTRACT(YEAR FROM sale_date) AS year,
			EXTRACT(MONTH FROM sale_date) AS month,
			AVG(total_sale) AS avg_sale,
			RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY 1,2
	) AS t1
	WHERE RANK = 1;
-- ORDER BY 1 ,3 DESC;

-- Q8) Write a SQL query to find the top 5 customer based on the heighest total sales 
SELECT 
      customer_id ,
	  SUM(total_sale)
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q9) Write a SQL query to find out the unique customer who purchesed item from each category
SELECT 
		category,
		COUNT(DISTINCT customer_id) AS unique_customer_count
FROM retail_sales
GROUP BY category;

-- 10) write a SQL query to create shift and number of orders (Example Morning<= 12,Afternoon between 12 and 17,Evening >=17)
WITH hourly_sales
AS
(
SELECT *,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time)<=12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS Shift
FROM retail_sales
) SELECT 
		Shift,
		COUNT(*) AS total_sale
FROM hourly_sales
GROUP BY Shift
ORDER BY 2 DESC;

------- end of projects




