use voter_db;

select * from traffic_accidents;

# 1. Total Crashes by Month

SELECT 
    crash_month,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    crash_month
ORDER BY 
    crash_month;
# 2. Total Crashes by Day of Week

SELECT 
    crash_day_of_week,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    crash_day_of_week
ORDER BY 
    crash_day_of_weeks ;
# 3. Crashes by Weather Condition

SELECT 
    weather_condition,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    weather_condition
ORDER BY 
    total_crashes DESC;
    
# 4. Crashes by Lighting Condition

SELECT 
    lighting_condition,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    lighting_condition
ORDER BY 
    total_crashes DESC;
# 5. Crashes by Road Surface Condition

SELECT 
    roadway_surface_cond,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    roadway_surface_cond
ORDER BY 
    total_crashes DESC;
# 6. Injury Severity Distribution

SELECT 
    most_severe_injury,
    COUNT(*) AS cases
FROM 
    accidents
GROUP BY 
    most_severe_injury
ORDER BY 
    cases DESC;
    
 #7. Crashes by Hour of the Day

SELECT 
    crash_hour,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    crash_hour
ORDER BY 
    crash_hour;
# 8. Total Fatalities per Month

SELECT 
    crash_month,
    SUM(injuries_fatal) AS total_fatalities
FROM 
    accidents
GROUP BY 
    crash_month
ORDER BY 
    crash_month;
# 9. Primary Causes of Crashes

SELECT 
    prim_contributory_cause,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    prim_contributory_cause
ORDER BY 
    total_crashes DESC
LIMIT 10;
# 10. Intersection-Related Crashes Count

SELECT 
    intersection_related_i,
    COUNT(*) AS total_crashes
FROM 
    accidents
GROUP BY 
    intersection_related_i;



# Q1: Which weather conditions are associated with the highest number of accidents?

SELECT weather_condition, COUNT(*) AS total_accidents
FROM accidents
GROUP BY weather_condition
ORDER BY total_accidents DESC;
# Purpose: Helps identify risky weather like rain, snow, or fog causing more accidents.

#Q2: How does lighting condition impact crash severity?

SELECT lighting_condition, most_severe_injury, COUNT(*) AS total
FROM accidents
GROUP BY lighting_condition, most_severe_injury
ORDER BY lighting_condition, total DESC;
# Purpose: Determines if poor lighting (e.g., dark-no street lights) increases severity (e.g., fatal, incapacitating).

# Q3: Which roadway surface conditions are most dangerous?

SELECT roadway_surface_cond, COUNT(*) AS total_accidents
FROM accidents
GROUP BY roadway_surface_cond
ORDER BY total_accidents DESC;
#Purpose: Finds out if wet, icy, or snowy roads contribute more to crashes.

# Q4: What are the top primary causes of crashes under poor weather conditions?

SELECT weather_condition, prim_contributory_cause, COUNT(*) AS total
FROM accidents
WHERE weather_condition IN ('Rain', 'Snow', 'Fog', 'Sleet')
GROUP BY weather_condition, prim_contributory_cause
ORDER BY weather_condition, total DESC;
#Purpose: Shows driver behavior or mechanical failure trends in bad weather.

# Q5: Do road defects contribute significantly to accidents?

SELECT road_defect, COUNT(*) AS total_accidents
FROM accidents
GROUP BY road_defect
ORDER BY total_accidents DESC;
#Purpose: Helps determine if infrastructure issues (e.g., potholes) need fixing.

# Q6: Time-based accident trends under unsafe conditions

SELECT crash_hour, lighting_condition, COUNT(*) AS total
FROM accidents
WHERE lighting_condition LIKE '%Dark%'
GROUP BY crash_hour, lighting_condition
ORDER BY crash_hour;
# Purpose: Understands high-risk hours when lighting is poor (e.g., late nights).


# Q7: What are the most common first crash types under adverse weather conditions?

SELECT weather_condition, first_crash_type, COUNT(*) AS total
FROM accidents
WHERE weather_condition NOT IN ('Clear', 'Unknown')
GROUP BY weather_condition, first_crash_type
ORDER BY total DESC;
#Purpose: Identifies if crash types like rear-end or sideswipe are more likely in rain, snow, etc.

# Q8: Which combinations of road surface and lighting cause the most severe injuries?

SELECT roadway_surface_cond, lighting_condition, most_severe_injury, COUNT(*) AS total
FROM accidents
WHERE most_severe_injury IN ('FATAL', 'INCAPACITATING INJURY')
GROUP BY roadway_surface_cond, lighting_condition, most_severe_injury
ORDER BY total DESC;
# Purpose: Evaluates joint impact of poor lighting and slippery roads on fatal injuries.

# Q9: What hours of the day see the most fatal accidents?

SELECT crash_hour, COUNT(*) AS fatal_crashes
FROM accidents
WHERE injuries_fatal > 0
GROUP BY crash_hour
ORDER BY fatal_crashes DESC;
# Purpose: Identifies high-risk hours (e.g., late nights, early mornings) with fatal crashes.

# Q10: Which days of the week have the most severe injuries?

SELECT crash_day_of_week, SUM(injuries_fatal + injuries_incapacitating) AS severe_injuries
FROM accidents
GROUP BY crash_day_of_week
ORDER BY severe_injuries DESC;
#Purpose: Understands patterns like weekend severity or weekday rush-hour injuries.

# Q11: Are certain traffic control devices ineffective in preventing severe crashes?

SELECT traffic_control_device, COUNT(*) AS fatal_or_severe_crashes
FROM accidents
WHERE injuries_fatal > 0 OR injuries_incapacitating > 0
GROUP BY traffic_control_device
ORDER BY fatal_or_severe_crashes DESC;
#Purpose: Measures how well signals, signs, and roundabouts prevent serious accidents.

# Q12: Correlation between road alignment and fatality?

SELECT alignment, COUNT(*) AS fatal_crashes
FROM accidents
WHERE injuries_fatal > 0
GROUP BY alignment
ORDER BY fatal_crashes DESC;
#Purpose: See if curved or sloped roads have more fatalities than straight ones.

# Q13: Top 5 causes of accidents during nighttime

SELECT prim_contributory_cause, COUNT(*) AS total
FROM accidents
WHERE lighting_condition LIKE '%Dark%'
GROUP BY prim_contributory_cause
ORDER BY total DESC
LIMIT 5;
# Purpose: Targets driver behavior or infrastructure issues in low-visibility conditions.