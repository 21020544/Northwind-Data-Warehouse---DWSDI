CREATE TABLE [dbo].[ProductUnitPrice] (
    [ProductID]      INT    NOT NULL,
     [UnitPrice]       MONEY,
    [FromDate] DATETIME,
    [ToDate] DATETIME,
   
    
    CONSTRAINT [FK_ProductUnitPrice_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


CREATE TABLE [dbo].[ProductLifespan] (
    [ProductID]      INT    NOT NULL,
    [FromDate] DATETIME  NOT NULL,
    [ToDate] DATETIME,
   
     CONSTRAINT [PK_ProductLifespan] PRIMARY KEY CLUSTERED ([FromDate]), 
    CONSTRAINT [FK_ProductLifespan_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);
CREATE TABLE [dbo].[ProductCategory] (
    [ProductID]      INT    NOT NULL,
     [CategoryID]   INT           NOT NULL,
    [FromDate] DATETIME  NOT NULL,
    [ToDate] DATETIME,
   
     CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED ([FromDate]), 
    CONSTRAINT [FK_ProductCategory_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);

ALTER TABLE [dbo].[ProductLifespan] 

ADD CONSTRAINT [AK_ProductLifespan_Products] UNIQUE  ( [ProductID], [FromDate]);
ALTER TABLE [dbo].[ProductCategory] 

ADD CONSTRAINT [AK_ProductCategory_Products] UNIQUE  ( [ProductID], [FromDate]);
ALTER TABLE [dbo].[ProductUnitPrice] 

ADD CONSTRAINT [AK_ProductUnitPrice_Products] UNIQUE  ( [ProductID], [FromDate]);
