

use uber;
select * from passengers_csv pc ;
select * from rides_date_csv rdc ;
select * from drivers_csv dc ;

#Q1: List the drivers who have driven rides in all pickup locations.
select distinct driver_id,pickup_location from rides_date_csv rdc 
where pickup_location in (select distinct pickup_location from rides_date_csv rdc);

#Q2: Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
SELECT AVG(fare_amount)
FROM rides_date_csv rdc 
WHERE passenger_id IN (SELECT passenger_id FROM passengers_csv pc WHERE total_spent > 300);

#Q3: List the bottom 5 drivers based on their average earnings.
SELECT driver_id, avg(earnings) AS avg_earnings 
FROM drivers_csv dc 
GROUP BY driver_id 
ORDER BY avg_earnings asc LIMIT 5;

#Q4: Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT SUM(fare_amount)
FROM rides_date_csv rdc2 
WHERE passenger_id IN (SELECT passenger_id FROM rides_date_csv rdc GROUP BY passenger_id
HAVING COUNT(DISTINCT payment_method) > 1);

#Q5: Retrieve rides where the fare amount is significantly above the average fare amount.
SELECT *
FROM rides_date_csv rdc 
WHERE fare_amount > (SELECT AVG(fare_amount) from rides_date_csv);

#Q6: List the drivers who have completed rides on the same day they joined.
SELECT dc.driver_id, dc.driver_name
FROM drivers_csv dc JOIN rides_date_csv rdc
ON dc.driver_id = rdc.driver_id
WHERE dc.join_date = rdc.ride_timestamp;

#Q7: Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT AVG(fare_amount)
FROM rides_date_csv rdc 
WHERE passenger_id IN (
    SELECT passenger_id
    FROM  rides_date_csv rdc 
    GROUP BY passenger_id
    HAVING COUNT(DISTINCT payment_method) > 1);
   
 #Q8: Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.
 SELECT pickup_location, AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) from rides_date_csv rdc2)) * 100.0 / (SELECT AVG(fare_amount) FROM rides_date_csv rdc3) AS percentage_increase
FROM rides_date_csv rdc 
GROUP BY pickup_location
ORDER BY percentage_increase desc;

#Q9: Retrieve rides where the dropoff location is the same as the pickup location.
SELECT *
FROM rides_date_csv rdc 
WHERE pickup_location = dropoff_location;

#Q10: Calculate the average rating of drivers who have driven rides with varying pickup locations.
SELECT AVG(rating) FROM drivers_csv dc WHERE driver_id IN (SELECT DISTINCT driver_id FROM rides_date_csv rdc 
    GROUP BY driver_id
    HAVING COUNT(DISTINCT pickup_location) > 1 );















