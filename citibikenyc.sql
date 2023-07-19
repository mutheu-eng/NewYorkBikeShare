SELECT *
FROM citibiketrip;

-- cleaning the data 
ALTER TABLE citibiketrip
DROP COLUMN start_times;

SELECT SUBSTRING(started_at,10,5) AS start_time
FROM citibiketrip; 

ALTER TABLE citibiketrip ADD COLUMN started_time TIME;
ALTER TABLE citibiketrip ADD COLUMN ended_time TIME;

SELECT *
FROM citibiketrip;

UPDATE citibiketrip
SET
    started_time = SUBSTRING(started_at,10,5),
	ended_time = SUBSTRING(ended_at,10,5);

ALTER TABLE citibiketrip ADD COLUMN ride_time TIME;
  
SELECT TIME_FORMAT(started_time,'%H:%i')AS started_time,
       TIME_FORMAT(ended_time,'%H:%i') AS ended_time,
       TIME_FORMAT(ride_length,'%H:%i') AS ride_time
FROM citibiketrip;

 UPDATE citibiketrip
 SET
 started_time  = TIME_FORMAT(started_time,'%H:%i'),
 ended_time = TIME_FORMAT(ended_time,'%H:%i'),
ride_length = TIME_FORMAT(ride_length,'%H:%i');
  
SELECT *
FROM citibiketrip;

SELECT SUBSTRING(started_at,1,9) AS start_time
FROM citibiketrip; 

ALTER TABLE citibiketrip ADD COLUMN cycle_date DATE;

UPDATE citibiketrip
SET 
cycle_date = DATE(STR_TO_DATE(started_at,'%m/%d/%Y %H:%i:%s'));

ALTER TABLE citibiketrip 
DROP COLUMN ride_time;

ALTER TABLE citibiketrip 
DROP COLUMN ended_at;
    
ALTER TABLE citibiketrip 
DROP COLUMN weekday_name;

ALTER TABLE citibiketrip 
DROP COLUMN week_name;
    
SELECT *
FROM citibiketrip;

SELECT cycle_date,DAYNAME(cycle_date) AS day_name
FROM citibiketrip;

ALTER TABLE citibiketrip ADD COLUMN day_name VARCHAR(9);

UPDATE citibiketrip
SET 
day_name = DAYNAME(cycle_date);

SELECT *
FROM citibiketrip;

SELECT MAX(ride_length) AS Max_ride_length
FROM citibiketrip;

SELECT member_casual,COUNT(day_name) AS count_of_day
FROM citibiketrip
GROUP BY member_casual;

SELECT rideable_type,COUNT(member_casual) AS count_of_member
FROM citibiketrip
WHERE member_casual = 'casual'
GROUP BY rideable_type;

SELECT member_casual,COUNT(*) AS count_of_member
FROM citibiketrip
GROUP BY member_casual;

SELECT day_name,COUNT(member_casual) AS count_of_member
FROM citibiketrip
WHERE member_casual = 'casual'
GROUP BY day_name
ORDER BY count_of_member DESC;

SELECT member_casual,MAX(ride_length)AS max_ride_length
FROM citibiketrip
GROUP BY member_casual
HAVING member_casual = 'casual';

SELECT start_station_name, COUNT(*) AS ride_count
FROM citibiketrip
WHERE member_casual = 'casual'
GROUP BY start_station_name
ORDER BY ride_count DESC
LIMIT 5;

SELECT end_station_name, COUNT(*) AS ride_count
FROM citibiketrip
WHERE member_casual = 'casual'
GROUP BY end_station_name
ORDER BY ride_count DESC
LIMIT 5;

SELECT cb.start_station_name,COUNT(*) AS ride_count
FROM citibiketrip AS cb
JOIN citibiketrip AS ct 
ON cb.ride_id = ct.ride_id
WHERE cb.start_station_name = ct.end_station_name AND cb.member_casual = 'casual'
GROUP BY cb.start_station_name
ORDER BY ride_count DESC
LIMIT 5;

SELECT cb.start_station_name,COUNT(*) AS ride_count
FROM citibiketrip AS cb
JOIN citibiketrip AS ct 
ON cb.ride_id = ct.ride_id
WHERE cb.start_station_name != ct.end_station_name AND cb.member_casual = 'casual'
GROUP BY cb.start_station_name
ORDER BY ride_count DESC
LIMIT 5;

