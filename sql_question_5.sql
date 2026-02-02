--QUESTION 5
--#SQL (Daily Price Surge Analysis)
--#1 Calculate daily percentage change in Close price using the LAG() window function.
SELECT
    [Date],[Close],
    ( [Close] - LAG([close]) OVER (ORDER BY [Date]) )
    * 100.0 / LAG([Close]) over (ORDER by [Date]) 
    AS DailyPercentChange
FROM Citigroup;



--# 2 Rank days within each month by percentage change (from highest to lowest).
SELECT Date,DailyPercentChange,
    RANK() OVER (PARTITION BY MONTH(Date), YEAR(Date) ORDER BY DailyPercentChange DESC
    ) AS MonthRank
from (
    select Date,
        ( [Close] - LAG([Close]) OVER (ORDER BY [Date]))
        * 100.0 / LAG([Close]) OVER (ORDER BY [Date]) 
        AS DailyPercentChange
    FROM Citigroup
) AS T;



--#3 Retrieve only the top 3 surge days per month for performance review.

WITH CTE AS (
    SELECT [Date],
        ( [Close] - LAG([Close]) OVER (ORDER BY [Date]) )
        * 100.0 / LAG([Close]) OVER (ORDER BY [Date]) 
        AS DailyPercentChange
    FROM Citigroup)
SELECT *
FROM (SELECT *,
           RANK() OVER (
               PARTITION BY YEAR([Date]), MONTH([Date])
               ORDER BY DailyPercentChange DESC
           ) AS MonthRank
	FROM CTE) T
WHERE MonthRank <= 3;
