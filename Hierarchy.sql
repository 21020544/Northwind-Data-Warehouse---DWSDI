ALTER TABLE [dbo].[Date]
  ADD UNIQUE ([full_date]);
  go
  
CREATE TABLE [dbo].[Stores] (
    [StoreID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (20)  NOT NULL,
    [Type]           NVARCHAR (30)  NULL,
    [Address]         NVARCHAR (60)  NULL,
    [City]            NVARCHAR (15)  NULL,
    [Region]          INT  NULL,
    [PostalCode]      NVARCHAR (10)  NULL,
   
    CONSTRAINT [PK_Stores] PRIMARY KEY CLUSTERED ([StoreID] ASC),
    
    CONSTRAINT [FK_Stores_Stores] FOREIGN KEY ([Region]) REFERENCES [dbo].[Region] ([RegionID])
)



GO
CREATE TABLE [dbo].[Sales] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [EmployeeID]      INT          NOT NULL,
    [ProductID]       INT           NOT NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [StoreID]      INT           NOT NULL,
    [UnitPrice] MONEY    NOT NULL,
    [Quantity]  SMALLINT  NOT NULL,
    [Discount]  REAL     NOT NULL,

    
    CONSTRAINT [FK_Sales_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_Sales_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_Sales_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [dbo].[Stores] ([StoreID]),
    CONSTRAINT [FK_Sales_ProductsID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO

ALTER TABLE [dbo].[Sales]
  ADD [OrderNo]   INT      NOT NULL, [OrderLineNo]   INT      NOT NULL,

  UNIQUE ([OrderNo],[OrderLineNo]);
  go
