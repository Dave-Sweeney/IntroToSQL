/*
    INNER JOIN Example

*/

-- AdventureWorksLT
SELECT prod.ProductID, prod.Name as Product, mod.Name as Model
FROM SalesLT.Product as prod
JOIN SalesLT.ProductModel as mod 
ON prod.ProductModelID = mod.ProductModelID;


-- AdventureWorks2019
SELECT p.ProductID, p.Name as Product, m.Name as Model
FROM Production.Product as p
JOIN Production.ProductModel as m
ON p.ProductModelID = m.ProductModelID;

--sales order id, name, quantity, model

SELECT s.SalesOrderID, p.productID, p.Name, m.Name, s.OrderQty
FROM Production.Product as p
JOIN Production.ProductModel as m
ON p.ProductModelID = m.ProductModelID
JOIN Sales.SalesOrderDetail as s
ON p.ProductID = s.ProductID
ORDER BY s.SalesOrderID;

-- 

SELECT emp.BusinessEntityID, ord.SalesPersonID, p.FirstName, ord.TotalDue
FROM [HumanResources].[Employee] AS emp
LEFT OUTER JOIN [Sales].[SalesOrderHeader] AS ord
ON emp.BusinessEntityID = ord.SalesPersonID
JOIN [Person].[Person] AS p
ON emp.BusinessEntityID = p.BusinessEntityID;