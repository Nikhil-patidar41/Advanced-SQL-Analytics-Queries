use prt

--QUESTION 4
--#1 Compare each day’s Volume to the previous day’s volume using a window function.
SELECT Date,Volume,
    LAG(Volume) OVER (ORDER BY Date) AS PreviousDayVolume
from Citigroup;


--#2 Add a new column called VolumeChange that categorizes each day as:
--'Increased' if current day volume > previous day volume
--'Decreased' if current day volume < previous day volume
--'Same' otherwise
SELECT Date,Volume,
    CASE
        WHEN Volume>LAG(Volume) OVER (ORDER BY Date) THEN 'Increased'
        WHEN Volume<LAG(Volume) OVER (ORDER BY Date) THEN 'Decreased'
        ELSE 'Same'
    END AS VolumeChange
FROM Citigroup;

--#3 Compute a 7-day rolling average of Volume for trend analysis.
SELECT Date,Volume,
    AVG(Volume) over(ORDER BY [Date] ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling7DayAvg
FROM Citigroup;


