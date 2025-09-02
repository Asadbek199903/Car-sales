SELECT * 
FROM car_sales

-- Shows how many cars were sold by brands (manufacturers) and fuel type 

SELECT manufacturer,fuel_type,  COUNT(model) AS cars_sold
FROM car_sales
--WHERE fuel_type = 'Petrol'
GROUP BY manufacturer, fuel_type
ORDER BY manufacturer

-- SHows average price of car models were sold by (manufacturer)

SELECT manufacturer, model, COUNT(model) AS cars_sold, ROUND(AVG(price),2) AS average_price
FROM car_sales
--WHERE manufacturer = 'Ford' OR manufacturer = 'BMW'
GROUP BY manufacturer, model
ORDER BY manufacturer, model

-- SHows most expensive cars by every brand and model

SELECT manufacturer, model, MAX (price) AS most_expensive
FROM car_sales 
--WHERE manufacturer = 'Ford' OR manufacturer = 'BMW'
GROUP BY manufacturer, model
ORDER BY most_expensive DESC

-- SHows average price of car models were sold by (manufacturer) versus average price of all models

SELECT manufacturer, 
	   model, 
	   price,
	   (SELECT ROUND(AVG(price), 2) AS average_price_all FROM car_sales)
FROM car_sales AS c1
--WHERE manufacturer = 'Ford' OR manufacturer = 'BMW'
ORDER BY manufacturer, price ASC

--Shows price level relative to average price of all models

SELECT 
    manufacturer, 
    model, 
    price,
    CASE 
        WHEN price > (SELECT AVG(price) FROM car_sales) THEN 'Expensive'
        WHEN price < (SELECT AVG(price) FROM car_sales) THEN 'Cheap'
        ELSE 'Average'
    END AS price_level,
    (SELECT ROUND(AVG(price), 2) FROM car_sales) AS average_price
FROM car_sales
ORDER BY manufacturer, price DESC;

-- Filtering for only 100 cheapest cars

SELECT 
    manufacturer, 
    model, 
    price,
    'Cheap' AS price_level
    --'Expensive' AS price_level
FROM car_sales
WHERE price < (SELECT AVG(price) FROM car_sales)
--WHERE price > (SELECT AVG(price) FROM car_sales)
ORDER BY manufacturer, price ASC
LIMIT 100

-- Shows total number of cars by price level

SELECT manufacturer,
	   model,
	   engine_size,
    CASE 
        WHEN price > (SELECT AVG(price) FROM car_sales) THEN 'Expensive'
        WHEN price < (SELECT AVG(price) FROM car_sales) THEN 'Cheap'
        ELSE 'Average'
    END AS price_level,
    COUNT(model) AS total_num_cars_sold
FROM car_sales
GROUP BY 
		manufacturer, 
		model, 
		engine_size, 
		price_level
ORDER BY manufacturer

-- Shows average distance of mileage driven by each model

SELECT manufacturer, model, ROUND(AVG(mileage), 2) AS average_mileage_driven
FROM car_sales 
GROUP BY manufacturer, model
ORDER BY manufacturer

-- Shows most and less used cars relative to average mileage driven

SELECT manufacturer,
	   model,
	CASE
	    WHEN mileage > (SELECT AVG(mileage) FROM car_sales) THEN 'Most used'
	    WHEN mileage < (SELECT AVG(mileage) FROM car_sales) THEN 'Less used'
	    ELSE 'Average'
	END AS car_usage_level
	--COUNT(model) AS num_model
FROM car_sales
--GROUP BY manufacturer, model, --car_usage_level
ORDER BY manufacturer

-- Shows most expensive models by manufacturers

SELECT 
    manufacturer,
    model,
    price
FROM car_sales AS c1
WHERE price = (
    SELECT MAX(price)
    FROM car_sales AS c2
    WHERE c1.manufacturer = c2.manufacturer
)
ORDER BY price DESC

-- Shows most used model by brand 

SELECT manufacturer, 
	   model, 
	   mileage,
	   year_manufactured
FROM car_sales AS c1 
WHERE mileage = (SELECT MAX(mileage)
                           FROM car_sales AS c2
                           WHERE c1.manufacturer = c2.manufacturer)
ORDER BY mileage DESC

-- Shows total number of cars sold by fuel type

SELECT
    manufacturer,
    model,
    SUM(CASE WHEN fuel_type = 'Petrol' THEN 1 ELSE 0 END) AS petrol_models,
    SUM(CASE WHEN fuel_type = 'Diesel' THEN 1 ELSE 0 END) AS diesel_podels,
    SUM(CASE WHEN fuel_type = 'Hybrid' THEN 1 ELSE 0 END) AS hybrid_models
FROM
    car_sales
GROUP BY
    manufacturer,
    model
ORDER BY
    manufacturer,
    model;

















	
	   



















