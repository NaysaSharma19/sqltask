
 show tables; 
 
 SELECT * FROM Address;

SELECT COUNT(*) FROM Address;

SELECT * FROM AddressType;

-- Join customer and address
SELECT c.CustomerID, a.AddressLine1, at.Name AS AddressType
FROM CustomerAddress ca
JOIN Customer c ON ca.CustomerID = c.CustomerID
JOIN Address a ON ca.AddressID = a.AddressID
JOIN AddressType at ON ca.AddressTypeID = at.AddressTypeID;

-- Show product inventory per location
SELECT * FROM ProductInventory;

-- Products with zero inventory
SELECT ProductID FROM ProductInventory WHERE Quantity = 0;

-- Product list with price history
SELECT p.Name, plph.ListPrice, plph.ModifiedDate
FROM Product p
JOIN ProductListPriceHistory plph ON p.ProductID = plph.ProductID;

-- Product description 
SELECT p.Name, pd.Description
FROM Product p
JOIN ProductModel pm ON p.ProductModelID = pm.ProductModelID
JOIN ProductModelProductDescriptionCulture pmpdc ON pm.ProductModelID = pmpdc.ProductModelID
JOIN ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID
WHERE pmpdc.CultureID = 'en';

SELECT * FROM Employee;

-- List departments
SELECT * FROM Department;

-- Count employees per department
SELECT DepartmentID, COUNT(*) FROM EmployeeDepartmentHistory GROUP BY DepartmentID;

-- Employees with pay history
SELECT e.EmployeeID, eph.Rate, eph.RateChangeDate
FROM Employee e
JOIN EmployeePayHistory eph ON e.EmployeeID = eph.EmployeeID;

-- All customers
SELECT * FROM Customer;

-- Customers by territory
SELECT TerritoryID, COUNT(*) FROM Customer GROUP BY TerritoryID;

SELECT * FROM ContactCreditCard;

SELECT * FROM CountryRegionCurrency;

SELECT * FROM CurrencyRate;

-- Products with cost history
SELECT p.Name, pch.StandardCost, pch.StartDate
FROM Product p
JOIN ProductCostHistory pch ON p.ProductID = pch.ProductID;

select * from product;

-- Product and model documentation
SELECT * FROM ProductDocument;

-- Products with photos
SELECT p.Name, pp.ThumbNailPhoto
FROM Product p
JOIN ProductProductPhoto ppp ON p.ProductID = ppp.ProductID
JOIN ProductPhoto pp ON ppp.ProductPhotoID = pp.ProductPhotoID;

-- Job candidates with resumes
SELECT JobCandidateID, Resume FROM JobCandidate;

-- Orders and details
SELECT sod.SalesOrderID, sod.ProductID, sod.OrderQty, sod.LineTotal
FROM SalesOrderDetail sod;

-- Products sold more than 1000 times
SELECT ProductID, SUM(OrderQty) AS qty_sold
FROM SalesOrderDetail
GROUP BY ProductID
HAVING qty_sold > 1000;

-- Employees with address
SELECT e.EmployeeID, a.AddressLine1
FROM Employee e
JOIN EmployeeAddress ea ON e.EmployeeID = ea.EmployeeID
JOIN Address a ON ea.AddressID = a.AddressID;

-- Top 10 cities by address count
SELECT City, COUNT(*) AS num_addresses
FROM Address
GROUP BY City
ORDER BY num_addresses DESC
LIMIT 10;

-- Currency rates between USD and CAD
SELECT * FROM CurrencyRate WHERE FromCurrencyCode = 'USD' AND ToCurrencyCode = 'CAD';

SELECT * FROM Individual;

--  Top 5 products by sales revenue
SELECT ProductID, SUM(LineTotal) AS revenue
FROM SalesOrderDetail
GROUP BY ProductID
ORDER BY revenue DESC
LIMIT 5;

-- Products with missing model
SELECT * FROM Product WHERE ProductModelID IS NULL;

-- Employees with multiple department histories
SELECT EmployeeID, COUNT(*)
FROM EmployeeDepartmentHistory
GROUP BY EmployeeID
HAVING COUNT(*) > 1;

-- Last updated product
SELECT * FROM Product ORDER BY ModifiedDate DESC LIMIT 1;

-- Products with illustrations
SELECT pi.IllustrationID, COUNT(*)
FROM ProductModelIllustration pi
GROUP BY pi.IllustrationID;

