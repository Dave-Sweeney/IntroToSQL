/*

    Challenge 1: Insert products
        Each Adventure Works product is stored in the SalesLT.Product table,
        and each product has a unique ProductID identifier, which is 
        implemented as an identity column in the SalesLT.Product table. 
        Products are organized into categories, which are defined in the 
        SalesLT.ProductCategory table. The products and product category 
        records are related by a common ProductCategoryID identifier, 
        which is an identity column in the SalesLT.ProductCategory table.
    
    1.	Insert a product
        - Adventure Works has started selling the following new product. 
        Insert it into the SalesLT.Product table, using default or NULL 
        values for unspecified columns:
            Name: LED Lights
            ProductNumber: LT-L123
            StandardCost: 2.56
            ListPrice: 12.99
            ProductCategoryID: 37
            SellStartDate: Today’s date
        
        - After you have inserted the product, run a query to determine 
        the ProductID that was generated.
        - Then run a query to view the row for the product in the 
        SalesLT.Product table.
*/

INSERT INTO SalesLT.Product
VALUES ('LED Lights', 'LT-L123', NULL, 2.56, 12.99, NULL, NULL, 37, 
        NULL, GETDATE(), NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);

SELECT IDENT_CURRENT('SalesLT.Product');

SELECT * 
FROM SalesLT.Product
WHERE ProductID = IDENT_CURRENT('SalesLT.Product');

/*
    2.	Insert a new category with two products
        Adventure Works is adding a product category for Bells and Horns 
        to its catalog. The parent category for the new category is 4 
        (Accessories). This new category includes the following two new 
        products:
            First product:
	            Name: Bicycle Bell
	            ProductNumber: BB-RING
	            StandardCost: 2.47
	            ListPrice: 4.99
	            ProductCategoryID: The ProductCategoryID for the new 
                    Bells and Horns category
	            SellStartDate: Today’s date
	        Second product:
	            Name: Bicycle Horn
	            ProductNumber: BB-PARP
	            StandardCost: 1.29
	            ListPrice: 3.75
	            ProductCategoryID: The ProductCategoryID for the new 
                    Bells and Horns category
	            SellStartDate: Today’s date

        - Write a query to insert the new product category, and then insert 
        the two new products with the appropriate ProductCategoryID value.
        - After you have inserted the products, query the SalesLT.Product 
        and SalesLT.ProductCategory tables to verify that the data has been 
        inserted.

*/

INSERT INTO SalesLT.ProductCategory
VALUES (4, 'Bells and Horns', DEFAULT, DEFAULT);

SELECT * FROM SalesLT.ProductCategory;
SELECT IDENT_CURRENT('SalesLT.ProductCategory');

INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BB-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE());

SELECT p.Name AS ProductName, pc.Name AS CategoryName
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS pc
ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');

/*
    Challenge 2: Update products
    You have inserted data for a product, but the pricing details are 
    not correct. You must now update the records you have previously 
    inserted to reflect the correct pricing. Tip: Review the 
    documentation for UPDATE in the Transact-SQL Language Reference.

    1.	Update product prices
	    - The sales manager at Adventure Works has mandated a 10% 
        price increase for all products in the Bells and Horns 
        category. Update the rows in the SalesLT.Product table for 
        these products to increase their price by 10%.

*/

UPDATE SalesLT.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');

SELECT p.Name, p.ListPrice
FROM SalesLT.Product AS p
WHERE ProductCategoryID = (
    SELECT pc.ProductCategoryID
    FROM SalesLT.ProductCategory AS pc
    WHERE pc.Name LIKE 'Bells and Horns'
)

/*
    2.	Discontinue products
    	The new LED lights you inserted in the previous challenge are 
        to replace all previous light products. Update the 
        SalesLT.Product table to set the DiscontinuedDate to today’s 
        date for all products in the Lights category (product category 
        ID 37) other than the LED Lights product you inserted previously.

*/

UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37 AND 
    Name NOT LIKE 'LED Lights';

SELECT ProductID, Name, DiscontinuedDate
FROM SalesLT.Product AS p
WHERE p.DiscontinuedDate IS NOT NULL;


/*
    Challenge 3: Delete products
        The Bells and Horns category has not been successful, and it 
        must be deleted from the database.
    
    1.	Delete a product category and its products
	    Delete the records for the Bells and Horns category and its 
        products. You must ensure that you delete the records from 
        the tables in the correct order to avoid a foreign-key 
        constraint violation.

*/

SELECT * FROM SalesLT.Product
WHERE ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');

DELETE FROM SalesLT.Product
WHERE ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');

DELETE FROM SalesLT.ProductCategory
WHERE Name LIKE 'Bells and Horns';

SELECT Name
From SalesLT.ProductCategory