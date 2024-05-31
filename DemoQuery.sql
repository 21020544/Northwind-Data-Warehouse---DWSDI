-- Các bảng đã tạo trong kho dữ liệu
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE';
-- Cụ thể 1 bảng Orders đã tạo
SELECT * FROM [dbo].[Orders]; 
-- Bảng thêm vào kho dữ liệu thời gian
select * from ProductLifespan; 
-- Query kiểm tra trigger đã cài đặt trên bảng ProductLifespan
INSERT INTO ProductLifespan (ProductID, FromDate, ToDate)
VALUES (61, '1996-07-04 00:00:00.000', '1996-08-29 00:00:00.000'); 
-- Truy vấn trên các bảng thời gian ProducetUnitPrice và ProductCategory
 SELECT C.CategoryName, AVG(PU.UnitPrice) AS AvgUnitPrice -- Average unit price by category as of January 1st, 2017.
 FROM
 Products P, ProductUnitPrice PU, ProductCategory PC, Categories C
 WHERE P.ProductID = PC.ProductID AND PC.CategoryID = C.CategoryID AND
 P.ProductID = PU.ProductID AND
 PC.FromDate <= '2017-06-01' AND '2017-01-01' < PC.ToDate AND
 PU.FromDate <= '2017-06-01' AND '2017-01-01' < PU.ToDate
 GROUP BY C.CategoryName;
-- Thủ tục truy vấn khả năng bán hàng của nhân viên tại mỗi quốc gia 
EXEC [dbo].[Employee Sales by Country] 
    @Beginning_Date = '1996-07-04 00:00:00.000',
    @Ending_Date = '1998-04-14 00:00:00.000';
-- Bảng version 2 trong các bảng Multiversion
select * from SalesT2;
-- Truy vấn view xem thông tin trên 2 version
select * from SalesV1;

