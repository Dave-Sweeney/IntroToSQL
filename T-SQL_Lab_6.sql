USE AdventureWorksLT;

/*
    Challenge 1:  Assignment of values to variables

    1. Create your variables.
        Write a T-SQL statement to declare two variables.  The first is an 
        nvarchar with length 30 called salesOrderNumber, and the other is an
        integer called customerID.
*/

DECLARE @salesOrderNumber NVARCHAR(30);
DECLARE @customerID INT;

/*
    2. Assign a value to the integer variable.
        Extend your TSQL code to assign the value 29847 to the customerID
*/

SET @customerID = 29847;

/*
    3. Assign a value from the database and display the result.
        Extend your TSQL to set the value of the variable salesOrderNumber
        using the column salesOrderNumber from the SalesOrderHeader table,
        filter using the customerID column and the customerID variable.  
        Display the result to the user as OrderNumber.
*/

SET @salesOrderNumber = (SELECT SalesOrderID AS OrderNumber
FROM SalesLT.SalesOrderHeader
WHERE customerID = @customerID)

Print @salesOrderNumber;

GO

/*
    Challenge 2:  Aggregate product sales

    1. Declare the variables
        Write a T-SQL statement to declare three variables.  The first is 
        called customerID and will be an integer with an initial value of 1.  
        The next two variables will be called fname and lname.
        Both will be NVARCHAR, give fname a length 20 and lname a length
        30.

*/

USE AdventureWorksLT;

DECLARE @customerID INT = 1;
DECLARE @fname NVARCHAR(20);
DECLARE @lname NVARCHAR(30);



/*

    2. Construct a terminating loop
        Extend your T-SQL code and create a WHILE loop that will stop when
        the customerID variable reaches 10.

*/

WHILE @customerID <= 10
    BEGIN
        SET @customerID += 1;
    END;

GO

/*
    3. Select the customer first name and last name and display:
        Extend the T-SQL code, adding a SELECT statement to retrieve
        the FirstName and LastName columns and assign them respectively
        to fname and lname.

        Combine and PRINT the fname and lname.  Filter using the 
        customerID column and the customerID variable.
*/

USE AdventureWorksLT;

DECLARE @customerID INT = 1;
DECLARE @fname NVARCHAR(20);
DECLARE @lname NVARCHAR(30);

WHILE @customerID <= 10
    BEGIN
        SET @fname = (
            SELECT FirstName 
            FROM SalesLT.Customer
            WHERE CustomerID = @customerID
            )
        SET @lname = (
            SELECT LastName 
            FROM SalesLT.Customer
            WHERE CustomerID = @customerID
        )

        PRINT @fname + ' ' + @lname;
        SET @customerID += 1;
    END;

GO