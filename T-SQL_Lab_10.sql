/*
    Challenge 1:  Return a RANK value for products

    Amend the T-SQL code with the RANK clause so that it returns a 
    Rank value for products within each category.
*/

WITH sales AS
 (
     SELECT C.Name AS 'Category', 
     SC.Name AS 'Subcategory',
     CAST(SUM(D.LineTotal) AS numeric(12, 2)) AS 'SalesValue'
     FROM SalesLT.SalesOrderDetail AS D
     INNER JOIN SalesLT.Product AS P
         ON D.ProductID = P.ProductID
     INNER JOIN SalesLT.ProductCategory AS SC
        ON P.ProductCategoryID = SC.ProductCategoryID
     INNER JOIN SalesLT.ProductCategory AS C
         ON SC.ParentProductCategoryID = C.ProductCategoryID
         GROUP BY C.Name, SC.Name
 )
 SELECT Category, Subcategory, SalesValue, RANK() OVER(PARTITION BY Category ORDER BY SalesValue DESC) AS 'Rank'
 FROM sales
     ORDER BY Category, SalesValue DESC;



/*
    Challenge 2:  Return the next year's budget value

    Using the Budget table you have already created, amend the SELECT
    statement to return the following year's budget values as "NEXT".
*/

CREATE TABLE dbo.Budget
 (
     [Year] int NOT NULL PRIMARY KEY,
     Budget int NOT NULL
 );

 INSERT INTO dbo.Budget ([Year], Budget)
     VALUES
         (2017, 14600),
         (2018, 16300),
         (2019, 18200),
         (2020, 21500),
         (2021, 22800);

 SELECT [Year], Budget, LAG(Budget, 1, 0) OVER (ORDER BY [Year]) AS 'Previous',
        LEAD(Budget, 1, 0) OVER (ORDER BY [Year]) AS 'Next'
     FROM dbo.Budget
     ORDER BY [Year]; 


/*
    Challenge 3:  Return the first and last budget values for each year

    Using the Budget table you have already created, amend the select
    statement to return the first budget value in one column, and the
    last budget value in another column, where budget values are
    ordered by year in ascending order.
*/

WITH budget AS (
    SELECT [Year], Budget, LAG(Budget, 1, 0) OVER (ORDER BY [Year]) AS 'Previous'
     FROM dbo.Budget
)
SELECT TOP 1 FIRST_VALUE(Budget) OVER (ORDER BY [Year]) AS 'First Year Budget', 
        LAST_VALUE(Budget) OVER (ORDER BY [Year] DESC) AS 'Last Year Budget'
        FROM budget;

/*
    Challenge 4:  Count the products in each category

    Amend the code containing the aggregation function to return 
    a count of products by category.
*/


SELECT C.Name AS 'Category', 
       COUNT(P.ProductCategoryID) AS 'CategoryCount'
FROM SalesLT.ProductCategory AS C
INNER JOIN SalesLT.Product AS P
    ON P.ProductCategoryID = C.ProductCategoryID
GROUP BY C.Name, P.ProductCategoryID
ORDER BY CategoryCount DESC, P.ProductCategoryID;
