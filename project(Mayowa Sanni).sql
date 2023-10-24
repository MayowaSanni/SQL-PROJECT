use project;
select * from dimcustomer;
select * from dimproduct;
select * from dimsalesterritory;
select * from factresellersales;
select * from diminvoices;

-- What is the highest transaction of each month in 2012 for the product Sport-100 Helmet, Red?
select * from dimproduct;
select * from factresellersales;
SELECT
    monthname(fs1.OrderDate) AS Month,
    fs1.orderdate,
    fs1.SalesAmount
FROM
    dimproduct dp
JOIN
    factresellersales fs1 ON dp.ProductKey = fs1.ProductKey
LEFT JOIN
    factresellersales fs2 ON dp.ProductKey = fs2.ProductKey
    AND YEAR(fs1.OrderDate) = YEAR(fs2.OrderDate)
    AND MONTH(fs1.OrderDate) = MONTH(fs2.OrderDate)
    AND fs1.SalesAmount < fs2.SalesAmount
WHERE
    dp.ProductName = 'Sport-100 Helmet, Red'
    AND YEAR(fs1.OrderDate) = 2012
    AND fs2.SalesAmount IS NULL
ORDER BY
  SalesAmount DESC; -------------------------- No 1
    
    
-- What is the lowest revenue-generating product for each month in 2012?
select * from dimproduct;
select * from dimsalesterritory;
select * from factresellersales;

SELECT 
 monthname(OrderDate) AS OrderMonthName,
t.SalesTerritoryCountry AS TerritoryCountry,
p.productname AS ProductName,
SUM(s.SalesAmount) AS SalesAmount
FROM factresellersales s
JOIN dimproduct p ON s.productkey = p.productkey
JOIN dimsalesterritory t ON s.SalesTerritoryKey = t.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2012
GROUP BY YEAR(OrderDate), MONTH(OrderDate) p.productname, t.SalesTerritoryCountry
ORDER BY YEAR(OrderDate), MONTH(OrderDate),monthname(OrderDate), SalesAmount ;   ----------------- No 2

 -- Find all the products and their Total Sales Amount by Month of order which does have sales in 2012. 
select * from dimproduct;
select * from factresellersales;
SELECT d.ProductKey, SUM(f.SalesAmount) AS SalesAmount,
  MONTHNAME(f.OrderDate) AS OrderMonth
FROM dimproduct d
JOIN factresellersales f ON d.ProductKey = f.ProductKey
WHERE YEAR(f.OrderDate) = 2012
GROUP BY d.ProductKey, MONTHNAME(f.OrderDate)
ORDER BY d.ProductKey, OrderMonth; ----------------------------------------------- no3


-- What is customers’ age?
select * from DimCustomer;
SELECT MaritalStatus, Gender,
      YEAR(CURDATE()) - YEAR(BirthDate) AS Age,
    CASE WHEN YEAR (CURDATE()) - YEAR(BirthDate) < 35 THEN 'Yes' ELSE 'No' ENd as AgeBelow35,
	CASE WHEN YEAR (CURDATE()) - YEAR(BirthDate) between 35 AND 50 THEN 'Yes' ELSE 'No' END AS AgeBetween35and50,
	CASE WHEN YEAR (CURDATE()) - YEAR(BirthDate) >= 50 THEN 'Yes' ELSE 'No' END AS AgeAbove50
FROM DimCustomer;
    ----------------------------------------------------------------------------------- No 4
-- What is 2022 monthly basis Annual Recurring Revenue (ARR) of products named EOR Monthly and EOR Yearly**?*
select * from diminvoices;
SELECT
    monthname(invoice_date) AS InvoiceMonth,
    SUM(amount_usd) AS MRR_usd,
    SUM(amount_usd) * 12 AS Monthly_ARR_usd
FROM
    DimInvoices
WHERE
    (product_type = 'EOR Monthly' OR product_type = 'EOR Yearly')
    AND YEAR(invoice_date) = 2022
    AND discount = 0 -- Exclude discounts
GROUP BY
    monthname(invoice_date) 
ORDER BY 
    InvoiceMonth;