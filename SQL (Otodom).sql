-- 1) Analyzing Real Estate Market Trends Over Time
    -- Monthly Average Price Trend:
SELECT
    Year,
    Month,
    AVG(price) AS Average_Price
FROM
    otodom
GROUP BY
    Year,
    Month
ORDER BY
    Year,
    Month;

	-- Quarterly Price Trend
SELECT
    Year,
    DATEPART(QUARTER, timestamp) AS Quarter,
    AVG(price) AS Average_Price
FROM
    otodom
GROUP BY
    Year,
    DATEPART(QUARTER, timestamp)
ORDER BY
    Year,
    Quarter

	-- Count of Properties Listed by Year:
SELECT
    Year,
    COUNT(*) AS Properties_Listed
FROM
    otodom
GROUP BY
    Year
ORDER BY
    Year;

	-- Average Price By Number of Rooms
SELECT
    no_of_rooms,
    AVG(price) AS average_price
FROM 
    otodom
GROUP BY 
    no_of_rooms
ORDER BY
    average_price DESC

    -- Property Count by Market Type and Year:
SELECT
    market,
    Year,
    COUNT(*) AS Count
FROM
    otodom
GROUP BY
    market,
    Year
ORDER BY
    Year,
    market

	-- Segmenting by Remote Support (as a feature of interest):
SELECT
    remote_support,
    AVG(price) AS average_price_with_remote_support
FROM
    otodom
GROUP BY
    remote_support;

	-- Average Price by Location:
SELECT 
    location, 
    AVG(price) AS avg_price_by_location
FROM 
    otodom
GROUP BY 
    location
	
	-- Average Surface Area by Location:
SELECT 
	location,
	AVG(surface) AS avg_surface_area_by_location
FROM
	otodom
GROUP BY
	location

	-- Average Number of Rooms by Location
SELECT 
	location,
	AVG(no_of_rooms) AS avg_surface_area_by_location
FROM
	otodom
GROUP BY
	location


-- 3) Segmenting Properties
    -- Identifying Features with Highest Average Price:
SELECT market,
    AVG(price) AS average_price
FROM 
   otodom
GROUP BY 
   market
ORDER BY
    average_price DESC

   -- Window Function for Ranking Properties by Price within Market Segments:
SELECT
    posting_id,
    price,
    market,
    RANK() OVER (PARTITION BY market ORDER BY price DESC) AS price_rank
FROM
    otodom

   -- Common Table Expressions (CTEs) for Complex Queries:
WITH RankedProperties AS 
(
    SELECT
        posting_id,
        price,
        location,
        ROW_NUMBER() OVER (PARTITION BY location ORDER BY price DESC) AS rank
    FROM
        otodom
)
SELECT *
FROM RankedProperties
WHERE rank = 1