-- All job candidates without resumes
SELECT * FROM JobCandidate WHERE Resume IS NULL;

-- Employees hired in 2003
SELECT * FROM Employee WHERE HireDate BETWEEN '2003-01-01' AND '2003-12-31';

-- Products with list price > 1000
SELECT * FROM Product WHERE ListPrice > 1000;

-- Product count per subcategory
SELECT ProductSubcategoryID, COUNT(*) FROM Product GROUP BY ProductSubcategoryID;

-- Addresses updated after 2004
SELECT * FROM Address WHERE ModifiedDate > '2004-01-01';

-- Currency list
SELECT * FROM Currency;

-- Departments sorted by name
SELECT * FROM Department ORDER BY Name;

-- Sales by product per year
SELECT ProductID, YEAR(ModifiedDate) AS Year, SUM(LineTotal)
FROM SalesOrderDetail
GROUP BY ProductID, YEAR(ModifiedDate);

-- Employees with most department transfers
SELECT EmployeeID, COUNT(*) AS TransferCount
FROM EmployeeDepartmentHistory
GROUP BY EmployeeID
ORDER BY TransferCount DESC;

-- Most recently hired employees
SELECT * FROM Employee ORDER BY HireDate DESC LIMIT 5;

-- Average employee rate by department
SELECT edh.DepartmentID, AVG(eph.Rate) AS AvgRate
FROM EmployeeDepartmentHistory edh
JOIN EmployeePayHistory eph ON edh.EmployeeID = eph.EmployeeID
GROUP BY edh.DepartmentID;

-- Product list price changes over time
SELECT ProductID, ListPrice, ModifiedDate
FROM ProductListPriceHistory
ORDER BY ProductID, ModifiedDate;

-- Top countries by number of currencies
SELECT CountryRegionCode, COUNT(*) AS CurrencyCount
FROM CountryRegionCurrency
GROUP BY CountryRegionCode
ORDER BY CurrencyCount DESC;

-- Departments with more than 5 employees
SELECT DepartmentID, COUNT(*) AS EmpCount
FROM EmployeeDepartmentHistory
GROUP BY DepartmentID
HAVING EmpCount > 5;

-- Most used currency pairs
SELECT FromCurrencyCode, ToCurrencyCode, COUNT(*) AS UsageCount
FROM CurrencyRate
GROUP BY FromCurrencyCode, ToCurrencyCode
ORDER BY UsageCount DESC;

-- Latest employee pay rate
SELECT *
FROM EmployeePayHistory eph
WHERE (eph.EmployeeID, eph.RateChangeDate) IN (
  SELECT EmployeeID, MAX(RateChangeDate)
  FROM EmployeePayHistory
  GROUP BY EmployeeID
);

-- Product price trend (first vs last price)
SELECT ProductID,
       MIN(ListPrice) AS FirstPrice,
       MAX(ListPrice) AS LastPrice
FROM ProductListPriceHistory
GROUP BY ProductID;

-- Employees with more than one pay change
SELECT EmployeeID
FROM EmployeePayHistory
GROUP BY EmployeeID
HAVING COUNT(*) > 1;

-- Job candidates linked to employees
SELECT * FROM JobCandidate WHERE EmployeeID IS NOT NULL;

-- Products with photo but no illustration
SELECT DISTINCT p.Name
FROM Product p
JOIN ProductProductPhoto ppp ON p.ProductID = ppp.ProductID
LEFT JOIN ProductModelIllustration pmi ON p.ProductModelID = pmi.ProductModelID
WHERE pmi.ProductModelID IS NULL;

-- Illustrations with multiple product models
SELECT IllustrationID, COUNT(*)
FROM ProductModelIllustration
GROUP BY IllustrationID
HAVING COUNT(*) > 1;

-- Currency conversion rate changes over time
SELECT FromCurrencyCode, ToCurrencyCode, COUNT(*)
FROM CurrencyRate
GROUP BY FromCurrencyCode, ToCurrencyCode;

-- Country with most currency mappings
SELECT CountryRegionCode, COUNT(*) AS MappingCount
FROM CountryRegionCurrency
GROUP BY CountryRegionCode
ORDER BY MappingCount DESC
LIMIT 1;

-- Product list price increases
SELECT ProductID, ListPrice, ModifiedDate
FROM ProductListPriceHistory
WHERE ListPrice > 1000;

