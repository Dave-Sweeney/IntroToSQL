/*
        Sort results using the ORDER BY clause
*/

-- Modify the existing query to return the Name and ListPrice of all products
/*
    SELECT Name, ListPrice
    FROM SalesLT.Product
    ORDER BY ListPrice DESC;
*/

SELECT Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;


/*
    Challenge 1: Retrieve data for transportation reports

    The logistics manager at Adventure Works has asked you to
    generate some reports containing details of the company's
    customers to help to reduce transportation costs.

    1.  Retrieve a list of cities
        - Initially, you need to produce a list of all of your
        customer's locations.  Write a T-SQL query that queries
        the SalesLT.Address table and retrieves the values
        for City and StateProvince, removing duplicates
        and dorting in ascending order of city.
*/ 

SELECT DISTINCT City, StateProvince
FROM SalesLT.Address
ORDER BY City ASC;

/*
    2.  Retrieve the heaviest products
        - Transportation costs are increasing and you need to 
        identify the heaviest products.  Retrieve the names of the 
        top 10 percent of products by weight.
*/

SELECT TOP 10 PERCENT Weight, Name
FROM SalesLT.Product
ORDER BY Weight DESC;

/*
    Challenge 2:  Retrieve product data
    
    The production manager at Adventure Works would like you to
    create some reports listing details of the products that 
    you sell

    1.  Retrieve product details for product model 1
        - Initially, you need to find the names, colors, and 
        sizes of the products with a product model ID 1.
*/

SELECT ProductId, Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1;

/*
    2.  Filter products by color and size
        - Retrieve the product number and name of the products
        that have a color of black, red, or white and a size
        of S or M.
*/

SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE (Color = 'black'
        OR Color = 'red'
        OR Color = 'white')
        AND (
            Size = 'm'
            OR Size = 's');

/*
    3.  Filter products by product number
        - Retrieve the product number, name, and list price of
        products whose product number begins BK-
*/

SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-%';

/*
    4.  Retrieve specific products by product number
        - Modify your previous query to retrieve the product 
        number, name, and list price of products whose product
        number begins BK- followed by any character other than
        R, ends with a - followed by any two numerals.
*/

SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^r]%-[0-9][0-9]';
