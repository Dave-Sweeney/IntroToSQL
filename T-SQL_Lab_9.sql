/*
    Challenge:

    Use a transaction to insert data into multiple talbes

    When a sales order header is inserted, it must have at least one 
    corresponding sales order detail record.  Currently, you use the 
    following code to accomplish this:

    -- Get the highest order ID and add 1
    DECLARE @OrderID INT;
    SELECT @OrderID = MAX(SalesOrderID) + 1 FROM SalesLT.SalesOrderHeader;

    -- Insert the order header
    INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
    VALUES (@OrderID, GETDATE(), DATEADD(month, 1, GETDATE()), 1, 'CARGO TRANSPORT');

    -- Insert one or more order details
    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
    VALUES (@OrderID, 1, 712, 8.99);


    You need to encapsulate this code in a transaction so that all 
    inserts succeed or fail as an atomic unit of work.
*/

BEGIN TRY
BEGIN TRANSACTION;
-- Get the highest order ID and add 1
    DECLARE @OrderID INT;
    SELECT @OrderID = MAX(SalesOrderID) + 1 FROM SalesLT.SalesOrderHeader;

    -- Insert the order header
    INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
    VALUES (@OrderID, GETDATE(), DATEADD(month, 1, GETDATE()), 1, 'CARGO TRANSPORT');

    -- Insert one or more order details
    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
    VALUES (@OrderID, 1, 712, 8.99);
COMMIT TRANSACTION;
PRINT 'Transaction completed successfully';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction did NOT complete successfully';
END CATCH;
GO