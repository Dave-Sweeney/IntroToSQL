/*
    Challenge 1:  Generate invoice reports

    1. Retrieve customer orders
        - As an initial step towards generating the invoice 
        report, write a query that returns the company name
        from the SalesLT.Customer table, and the sales order
        ID and total due from the SalesLT.SalesOrderHeader
        table
*/

SELECT cust.CompanyName, s.SalesOrderID, s.TotalDue
FROM [SalesLT].[Customer] as cust
INNER JOIN [SalesLT].[SalesOrderHeader] as s
ON cust.CustomerID = s.CustomerID;

/*
    2.  Retrieve customer orders with addresses
        - Extend the query to include the Main Office address
        for each customer, including the full street address,
        city, state or province, postal code, and 
        country or region
*/

SELECT c.CompanyName, a.AddressLine1, a.City, a.StateProvince, 
        a.PostalCode, a.CountryRegion, s.SalesOrderID, s.TotalDue
FROM [SalesLT].[Customer] AS c
INNER JOIN [SalesLT].[SalesOrderHeader] AS s
ON c.CustomerID = s.CustomerID
INNER JOIN [SalesLT].[CustomerAddress] AS ca
ON c.CustomerID = ca.CustomerID
INNER JOIN [SalesLT].[Address] AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';


/*
    Challenge 2.  Retreve customer data

    1.  Retrieve a list of all customers and their orders  
    
    - The sales manager wants a list of all customer companies
     and their contacts (first name and last name), showing the 
     sales order ID and total due for each order they have placed. 
     Customers who have not placed any orders should be included at 
     the bottom of the list with NULL values for the order ID and 
     total due.
*/

SELECT c.CompanyName, c.FirstName, c.LastName, s.SalesOrderID, s.TotalDue
FROM [SalesLT].[Customer] AS c
LEFT JOIN [SalesLT].[SalesOrderHeader] AS s
ON c.CustomerID = s.CustomerID
ORDER BY s.TotalDue DESC;

/*
    2.  Retrieve a list of customers with no address

        - A sales employee has noticed that Adventure Works does 
        not have address information for all customers. You must 
        write a query that returns a list of customer IDs, company 
        names, contact names (first name and last name), and phone 
        numbers for customers with no address stored in the database.
*/

SELECT c.CustomerID, c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM [SalesLT].[Customer] AS c
LEFT JOIN [SalesLT].[CustomerAddress] AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressID IS NULL;



/*
    Challenge 3.    Create a product catalog

    1.  Retreive product information by category

        -  The product catalog will list products by parent category 
        and subcategory, so you must write a query that retrieves the
        parent category name, subcategory name, and product name fields
        for the catalog.
*/

SELECT pc.Name AS 'Primary Category', sc.Name AS 'Subcategory', p.Name 
FROM [SalesLT].[Product] AS p
INNER JOIN [SalesLT].[ProductCategory] AS sc
ON p.ProductCategoryID = sc.ProductCategoryID
INNER JOIN [SalesLT].[ProductCategory] AS pc
ON sc.ParentProductCategoryID = pc.ProductCategoryID;