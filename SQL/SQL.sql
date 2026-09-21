SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Month) AS total_months,
    MIN(Month) AS first_month,
    MAX(Month) AS last_month
FROM flights;



SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT(
        FlightDate, '-', 
        Reporting_Airline, '-', 
        Flight_Number_Reporting_Airline, '-', 
        Origin, '-', 
        Dest, '-', 
        CRSDepTime
    )) AS unique_flights
FROM flights;




SELECT
    SUM(Year IS NULL) AS Year_nulls,
    SUM(Quarter IS NULL) AS Quarter_nulls,
    SUM(Month IS NULL) AS Month_nulls,
    SUM(DayofMonth IS NULL) AS DayofMonth_nulls,
    SUM(DayOfWeek IS NULL) AS DayOfWeek_nulls,
    SUM(FlightDate IS NULL) AS FlightDate_nulls,
    SUM(Reporting_Airline IS NULL) AS Airline_nulls,
    SUM(Flight_Number_Reporting_Airline IS NULL) AS FlightNumber_nulls,
    SUM(Origin IS NULL) AS Origin_nulls,
    SUM(Dest IS NULL) AS Destination_nulls
FROM flights;




SELECT 
    Month,
    COUNT(*) AS total_rows
FROM flights
GROUP BY Month
ORDER BY Month;



