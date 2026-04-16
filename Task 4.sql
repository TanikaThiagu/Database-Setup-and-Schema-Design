SELECT category, SUM(amount) AS total_sales
FROM sales
GROUP BY category;

SELECT category, COUNT(*) AS total_orders
FROM sales
GROUP BY category;

SELECT category, AVG(amount) AS avg_sales
FROM sales
GROUP BY category;

SELECT 
    category,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales,
    AVG(amount) AS avg_sales
FROM sales
GROUP BY category;

SELECT category, SUM(amount) AS total_sales
FROM sales
GROUP BY category
HAVING SUM(amount) > 100;