-- Products used in BOM (bill of materials)
SELECT DISTINCT ComponentID
FROM BillOfMaterials;


-- Product models without product descriptions
SELECT *
FROM ProductModel pm
LEFT JOIN ProductModelProductDescriptionCulture pmpdc
ON pm.ProductModelID = pmpdc.ProductModelID
WHERE pmpdc.ProductModelID IS NULL;

-- Most commonly assigned address type
SELECT AddressTypeID, COUNT(*) AS UsageCount
FROM CustomerAddress
GROUP BY AddressTypeID
ORDER BY UsageCount DESC;

--  List of all product models with English descriptions
SELECT pm.ProductModelID, pd.Description
FROM ProductModel pm
JOIN ProductModelProductDescriptionCulture pmpdc ON pm.ProductModelID = pmpdc.ProductModelID
JOIN ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID
WHERE pmpdc.CultureID = 'en';

-- Employees who changed departments
SELECT EmployeeID
FROM EmployeeDepartmentHistory
GROUP BY EmployeeID
HAVING COUNT(DISTINCT DepartmentID) > 1;

-- Departments with no recent updates
SELECT * FROM Department WHERE ModifiedDate < '2003-01-01';

-- Products with more than 2 cost changes
SELECT ProductID, COUNT(*) AS CostChanges
FROM ProductCostHistory
GROUP BY ProductID
HAVING CostChanges > 2;

-- Product inventory summary by location
SELECT LocationID, SUM(Quantity) AS TotalQuantity
FROM ProductInventory
GROUP BY LocationID;

-- Employees per location
SELECT a.City, COUNT(*) AS EmployeeCount
FROM EmployeeAddress ea
JOIN Address a ON ea.AddressID = a.AddressID
GROUP BY a.City;

-- Products with price but no cost history
SELECT *
FROM Product p
LEFT JOIN ProductCostHistory pch ON p.ProductID = pch.ProductID
WHERE pch.ProductID IS NULL;

-- Products that appear in orders but have no inventory
SELECT DISTINCT sod.ProductID
FROM SalesOrderDetail sod
LEFT JOIN ProductInventory pi ON sod.ProductID = pi.ProductID
WHERE pi.ProductID IS NULL;

-- List of top 3 departments by employee count
SELECT DepartmentID, COUNT(*) AS Count
FROM EmployeeDepartmentHistory
GROUP BY DepartmentID
ORDER BY Count DESC
LIMIT 3;

-- Employees with address in 'Seattle'
SELECT e.EmployeeID, a.City
FROM Employee e
JOIN EmployeeAddress ea ON e.EmployeeID = ea.EmployeeID
JOIN Address a ON ea.AddressID = a.AddressID
WHERE a.City = 'Seattle';

-- Currency conversion history for EUR
SELECT * FROM CurrencyRate WHERE ToCurrencyCode = 'EUR';

-- Employees by hire year
SELECT YEAR(HireDate) AS HireYear, COUNT(*) AS Count
FROM Employee
GROUP BY HireYear;

-- Products with no associated documents
SELECT *
FROM Product p
LEFT JOIN ProductDocument pd ON p.ProductID = pd.ProductID
WHERE pd.ProductID IS NULL;

-- Latest product photo uploads
SELECT * FROM ProductPhoto ORDER BY ModifiedDate DESC LIMIT 10;

-- Currency used in most country regions
SELECT CurrencyCode, COUNT(*) AS RegionCount
FROM CountryRegionCurrency
GROUP BY CurrencyCode
ORDER BY RegionCount DESC;

-- Currency rate trends over months
SELECT YEAR(ModifiedDate) AS Year, MONTH(ModifiedDate) AS Month, AVG(AverageRate)
FROM CurrencyRate
GROUP BY YEAR(ModifiedDate), MONTH(ModifiedDate);

-- Products with same list price
SELECT ListPrice, COUNT(*) AS ProductCount
FROM Product
GROUP BY ListPrice
HAVING ProductCount > 1;

-- Count of addresses by postal code
SELECT PostalCode, COUNT(*) AS AddressCount
FROM Address
GROUP BY PostalCode
ORDER BY AddressCount DESC;

