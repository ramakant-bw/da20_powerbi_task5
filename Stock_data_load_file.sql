
-- Creating Database
-- Create Database Stock_data



-- Trading Data Table

CREATE TABLE stock_market_trades (
    Trade_ID INT PRIMARY KEY,
    User_ID INT NOT NULL,
    Stock_ID INT NOT NULL,
    Order_Type VARCHAR(10) CHECK (Order_Type IN ('Buy', 'Sell')),
    Order_Mode VARCHAR(20) CHECK (Order_Mode IN ('Market', 'Limit', 'StopLoss')),
    Trade_Date DATE NOT NULL,
    Trade_Time TIME NOT NULL,
    Quantity INT NOT NULL,
    Price_Per_Share DECIMAL(10,2) NOT NULL,
    Total_Value DECIMAL(15,2) NOT NULL,
    Brokerage_Fee DECIMAL(10,2) NOT NULL,
    Exchange VARCHAR(10) CHECK (Exchange IN ('NSE', 'BSE')),
    Sector VARCHAR(50),
    Trade_Status VARCHAR(20) CHECK (Trade_Status IN ('Executed', 'Pending', 'Cancelled')),
    Settlement_Date DATE,
    Currency VARCHAR(10) DEFAULT 'INR',
    StopLoss DECIMAL(10,2),
    Target_Price DECIMAL(10,2),
    Holding_Type VARCHAR(20) CHECK (Holding_Type IN ('Intraday', 'Delivery', 'F&O')),
	Foreign Key(User_Id) References Users(User_Id),
	Foreign Key(Stock_Id) References Stocks(Stock_Id)	
);


-- drop table stock_market_trades

COPY stock_market_trades
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_trades_part1.csv'
DELIMITER ',' CSV HEADER;

COPY stock_market_trades
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_trades_part2.csv'
DELIMITER ',' CSV HEADER;

COPY stock_market_trades
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_trades_part3.csv'
DELIMITER ',' CSV HEADER;

COPY stock_market_trades
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_trades_part4.csv'
DELIMITER ',' CSV HEADER;

COPY stock_market_trades
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_trades_part5.csv'
DELIMITER ',' CSV HEADER;

----------------------------------------------------------------------------------------------

--User table

Create Table users (
	User_id Int Primary Key,
	Name Varchar(50),
	Email Varchar(100),
	Mobile_no Bigint,
	Country Varchar(6),
	State Varchar(20),
	City Varchar(20),
	Account_Type Varchar(40),
	Risk_Profile Varchar(15));

-- Drop Table users

-- Alter table users 
-- Alter column Mobile_no type bigint;

COPY users
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_users.csv'
DELIMITER ',' CSV HEADER;


-----------------------------------------------------------------------------------

--Stocks Table

CREATE TABLE stocks (
    Stock_ID INT PRIMARY KEY,
    Symbol VARCHAR(255),
    Company_Name VARCHAR(255),
    Sector VARCHAR(255),
    Industry VARCHAR(255),
    Exchange VARCHAR(50),
    ISIN VARCHAR(255),
    MarketCap BIGINT,
    Face_Value INT,
    Dividend_Yield NUMERIC(5, 2)
);

COPY stocks
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stocks_list.csv'
DELIMITER ',' CSV HEADER;



----------------------------------------------------------------------------------------------------------


-- Portfolio Table

Create table portfolios (
	Portfolio_ID Int,
	User_ID Int,
	Stock_ID Int,
	Holding_Qty Numeric(10,2),
	Avg_Buy_Price Numeric(10,2),
	Current_Price Numeric(10,2),
	Unrealized_Profit Numeric(10,2),
	Last_Updated Date,
	Foreign Key (User_Id) References users(User_Id),
	Foreign Key (Stock_Id) References Stocks(Stock_Id));

-- Drop Table Portfolios;

COPY portfolios
FROM 'D:\DA20\Power_Bi\Power_BI_Task\da20_powerbi_task5\stock_market_portfolios.csv'
DELIMITER ',' CSV HEADER;





-- Tables
Select * from users;
Select * from portfolios;
Select * from stocks;
Select * from stock_market_trades;

-----------------------------------------------------------------------------------------------------


-- Que 1. Give Name of user who has highest unrealized profit.

select u.name, sum(p.Unrealized_Profit) as unrealized_profit from users as u 
inner join portfolios as p on u.user_id = p.user_id group by u.name order by sum(p.Unrealized_Profit) desc limit 1

