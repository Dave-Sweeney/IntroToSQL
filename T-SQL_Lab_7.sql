/*
    1. Pass a value to the stored procedure by position instead of by
    name.  Try Product Category 41.
*/

CREATE PROCEDURE SalesLT.TopProducts AS
    SELECT TOP(10) name, listprice
    FROM SalesLT.Product
    GROUP BY name, listprice
    ORDER BY listprice DESC;

EXEC SalesLT.TopProducts;
GO

ALTER PROCEDURE SalesLT.TopProducts (@ProductCategoryID AS INT)
    AS
    SELECT TOP(10) name, listprice
    FROM SalesLT.Product
    WHERE ProductCategoryID = @ProductCategoryID
    GROUP BY name, listprice
    ORDER BY listprice DESC;
GO

DECLARE @prodCatID INT = 41;
EXEC SalesLT.TopProducts 41;
GO
/*
    2.  Run the table-valued function to return data for the year 2008
*/
/*
DECLARE @sqlString AS NVARCHAR(256);
SET @sqlString = 'Select * 
                    FROM SalesLT.SalesOrderHeader 
                    WHERE Year(OrderDate) = 2008';

EXEC(@sqlString);
GO
*/


CREATE FUNCTION udfSalesInYear(@model_year INT)
RETURNS TABLE 
AS
RETURN
    SELECT SalesOrderID, TotalDue
    FROM SalesLT.SalesOrderHeader
    WHERE Year(OrderDate) = @model_year;
GO

SELECT * FROM udfSalesInYear(2008);


-- Create a table to store integers
CREATE TABLE Integers
(
    Val int
)
GO

SELECT * from Integers;
GO

-- Insert the values 1 to 100 into the newly created table
DECLARE @i int = 1
WHILE @i <= 100
    BEGIN
    INSERT INTO Integers VALUES (@i);
    SET @i += 1;
    END
GO


-- A function that determines whether or not a number is prime
-- Returns 0 - false
--     OR  1 - True
CREATE FUNCTION udfIsPrime(@input INT) RETURNS BIT
AS
BEGIN
    DECLARE @output BIT = 1
    DECLARE @j INT = 1
    
    IF (@input = 1) SET @output = 0
    WHILE @j <= SQRT(@input)
    BEGIN
        IF (@input % @j = 0 AND @j > 1) SET @output = 0
        SET @j += 1
    END

    RETURN @output
END
GO

SELECT Val
FROM Integers
WHERE dbo.udfIsPrime(Val) = 1;