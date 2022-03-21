/*
    Challenge 1.1:  Retrieve customer details
        Write a T-SQL query that retrieves all columns for all customers


SELECT *
FROM SalesLT.Customer;
*/

/*
    Challenge 1.2:  
        Create a list of all customer contact names that includes the title, first name, 
        middle name (if any), last name, and suffix (if any) of all customers

SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;
*/

/*
    Challenge 1.3:  
        Each customer has an assigned salesperson.  Write a query to create a call sheet
        that lists:
            - The salesperson
            - A column named CustomerName that displays how the customer contact should
                be greeted (i.e. Mr Smith)
            - The customer's phone number

SELECT SalesPerson, Title + LastName AS CustomerName, Phone
FROM SalesLT.Customer;
*/

/*
    Challenge 2.1:  Retrieve customer order data
        Retrieve a list of customer companies in the format 
            CustomerID: Company Name - for example, 78: Preferred Bikes

SELECT CONVERT(nvarchar(30), CustomerID) + ': ' + CompanyName AS 'Customer Companies'
FROM SalesLT.Customer;
*/

/*
    Challenge 2.2:  The SalesLT.SalesOrderHeader table contains records of sales orders.  
        Retrieve the sales order number and revision number in the format ()
            Example:  SO71774(2)
        The order date converted to ANSI standard 102 format (yyyy.mm.dd)

SELECT CAST(SalesOrderNumber AS varchar(5)) +  '(' + CAST(RevisionNumber AS varchar(2)) + ')' AS 'Order (Rev.)',
    CONVERT(nvarchar(30), OrderDate, 102) AS 'Revision Date'
FROM SalesLT.SalesOrderHeader;
*/

/*
    Challenge 3.1:  Retrieve customer contact names with middle names if known


SELECT 
    CASE
        WHEN MiddleName IS NULL THEN FirstName + ' ' + LastName
        ELSE FirstName + ' ' + MiddleName + ' ' + LastName
    END AS Name
FROM SalesLT.Customer
*/

/*
    Challenge 3.2:  Write a query that returns a list of customer IDs in one column, and a 
    second column named PrimaryContact that contains the email address if known, and otherwise
    the phone number.

    USE THE FOLLOWING QUERY TO NULL SOME OF THE E-MAIL ADDRESSES FIRST
        UPDATE SalesLT.Customer
        SET EmailAddress = NULL
        WHERE CustomerID % 7 = 1;


SELECT customerID, 
    CASE
        WHEN EmailAddress IS NULL THEN Phone
        ELSE EmailAddress
    END AS PrimaryContact
FROM SalesLT.Customer;
*/

/*
    Challenge 3.3:  Create a query that returns a list of sales order IDs and order
    dates with a column named ShippingStatus that contains the text Shipped for 
    orders with a known ship date, and Awaiting Shipment for orders with no ship date.

        UPDATE SalesLT.SalesOrderHeader
        SET ShipDate = NULL
        WHERE SalesOrderID > 71899;


SELECT SalesOrderID,
    CASE
        WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
        ELSE 'Shipped'
    END AS Status
FROM SalesLT.SalesOrderHeader
*/