SELECT
    COUNT(*) AS total_flights,  
    SUM(Cancelled) AS cancelled_flights,
    ROUND(SUM(Cancelled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percent
FROM flights;



SELECT
    Reporting_Airline,
    COUNT(*) AS total_flights,
    SUM(Cancelled) AS cancelled_flights,
    ROUND(SUM(Cancelled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percent
FROM flights
GROUP BY Reporting_Airline
ORDER BY cancellation_rate_percent DESC;


	
    SELECT 
    COUNT(*) AS total_flights,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate_percent,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM
    flights
WHERE
    Cancelled = 0;
    
    
    
    
    
    SELECT
    Reporting_Airline,
    COUNT(*) AS total_flights,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate_percent,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
GROUP BY Reporting_Airline
ORDER BY delay_rate_percent DESC;



-- now from here airport




SELECT
    Origin,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Origin
ORDER BY total_flights DESC
LIMIT 10;




SELECT
    Dest,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Dest
ORDER BY total_flights DESC
LIMIT 10;



SELECT
    Origin,
    Dest,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Origin, Dest
ORDER BY total_flights DESC
LIMIT 10;



SELECT
    Origin,
    Dest,
    COUNT(*) AS total_flights,
    SUM(Cancelled) AS cancelled_flights,
    ROUND(SUM(Cancelled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percent
FROM flights
GROUP BY Origin, Dest
HAVING COUNT(*) >= 500
ORDER BY cancellation_rate_percent DESC
LIMIT 10;





SELECT
    CancellationCode,
    COUNT(*) AS cancelled_flights,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM flights
WHERE Cancelled = 1
GROUP BY CancellationCode
ORDER BY cancelled_flights DESC;




SELECT
    ROUND(SUM(CarrierDelay), 0) AS carrier_delay_minutes,
    ROUND(SUM(WeatherDelay), 0) AS weather_delay_minutes,
    ROUND(SUM(NASDelay), 0) AS nas_delay_minutes,
    ROUND(SUM(SecurityDelay), 0) AS security_delay_minutes,
    ROUND(SUM(LateAircraftDelay), 0) AS late_aircraft_delay_minutes
FROM flights
WHERE Cancelled = 0;


SELECT
    ROUND(SUM(CarrierDelay) * 100.0 /
        (SUM(CarrierDelay) + SUM(WeatherDelay) + SUM(NASDelay) +
         SUM(SecurityDelay) + SUM(LateAircraftDelay)), 2) AS carrier_pct,

    ROUND(SUM(WeatherDelay) * 100.0 /
        (SUM(CarrierDelay) + SUM(WeatherDelay) + SUM(NASDelay) +
         SUM(SecurityDelay) + SUM(LateAircraftDelay)), 2) AS weather_pct,

    ROUND(SUM(NASDelay) * 100.0 /
        (SUM(CarrierDelay) + SUM(WeatherDelay) + SUM(NASDelay) +
         SUM(SecurityDelay) + SUM(LateAircraftDelay)), 2) AS nas_pct,

    ROUND(SUM(SecurityDelay) * 100.0 /
        (SUM(CarrierDelay) + SUM(WeatherDelay) + SUM(NASDelay) +
         SUM(SecurityDelay) + SUM(LateAircraftDelay)), 2) AS security_pct,

    ROUND(SUM(LateAircraftDelay) * 100.0 /
        (SUM(CarrierDelay) + SUM(WeatherDelay) + SUM(NASDelay) +
         SUM(SecurityDelay) + SUM(LateAircraftDelay)), 2) AS late_aircraft_pct
FROM flights
WHERE Cancelled = 0;




SELECT
    Month,
    COUNT(*) AS total_flights,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate_percent,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
GROUP BY Month
ORDER BY delay_rate_percent DESC;





SELECT
    DayOfWeek,
    COUNT(*) AS total_flights,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate_percent,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
GROUP BY DayOfWeek
ORDER BY delay_rate_percent DESC;





SELECT
    Reporting_Airline,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Reporting_Airline
ORDER BY total_flights DESC
LIMIT 10;





SELECT
    Reporting_Airline,
    COUNT(*) AS total_flights,
    SUM(Cancelled) AS cancelled_flights,
    ROUND(SUM(Cancelled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percent,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate_percent,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
GROUP BY Reporting_Airline
ORDER BY delay_rate_percent DESC;




SELECT
    Reporting_Airline,
    COUNT(*) AS delayed_flights,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay,
    MAX(ArrDelay) AS max_arrival_delay
FROM flights
WHERE Cancelled = 0
  AND ArrDelay > 0
GROUP BY Reporting_Airline
ORDER BY avg_arrival_delay DESC;






SELECT
    COUNT(*) AS total_flights,
    SUM(Diverted) AS diverted_flights,
    ROUND(SUM(Diverted) * 100.0 / COUNT(*), 2) AS diversion_rate_percent
FROM flights
WHERE Cancelled = 0;





SELECT
    Origin,
    COUNT(*) AS total_flights,
    SUM(Diverted) AS diverted_flights,
    ROUND(SUM(Diverted) * 100.0 / COUNT(*), 2) AS diversion_rate_percent
FROM flights
WHERE Cancelled = 0
GROUP BY Origin
ORDER BY diverted_flights DESC
LIMIT 10;




SELECT
    Origin,
    Dest,
    COUNT(*) AS total_flights,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
  AND ArrDelay > 0
GROUP BY Origin, Dest
HAVING COUNT(*) >= 500
ORDER BY avg_arrival_delay DESC
LIMIT 10;



SELECT
    Reporting_Airline,
    COUNT(*) AS total_flights,
    SUM(ArrDel15 = 0) AS on_time_flights,
    ROUND(SUM(ArrDel15 = 0) * 100.0 / COUNT(*), 2) AS on_time_rate_percent
FROM flights
WHERE Cancelled = 0
GROUP BY Reporting_Airline
ORDER BY on_time_rate_percent DESC;




SELECT
    COUNT(*) AS total_flights,
    SUM(Cancelled) AS cancelled_flights,
    SUM(Diverted) AS diverted_flights,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(Cancelled) * 100.0 / COUNT(*), 2) AS cancellation_rate,
    ROUND(SUM(Diverted) * 100.0 / COUNT(*), 2) AS diversion_rate,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate,
    ROUND(SUM(ArrDel15 = 0 AND Cancelled = 0) * 100.0 /
          SUM(Cancelled = 0), 2) AS on_time_rate
FROM flights;




SELECT
    Origin,
    COUNT(*) AS total_flights,
    SUM(ArrDel15) AS delayed_flights,
    ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate_percent,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
GROUP BY Origin
HAVING COUNT(*) >= 10000
ORDER BY delay_rate_percent DESC
LIMIT 15;




SELECT
    Month,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Month
ORDER BY Month;






SELECT
    Month,
    SUM(CarrierDelay) AS carrier_delay,
    SUM(WeatherDelay) AS weather_delay,
    SUM(NASDelay) AS nas_delay,
    SUM(SecurityDelay) AS security_delay,
    SUM(LateAircraftDelay) AS late_aircraft_delay
FROM flights
WHERE Cancelled = 0
GROUP BY Month
ORDER BY Month;





SELECT
    Origin,
    Dest,
    COUNT(*) AS total_flights,
    SUM(ArrDelay) AS total_delay_minutes,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
FROM flights
WHERE Cancelled = 0
  AND ArrDelay > 0
GROUP BY Origin, Dest
HAVING COUNT(*) >= 500
ORDER BY total_delay_minutes DESC
LIMIT 10;




SELECT
    COUNT(*) AS total_rows,
    SUM(Cancelled) AS cancelled_flights,
    SUM(Diverted) AS diverted_flights,
    SUM(ArrDel15) AS delayed_flights,
    SUM(CASE WHEN Cancelled = 0 AND ArrDel15 = 0 THEN 1 ELSE 0 END) AS on_time_flights,
    SUM(CASE WHEN Cancelled = 0 AND ArrDel15 = 1 THEN 1 ELSE 0 END) AS delayed_non_cancelled
FROM flights;




SELECT
    Reporting_Airline,
    ROUND(AVG(DepDelay), 2) AS avg_departure_delay,
    ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay,
    ROUND(AVG(ArrDelay) - AVG(DepDelay), 2) AS delay_change
FROM flights
WHERE Cancelled = 0
GROUP BY Reporting_Airline
ORDER BY delay_change DESC;


SELECT
    Origin,
    COUNT(*) AS total_flights,
    SUM(DepDel15) AS delayed_departures,
    ROUND(SUM(DepDel15) * 100.0 / COUNT(*), 2) AS departure_delay_rate,
    ROUND(AVG(DepDelay), 2) AS avg_departure_delay
FROM flights
WHERE Cancelled = 0
GROUP BY Origin
HAVING COUNT(*) >= 10000
ORDER BY departure_delay_rate DESC
LIMIT 15;




SELECT
    DepTimeBlk,
    COUNT(*) AS total_flights,
    SUM(DepDel15) AS delayed_departures,
    ROUND(SUM(DepDel15) * 100.0 / COUNT(*), 2) AS departure_delay_rate
FROM flights
WHERE Cancelled = 0
GROUP BY DepTimeBlk
ORDER BY departure_delay_rate DESC;