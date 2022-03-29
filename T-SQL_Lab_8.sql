/*
    Challenge 1:  Catch errors and display only valid records

    The marketing manager is using the following T-SQL query, but they are
    getting unexpected results.  They have asked you to make the code more
    resilient, to stop it crashing and to not display duplicates when there
    is no data:

    DECLARE @customerID AS INT = 30110;
    DECLARE @fname AS NVARCHAR(20);
    DECLARE @lname AS NVARCHAR(30);
    DECLARE @maxReturns AS INT = 1; 
    WHILE @maxReturns <= 10
    BEGIN
        SELECT @fname = FirstName, @lname = LastName FROM SalesLT.Customer
            WHERE CustomerID = @CustomerID;
        PRINT @fname + N' ' + @lname;
        SET @maxReturns += 1;
        SET @CustomerID += 1;
    END;
*/

/*
    1.  Catch the error
            Add a TRY .. CATCH block around the SELECT query.
    2.  Warn the user that an error has occurred
            Extend your TSQL code to display a warning to the user that
            there is an error.
    3.  Only display valid customer records
            Extend the T-SQL using the @@ROWCOUNT > 0 check to only
            display a result if the customer ID exists
*/

DECLARE @customerID AS INT = 30110;
DECLARE @fname AS NVARCHAR(20);
DECLARE @lname AS NVARCHAR(30);
DECLARE @maxReturns AS INT = 1; 
WHILE @maxReturns <= 10
BEGIN

    BEGIN TRY
        SELECT @fname = FirstName, @lname = LastName 
        FROM SalesLT.Customer
        WHERE CustomerID = @CustomerID
        IF @@ROWCOUNT > 0
        PRINT @fname + N' ' + @lname;
    END TRY

    BEGIN CATCH
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;

    SET @maxReturns += 1;
    SET @CustomerID += 1;

END;
GO


/*
    Challenge 2:  Create a simple error display procedure

    Error messages and error handling are essential for good code.  Your 
    manager has asked you to develop a common error display procedure.  Use
    the sameple code as your base.

    DECLARE @num varchar(20) = 'Challenge 2';
    PRINT 'Casting: ' + CAST(@num AS numeric(10,4));

*/

/*
    1.  Catch the error
            Add a TRY .. CATCH around the PRINT statement
    2.  Create a stored procedure
            Create a stored procedure called dbo.DisplayErrorDetails.  It 
            should display a title and the value for ERROR_NUMBER,
            ERROR_MESSAGE and ERROR_SEVERITY.
    3.  Display the error information
            Use the stored procedure to display the error information
            when an error occurs.
*/

DECLARE @num varchar(20) = 'Challenge 2';

BEGIN TRY
    PRINT 'Casting: ' + CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXECUTE dbo.DisplayErrorDetails;
END CATCH;
GO


IF EXISTS(SELECT * FROM sys.objects WHERE type = 'P' 
            AND name = 'DisplayErrorDetails')
DROP PROCEDURE DisplayErrorDetails
GO

CREATE PROCEDURE dbo.DisplayErrorDetails AS
PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
PRINT 'Error Message: ' + ERROR_MESSAGE();
PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
GO