
-- Create the date_dim table
CREATE TABLE dbo.date_dim
(
    [date_key] INT NOT NULL PRIMARY KEY,
    [full_date] DATE,
    [year] INT,
    [quarter] INT,
    [quarter_name] VARCHAR(20),
    [month] INT,
    [month_name] VARCHAR(20),
    [week] INT,
    [day] INT,
    [day_name] VARCHAR(9)
)
GO

