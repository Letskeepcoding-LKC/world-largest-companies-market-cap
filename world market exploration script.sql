-- Output the data in the marketcap table
SELECT *
FROM marketcap_database.marketcap;

-- Getting the total market cap
SELECT SUM(Market_Cap) AS Total_market_cap
FROM marketcap_database.marketcap;

-- Ranking the companies market_cap in a descending order
SELECT RANK() OVER (ORDER BY market_cap DESC) AS rank_position, 
	companies, market_cap
FROM marketcap_database.marketcap;

-- Sum of the top 10 companies leading the world market
SELECT SUM(market_cap) AS top_10_marketcap
FROM ( 
	SELECT market_cap 
	FROM marketcap 
	ORDER BY market_cap DESC 
	LIMIT 10
	) t;

-- Getting the percentage of the top 10 companies leading the world market
SELECT ROUND(
	(SUM(market_cap) /(SELECT SUM(market_cap) FROM marketcap)) * 100, 2) AS top_10_percentage
FROM ( 
	SELECT market_cap 
	FROM marketcap 
	ORDER BY market_cap DESC 
	LIMIT 10
	) t;

-- Getting the cumulative market price
SELECT companies,
    market_cap,
    SUM(market_cap) OVER (ORDER BY market_cap DESC) AS cumulative_market_cap
FROM marketcap;

-- The market cap for each country
SELECT 
	countries, 
	SUM(market_cap) AS marketcap_per_country
FROM marketcap
GROUP BY countries
ORDER BY marketcap_per_country DESC
;
    
-- Number of companies in a country
SELECT countries, 
	COUNT(*) AS number_of_companies
FROM marketcap
GROUP BY countries
ORDER BY number_of_companies DESC
;
    
-- Market share by countries
SELECT countries, ROUND(
	(SUM(market_cap) /(SELECT SUM(market_cap) FROM marketcap)) * 100, 2) AS market_share_percentage
FROM  marketcap
GROUP BY countries
ORDER BY market_share_percentage DESC 
;

-- Total market cap for each country
SELECT countries,
    SUM(market_cap) AS total_market_cap
FROM marketcap
GROUP BY countries
ORDER BY total_market_cap DESC;