-- Employees earning above department average
SELECT eph.EmployeeID
FROM EmployeePayHistory eph
JOIN (
  SELECT edh.DepartmentID, AVG(eph2.Rate) AS DeptAvg
  FROM EmployeeDepartmentHistory edh
  JOIN EmployeePayHistory eph2 ON edh.EmployeeID = eph2.EmployeeID
  GROUP BY edh.DepartmentID
) dept_avg ON eph.Rate > dept_avg.DeptAvg;

--  Inventory imbalance: locations with stock > 1000
SELECT LocationID, SUM(Quantity) AS TotalStock
FROM ProductInventory
GROUP BY LocationID
HAVING TotalStock > 1000;

--  Top 5 fastest growing employees (most pay hikes)
SELECT EmployeeID, COUNT(*) AS RateChanges
FROM EmployeePayHistory
GROUP BY EmployeeID
ORDER BY RateChanges DESC
LIMIT 5;

-- Employee performance: average rate trend
SELECT eph.EmployeeID, YEAR(RateChangeDate) AS Yr, AVG(Rate) AS AvgRate
FROM EmployeePayHistory eph
GROUP BY eph.EmployeeID, Yr;

-- Location-wise product diversity
SELECT LocationID, COUNT(DISTINCT ProductID) AS ProductTypes
FROM ProductInventory
GROUP BY LocationID;

--  Products with identical cost and list price
SELECT ProductID FROM Product WHERE StandardCost = ListPrice;

-- Currency pairs with rate fluctuation > 10%
SELECT FromCurrencyCode, ToCurrencyCode
FROM CurrencyRate
GROUP BY FromCurrencyCode, ToCurrencyCode
HAVING MAX(AverageRate) / MIN(AverageRate) > 1.10;

-- 112. Identify duplicate addresses
SELECT AddressLine1, City, COUNT(*) AS Count
FROM Address
GROUP BY AddressLine1, City
HAVING Count > 1;

-- Employee headcount trend per department
SELECT DepartmentID, YEAR(ModifiedDate) AS Yr, COUNT(DISTINCT EmployeeID) AS Count
FROM EmployeeDepartmentHistory
GROUP BY DepartmentID, Yr;

-- Average salary change per year
SELECT YEAR(RateChangeDate) AS Yr, AVG(Rate) AS AvgRate
FROM EmployeePayHistory
GROUP BY Yr;

-- Address types used by more than 2 customers
SELECT AddressTypeID, COUNT(DISTINCT CustomerID) AS CustomerCount
FROM CustomerAddress
GROUP BY AddressTypeID
HAVING CustomerCount > 2;

-- Average inventory level per product
SELECT ProductID, AVG(Quantity) AS AvgQty
FROM ProductInventory
GROUP BY ProductID;

-- Product price change frequency
SELECT ProductID, COUNT(*) AS PriceChanges
FROM ProductListPriceHistory
GROUP BY ProductID
ORDER BY PriceChanges DESC;

-- Monthly hires over time
SELECT YEAR(HireDate) AS Yr, MONTH(HireDate) AS Mo, COUNT(*) AS NewHires
FROM Employee
GROUP BY Yr, Mo;

--  Product list price range per subcategory
SELECT ProductSubcategoryID, MIN(ListPrice) AS MinPrice, MAX(ListPrice) AS MaxPrice
FROM Product
GROUP BY ProductSubcategoryID;

-- List of inactive currencies (no rate in 2 years)
SELECT CurrencyCode FROM Currency
WHERE CurrencyCode NOT IN (
  SELECT FromCurrencyCode FROM CurrencyRate WHERE ModifiedDate >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
  UNION
  SELECT ToCurrencyCode FROM CurrencyRate WHERE ModifiedDate >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
);

--  Count of employees per postal code
SELECT a.PostalCode, COUNT(*) AS EmpCount
FROM EmployeeAddress ea
JOIN Address a ON ea.AddressID = a.AddressID
GROUP BY a.PostalCode;

-- Employees paid below average per year
SELECT eph.EmployeeID, YEAR(RateChangeDate) AS Yr, Rate
FROM EmployeePayHistory eph
JOIN (
  SELECT YEAR(RateChangeDate) AS Yr, AVG(Rate) AS AvgRate
  FROM EmployeePayHistory
  GROUP BY Yr
) yearly ON YEAR(eph.RateChangeDate) = yearly.Yr AND eph.Rate < yearly.AvgRate;

