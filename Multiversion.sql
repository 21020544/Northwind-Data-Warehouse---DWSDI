
CREATE TABLE [dbo].[SalesT2] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [EmployeeID]      INT          NOT NULL,
    [ProductID]       INT           NOT NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [StoreID]      INT           NOT NULL,
    [UnitPrice] MONEY    NOT NULL,
    [Quantity]  SMALLINT  NOT NULL,
    [Discount]  REAL     NOT NULL,
    [OrderNo]   INT      NOT NULL, 
    [OrderLineNo]   INT      NOT NULL,
    [ShippedDate]    DATETIME      NULL,
    [ShipperID]   INT            NULL,


    CONSTRAINT [FK_SalesT2_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_SalesT2_ShipperID] FOREIGN KEY ([ShipperID]) REFERENCES [dbo].[Shippers] ([ShipperID]),
    CONSTRAINT [FK_SalesT2_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_SalesT2_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [dbo].[Stores] ([StoreID]),
    CONSTRAINT [FK_SalesT2_ProductsID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]),
    CONSTRAINT [AK_SalesT2_ProductsID] UNIQUE ([OrderNo],[OrderLineNo])
);


GO

CREATE TABLE [dbo].[SalesT3] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [EmployeeID]      INT          NOT NULL,
    [ProductID]       INT           NOT NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [SupplierID]   INT           NOT NULL,
    [UnitPrice] MONEY    NOT NULL,
    [Quantity]  SMALLINT  NOT NULL,
    [Discount]  REAL     NOT NULL,
    [OrderNo]   INT      NOT NULL, 
    [OrderLineNo]   INT      NOT NULL,
    [ShippedDate]    DATETIME      NULL,
    [ShipperID]   INT            NULL,


    CONSTRAINT [FK_SalesT3_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_SalesT3_ShipperID] FOREIGN KEY ([ShipperID]) REFERENCES [dbo].[Shippers] ([ShipperID]),
    CONSTRAINT [FK_SalesT3_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_SalesT3_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID]),
    CONSTRAINT [FK_SalesT3_ProductsID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]),
    CONSTRAINT [AK_SalesT3_ProductsID] UNIQUE ([OrderNo],[OrderLineNo])
);


GO



 
CREATE VIEW SalesV3 AS
 SELECT CustomerID, EmployeeID, NULL as ShipperID,
 S.ProductID, P.SupplierID,
 CASE WHEN COUNT(*) = 1 THEN MAX(OrderNo) ELSE NULL END as OrderNo,
 CASE WHEN COUNT(*) = 1 THEN MAX(OrderLineNo) ELSE NULL 
 END as OrderLineNo , AVG(S.UnitPrice) as AVGUnitPrice, SUM(Quantity) as SUMQuantity, AVG(Discount) as AVGDiscount
 FROM Sales S JOIN Stores T ON S.StoreID = T.StoreID JOIN
 Products P ON S.ProductID = P.ProductID
 GROUP BY CustomerID, EmployeeID,
 S.ProductID, P.SupplierID
 UNION ALL
 SELECT CustomerID, EmployeeID,
 ShipperID, S.ProductID, P.SupplierID,
 CASE WHEN COUNT(*) = 1 THEN MAX(OrderNo) ELSE NULL END,
 CASE WHEN COUNT(*) = 1 THEN MAX(OrderLineNo) ELSE NULL
 END, AVG(S.UnitPrice), SUM(Quantity), AVG(Discount)
 FROM SalesT2 S JOIN Stores T ON S.StoreID = T.StoreID JOIN
 Products P ON S.ProductID = P.ProductID
 GROUP BY CustomerID, EmployeeID, 
 ShipperID, S.ProductID, P.SupplierID
 UNION ALL
 SELECT CustomerID, EmployeeID,
 ShipperID, ProductID, SupplierID, OrderNo,
 OrderLineNo, UnitPrice, Quantity, Discount
 FROM SalesT3