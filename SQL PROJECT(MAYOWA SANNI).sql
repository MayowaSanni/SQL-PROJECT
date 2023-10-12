use project;
select * from dimcustomer;
select * from dimproduct;
select * from dimsalesterritory;
select * from factresellersales;
select * from diminvoices;

-- QUESTION 1 
select * from factresellersales;
select * from dimproduct;
  SELECT
    monthname(fs1.OrderDate) AS Month,
    fs1.orderdate,
    fs1.SalesAmount FROM
    dimproduct dp 
    JOIN factresellersales fs1 
    ON dp.ProductKey = fs1.ProductKey 
    LEFT JOIN factresellersales fs2 
    ON dp.ProductKey = fs2.ProductKey 
    AND YEAR(fs1.OrderDate) = YEAR(fs2.OrderDate)
    AND MONTH(fs1.OrderDate) = MONTH(fs2.OrderDate) 
    AND fs1.SalesAmount < fs2.SalesAmount WHERE
    dp.ProductName = 'Sport-100 Helmet, Red' 
    AND YEAR(fs1.OrderDate) = 2012 AND fs2.SalesAmount IS NULL ORDER BY
  SalesAmount DESC;
 
 -- QUESTION 2 
WITH MonthlyProductRevenue AS (
    SELECT MONTHNAME(rs.OrderDate) AS Month,
        dt.SalesTerritoryCountry,
        dp.ProductName,
        SUM(rs.SalesAmount) AS SalesAmount FROM FactResellerSales rs
    JOIN DimProduct dp ON rs.ProductKey = dp.ProductKey
    JOIN DimSalesTerritory dt ON rs.SalesTerritoryKey = dt.SalesTerritoryKey
    WHERE rs.OrderDate >= '2012-01-01' AND rs.OrderDate <= '2012-12-31'
    GROUP BY MONTHNAME(rs.OrderDate), dt.SalesTerritoryCountry, dp.ProductName)
SELECT Month,
    SalesTerritoryCountry,
    ProductName,
    SalesAmount
FROM (SELECT Month, SalesTerritoryCountry, ProductName, SalesAmount,
        ROW_NUMBER() OVER (PARTITION BY Month ORDER BY SalesAmount ASC) AS RowNum
    FROM MonthlyProductRevenue) ranked
WHERE RowNum = 1 ORDER BY SalesAmount DESC;

 -- QUESTION 3  Find all the products and their Total Sales Amount by Month of order which does have sales in 2012. 
select * from dimproduct;
select * from factresellersales;
SELECT d.ProductKey, SUM(f.SalesAmount) AS SalesAmount,
  MONTHNAME(f.OrderDate) AS OrderMonth
FROM dimproduct d
JOIN factresellersales f ON d.ProductKey = f.ProductKey
WHERE YEAR(f.OrderDate) = 2012
GROUP BY d.ProductKey, MONTHNAME(f.OrderDate)
ORDER BY d.ProductKey, OrderMonth;

-- QUESTION 4 
select * from DimCustomer;
SELECT MaritalStatus, Gender,
      YEAR(CURDATE()) - YEAR(BirthDate) AS Age,
    CASE WHEN YEAR (CURDATE()) - YEAR(BirthDate) < 35 THEN 'Yes' ELSE 'No' ENd as AgeBelow35,
  CASE WHEN YEAR (CURDATE()) - YEAR(BirthDate) between 35 AND 50 THEN 'Yes' ELSE 'No' END AS AgeBetween35and50,
  CASE WHEN YEAR (CURDATE()) - YEAR(BirthDate) >= 50 THEN 'Yes' ELSE 'No' END AS AgeAbove50
FROM DimCustomer;

-- QUESTION 5
SELECT
    MONTH(invoice_date) AS InvoiceMonth,
    SUM(amount_usd) AS MRR_usd,
    SUM(amount_usd) * 12 AS Monthly_ARR_usd
FROM DimInvoices
WHERE (product_type = 'EOR Monthly' OR product_type = 'EOR Yearly')
    AND YEAR(invoice_date) = 2022
    AND discount = 0 -- Exclude discounts
GROUP BY MONTH(invoice_date)
ORDER BY InvoiceMonth; 
 

   
    
        
