create database wfdata;
use wfdata;
create table sales(
SaleID int ,
Salesperson varchar(100),
SaleAmount int,
SaleDate date
);
select * from sales;

select *, sum(SaleAmount) over (order by SaleDate) as RunningTotal from sales;


select *, sum(SaleAmount) over (partition by SalesPerson order by SaleDate) AS CumulativeSalePerPerson
FROM sales;


SELECT 
  SaleID, 
  Salesperson, 
  SaleAmount, 
  SaleDate, 
  RANK() OVER (ORDER BY SaleAmount DESC) AS SaleRank
FROM sales;

SELECT SaleID, SaleDate, Salesperson, SaleAmount, 
       AVG(SaleAmount) OVER (
                    ORDER BY SaleDate 
                    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
                            ) AS MovingAverage
FROM sales;

-- FIRST_VALUE() and LAST_VALUE() Example
SELECT 
  SaleID, 
  Salesperson, 
  SaleAmount, 
  FIRST_VALUE(SaleAmount) OVER (ORDER BY SaleDate) AS FirstSaleAmount,
  LAST_VALUE(SaleAmount)  OVER (ORDER BY SaleDate 
                               RANGE BETWEEN UNBOUNDED PRECEDING AND 
                               UNBOUNDED FOLLOWING
                               ) AS LastSaleAmount
FROM sales;

-- LEAD() and LAG() Example
SELECT 
  SaleID, 
  Salesperson, 
  SaleAmount, 
  LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount,
  LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM sales;

-- ROWS Window Frame Specification
SELECT 
  SaleID, 
  Salesperson, 
  SaleAmount, 
  AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM sales;

-- RANGE Window Frame Specification
SELECT 
  SaleID, 
  Salesperson, 
  SaleAmount, 
  SUM(SaleAmount) OVER (ORDER BY SaleAmount RANGE BETWEEN 10 PRECEDING AND 50 FOLLOWING) AS CumulativeSum
FROM sales;