--  Average products sold per order
SELECT AVG(ProductCount) AS AvgProducts
FROM (
  SELECT SalesOrderID, COUNT(ProductID) AS ProductCount
  FROM SalesOrderDetail
  GROUP BY SalesOrderID
) AS OrderStats;

-- Employees promoted within 2 years of joining
SELECT e.EmployeeID
FROM Employee e
JOIN EmployeeDepartmentHistory edh ON e.EmployeeID = edh.EmployeeID
WHERE DATEDIFF(edh.StartDate, e.HireDate) <= 730;

-- Product price variance across history
SELECT ProductID, STDDEV(ListPrice) AS PriceStdDev
FROM ProductListPriceHistory
GROUP BY ProductID;

-- Countries with multiple currencies used
SELECT CountryRegionCode, COUNT(DISTINCT CurrencyCode) AS CurrencyCount
FROM CountryRegionCurrency
GROUP BY CountryRegionCode
HAVING CurrencyCount > 1;

-- Sales with multiple order lines
SELECT SalesOrderID
FROM SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(*) > 1;

-- Employees who never switched departments
SELECT EmployeeID
FROM EmployeeDepartmentHistory
GROUP BY EmployeeID
HAVING COUNT(DISTINCT DepartmentID) = 1;

--  Most common customer address type
SELECT AddressTypeID, COUNT(*) AS UsageCount
FROM CustomerAddress
GROUP BY AddressTypeID
ORDER BY UsageCount DESC
LIMIT 1;

-- Total documents attached to products
SELECT COUNT(*)
FROM ProductDocument;

--  Average list price of discontinued products
SELECT AVG(ListPrice) AS AvgDiscontinuedPrice
FROM Product
WHERE SellEndDate IS NOT NULL;

--  Subcategories with more than 10 products
SELECT ProductSubcategoryID, COUNT(*) AS ProductCount
FROM Product
GROUP BY ProductSubcategoryID
HAVING ProductCount > 10;

--  Total rate change per employee
SELECT EmployeeID, MAX(Rate) - MIN(Rate) AS RateDelta
FROM EmployeePayHistory
GROUP BY EmployeeID;

-- Products missing standard cost or list price
SELECT ProductID
FROM Product
WHERE StandardCost IS NULL OR ListPrice IS NULL;

-- Product model with most descriptions
SELECT ProductModelID, COUNT(*) AS DescCount
FROM ProductModelProductDescriptionCulture
GROUP BY ProductModelID
ORDER BY DescCount DESC
LIMIT 1;

-- Number of employees per pay grade bracket
SELECT CASE
  WHEN Rate < 20 THEN 'Low'
  WHEN Rate BETWEEN 20 AND 40 THEN 'Medium'
  ELSE 'High'
END AS PayGrade, COUNT(*) AS Count
FROM EmployeePayHistory
GROUP BY PayGrade;

SELECT pc.Name AS Category, COUNT(*) AS ProductCount
FROM Product p
JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name;

-- Top 5 Products by Total Sales Revenue
WITH ProductSales AS (
  SELECT 
    p.ProductID,
    p.Name AS ProductName,
    SUM(sod.LineTotal) AS TotalRevenue
  FROM SalesOrderDetail sod
  JOIN Product p ON p.ProductID = sod.ProductID
  GROUP BY p.ProductID, p.Name
)
SELECT *
FROM (
  SELECT *, RANK() OVER (ORDER BY TotalRevenue DESC) AS SalesRank
  FROM ProductSales
) ranked
WHERE SalesRank <= 5;

-- Employees with Multiple Department Changes
WITH DeptChanges AS (
  SELECT 
    EmployeeID,
    COUNT(DISTINCT DepartmentID) AS DeptCount
  FROM EmployeeDepartmentHistory
  GROUP BY EmployeeID
)
SELECT * 
FROM DeptChanges
WHERE DeptCount > 1;

-- Tenure of Employees Using CTE + DATEDIFF
WITH TenureCTE AS (
  SELECT 
    e.EmployeeID,
    DATEDIFF(CURDATE(), e.HireDate) AS DaysWithCompany
  FROM Employee e
)
SELECT * 
FROM TenureCTE
ORDER BY DaysWithCompany DESC;

-- Orders with Multiple Products and Total Value
WITH OrderSummary AS (
  SELECT 
    SalesOrderID,
    COUNT(DISTINCT ProductID) AS ProductCount,
    SUM(LineTotal) AS TotalOrderValue
  FROM SalesOrderDetail
  GROUP BY SalesOrderID
)
SELECT *
FROM OrderSummary
WHERE ProductCount > 3
ORDER BY TotalOrderValue DESC;

