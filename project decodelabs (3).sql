CREATE DATABASE decodelabs_project3;
USE decodelabs_project3;
CREATE TABLE orders (
  OrderID VARCHAR(20),
  Date DATE,
  CustomerID VARCHAR(20),
  Product VARCHAR(50),
  Quantity INT,
  UnitPrice DECIMAL(10,2),
  ShippingAddress VARCHAR(100),
  PaymentMethod VARCHAR(50),
  OrderStatus VARCHAR(50),
  TrackingNumber VARCHAR(50),
  ItemsInCart INT,
  CouponCode VARCHAR(50),
  ReferralSource VARCHAR(50),
  TotalPrice DECIMAL(10,2)
);
SELECT * FROM orders LIMIT 10;

SELECT * FROM orders 
WHERE OrderStatus = 'Cancelled';

SELECT * FROM orders 
ORDER BY TotalPrice DESC;

SELECT Product, COUNT(*) AS Total_Orders
FROM orders
GROUP BY Product
ORDER BY Total_Orders DESC;

SELECT Product, 
       SUM(TotalPrice) AS Total_Sales,
       AVG(TotalPrice) AS Average_Sale
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC;

SELECT * FROM orders
WHERE OrderStatus = 'Shipped' 
AND TotalPrice > 1000;

SELECT PaymentMethod, COUNT(*) AS Total
FROM orders
GROUP BY PaymentMethod
ORDER BY Total DESC;

SELECT Product, SUM(TotalPrice) AS Total_Sales
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 1;

SELECT YEAR(Date) AS Year, 
       COUNT(*) AS Orders,
       SUM(TotalPrice) AS Total_Sales
FROM orders
GROUP BY YEAR(Date)
ORDER BY Year;

SELECT Product, COUNT(*) AS Total_Orders
FROM orders
GROUP BY Product
HAVING Total_Orders > 100;