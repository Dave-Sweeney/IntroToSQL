/*
    Challenge 1:  Retrieve product price information

    1.  Retrieve products whose list price is higher than the average
    unit price.
        - o	Retrieve the product ID, name, and list price for each product
         where the list price is higher than the average unit price for 
         all products that have been sold.
*/

SELECT p.ProductID, p.Name, p.ListPrice
FROM [SalesLT].[Product] AS p
WHERE p.ListPrice > (
    SELECT AVG(UnitPrice)
    FROM SalesLT.SalesOrderDetail
)
ORDER BY p.ListPrice DESC;

/*
    2.  Retrieve Products with a list price of 100 or more that have been 
    for less than 100.
        -   Retrieve the product ID, name, and list price for each product 
        where the list price is 100 or more, and the product has been sold 
        for less than 100.
*/

SELECT p.ProductID, p.Name, p.ListPrice
FROM [SalesLT].[Product] AS p
WHERE p.ProductID IN (
    SELECT d.ProductID
    FROM [SalesLT].[SalesOrderDetail] AS d
    WHERE d.UnitPrice < 100
) AND p.ListPrice > 100

/*
    Challenge 2:  Analyze profitability

    1.  Retrieve the cost, list price, and average selling price for 
    each product.
*/

SELECT p.StandardCost, p.Name, p.ListPrice, 
    (SELECT AVG(od.UnitPrice)
    FROM [SalesLT].[SalesOrderDetail] AS od
    WHERE p.ProductID = od.ProductID) AS 'Average'
FROM [SalesLT].[Product] AS p
ORDER BY 'Average' DESC;

/*
    2.  Retrieve products that have an average selling price that is 
    lower than the cost.
*/

SELECT p.StandardCost, p.Name, p.ListPrice, 
    (SELECT AVG(od.UnitPrice)
    FROM [SalesLT].[SalesOrderDetail] AS od
    WHERE p.ProductID = od.ProductID 
    ) AS CostAvg
FROM [SalesLT].[Product] AS p
WHERE p.StandardCost > (
    SELECT AVG(od2.UnitPrice)
    FROM [SalesLT].[SalesOrderDetail] AS od2
    WHERE p.ProductID = od2.ProductID
)
ORDER BY CostAvg DESC;