-- Employees with Highest Pay in Their Department
WITH RankedPay AS (
  SELECT 
    eph.EmployeeID,
    edh.DepartmentID,
    eph.Rate,
    RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY eph.Rate DESC) AS RankInDept
  FROM EmployeePayHistory eph
  JOIN EmployeeDepartmentHistory edh ON eph.EmployeeID = edh.EmployeeID
)
SELECT *
FROM RankedPay
WHERE RankInDept = 1;

-- Product price changes over time with running difference
WITH PriceChanges AS (
  SELECT ProductID, StartDate, EndDate, StandardCost,
         LAG(StandardCost) OVER (PARTITION BY ProductID ORDER BY StartDate) AS PrevCost
  FROM ProductCostHistory
)
SELECT *, StandardCost - PrevCost AS CostDifference
FROM PriceChanges
WHERE PrevCost IS NOT NULL;

-- Employees with more than 2 pay changes
WITH Changes AS (
  SELECT EmployeeID, COUNT(*) AS PayChangeCount
  FROM EmployeePayHistory
  GROUP BY EmployeeID
)
SELECT * FROM Changes WHERE PayChangeCount > 2;


-- Products with largest increase in list price
WITH PriceHistory AS (
  SELECT ProductID, StartDate, ListPrice,
         LAG(ListPrice) OVER (PARTITION BY ProductID ORDER BY StartDate) AS PrevPrice
  FROM ProductListPriceHistory
)
SELECT *, ListPrice - PrevPrice AS PriceIncrease
FROM PriceHistory
WHERE PrevPrice IS NOT NULL
ORDER BY PriceIncrease DESC
LIMIT 10;

--  Employees paid above department average
WITH AvgDeptPay AS (
  SELECT edh.DepartmentID, AVG(eph.Rate) AS AvgRate
  FROM EmployeePayHistory eph
  JOIN EmployeeDepartmentHistory edh ON eph.EmployeeID = edh.EmployeeID
  GROUP BY edh.DepartmentID
)
SELECT e.EmployeeID, edh.DepartmentID, eph.Rate, adp.AvgRate
FROM EmployeePayHistory eph
JOIN EmployeeDepartmentHistory edh ON eph.EmployeeID = edh.EmployeeID
JOIN AvgDeptPay adp ON edh.DepartmentID = adp.DepartmentID
JOIN Employee e ON e.EmployeeID = eph.EmployeeID
WHERE eph.Rate > adp.AvgRate;

-- Products never ordered
SELECT p.ProductID, p.Name
FROM Product p
LEFT JOIN SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;

-- Employees hired before 2005 and still in the company
SELECT EmployeeID, HireDate
FROM Employee 
WHERE HireDate < '2005-01-01';
 
-- Total credit cards used per contact
SELECT ContactID, COUNT(DISTINCT CreditCardID) AS CardCount
FROM ContactCreditCard
GROUP BY ContactID
ORDER BY CardCount DESC;

-- Product inventory aging per location
WITH InventoryAge AS (
  SELECT ProductID, LocationID, Shelf, Quantity, ModifiedDate,
         DATEDIFF(CURDATE(), ModifiedDate) AS DaysInInventory
  FROM ProductInventory
)
SELECT * FROM InventoryAge ORDER BY DaysInInventory DESC;


-- Employee average duration per department
WITH Durations AS (
  SELECT EmployeeID, DepartmentID,
         DATEDIFF(IFNULL(EndDate, CURDATE()), StartDate) AS Duration
  FROM EmployeeDepartmentHistory
)
SELECT DepartmentID, AVG(Duration) AS AvgDays
FROM Durations
GROUP BY DepartmentID;

-- Departments with at least 2 employees

WITH DeptCounts AS (
  SELECT DepartmentID, COUNT(DISTINCT EmployeeID) AS EmpCount
  FROM EmployeeDepartmentHistory
  GROUP BY DepartmentID
)
SELECT * FROM DeptCounts WHERE EmpCount >= 2;

-- Employee job change timeline
SELECT EmployeeID, DepartmentID, StartDate, EndDate
FROM EmployeeDepartmentHistory
ORDER BY EmployeeID, StartDate;










