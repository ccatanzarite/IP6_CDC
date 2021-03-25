USE crime_data;
-- 1
SELECT count(distinct(crime_type)) AS unique_crimes
FROM incident_reports;
-- 16 unique crimes

-- 2
SELECT crime_type,count(crime_type) AS num_crimes
FROM incident_reports
GROUP BY crime_type
ORDER BY crime_type ASC;
-- 16 rows returned

-- 3
SELECT count(datediff(date_occured,date_reported))
FROM incident_reports
WHERE datediff(date_reported,date_occured) = 0;
-- 961309 crimes where the crime occured on the same day as when it was reported

-- 4
SELECT date_reported,date_occured,crime_type,(year(date_reported) - year(date_occured)) AS date_diff_years
FROM incident_reports
WHERE datediff(date_reported,date_occured) > 365
ORDER BY date_diff_years DESC;
-- 1000 rows returned, the biggest difference in years was 91 years

-- 5
SELECT year(date_occured) as year, count(year(date_occured)) as num_incidents
FROM incident_reports
WHERE year(date_occured)>2011
GROUP BY year
ORDER BY year DESC;
-- 10 rows returned, most incidents occured in 2016

-- 6
SELECT *
FROM incident_reports
WHERE crime_type = "ROBBERY";
-- 1000 rows returned

-- 7
SELECT lmpd_division, incident_number, date_occured
FROM incident_reports
WHERE att_comp = "ATTEMPTED" AND crime_type = "ROBBERY"
ORDER BY lmpd_division,date_occured ASC;
-- 1000 rows returned

-- 8
SELECT date_occured, crime_type
FROM incident_reports
WHERE zip_code = 40202
ORDER BY crime_type, date_occured;
-- 1000 rows occured

-- 9
SELECT zip_code,count(*)
FROM incident_reports
WHERE crime_type = "MOTOR VEHICLE THEFT"
GROUP BY zip_code;
-- 41 rows returned

-- 10
SELECT count(distinct(city))
FROM incident_reports;
-- 234 different cities reported

-- 11
SELECT city, count(*) AS num_of_incidents
FROM incident_reports
GROUP BY city
ORDER BY count(*) DESC;
#LVIL has the second highest amount of incidents but I believe that is just an 
#abbreveation of Louisville. So the second would actually be Lyndon. Also the 6th city with the most
#incidents is a blank value

-- 12
SELECT uor_desc,crime_type
FROM incident_reports
WHERE crime_type != "OTHER"
ORDER BY uor_desc,crime_type;
# uor_desc seems to be a subcategory of the crime_type. crim_type seems like a larger catergory and the actual charge.alter

-- 13
SELECT count(distinct(lmpd_beat))
FROM incident_reports;
-- There is 60 LMPD beats

-- 14
SELECT *
FROM nibrs_codes;
-- 61 nibrs codes exist

-- 15
SELECT count(distinct(nibrs_code))
FROM incident_reports;
-- There is 54 unique nibrs_code's in the incident_reports tables

-- 16
SELECT date_occured,block_address,zip_code,offense_description
FROM incident_reports,nibrs_codes
WHERE (incident_reports.nibrs_code = nibrs_codes.offense_code) AND
(incident_reports.nibrs_code = 240 OR 250 OR 270 OR 280)
ORDER BY block_address;
-- 1000 rows returned

-- 17 
SELECT zip_code, offense_against
FROM incident_reports,nibrs_codes
WHERE (incident_reports.nibrs_code = nibrs_codes.offense_code) AND
(incident_reports.nibrs_code != 999) AND
LENGTH(zip_code) = 5
ORDER BY zip_code;
-- 1000 rows returned

-- 18
SELECT offense_against, count(*)
FROM nibrs_codes,incident_reports
WHERE (incident_reports.nibrs_code = nibrs_codes.offense_code) AND
offense_against != ""
GROUP BY offense_against;
-- 6 rows returned

-- 19
SELECT lmpd_division, count(*)
FROM incident_reports
GROUP BY lmpd_division
HAVING count(*) > 100000;
-- This eliminates Metro Louisville and the 5th division

-- 20
SELECT offense_category, crime_type
FROM nibrs_codes,incident_reports
WHERE (incident_reports.nibrs_code = nibrs_codes.offense_code) AND
crime_type != "THEFT"
ORDER BY  crime_type;