--6

--#Identify for each day whether the stock:
--Closed Higher
--Closed Lower
--No Change

SELECT [Date],[Close],
    CASE
        WHEN [Close] > LAG([Close]) OVER (ORDER BY [Date]) THEN 'Closed_higher'
        WHEN [Close] < LAG([Close]) OVER (ORDER BY [Date]) THEN 'Closed_lower'
        ELSE 'No_change'
    END AS CloseStatus
FROM Citigroup;

--#2Add an additional condition: if High = Low = Open = Close, classify the day as “No Trading Movement” instead of “No Change”

SELECT [Date], [Close],
    CASE
        WHEN [Open] = [High] AND [High] = [Low] AND [Low] = [Close] THEN 'No Trading Movement'
        WHEN [Close] > LAG([Close]) OVER (ORDER BY [Date]) THEN 'Closed_higher'
        WHEN [Close] < LAG([Close]) OVER (ORDER BY [Date]) THEN 'Closed Lower'
        ELSE 'No_Change'
    END AS Status
FROM Citigroup;

--#3 Return the total number of days in each category.
SELECT  Status, COUNT(*) AS TotalDays
FROM (SELECT
        CASE
            WHEN [Open] = [High]AND [High] = [Low]AND [Low] = [Close] THEN 'No Trading Movement'
            WHEN [Close] > LAG([Close]) OVER (ORDER BY [Date]) THEN 'Closed Higher'
            WHEN [Close] < LAG([Close]) OVER (ORDER BY [Date])  THEN 'Closed Lower'
            ELSE 'No Change'
      END AS Status
    FROM Citigroup
) T
GROUP BY Status;
