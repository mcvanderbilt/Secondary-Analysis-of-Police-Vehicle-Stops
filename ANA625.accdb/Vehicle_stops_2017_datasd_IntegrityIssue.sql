SELECT Vehicle_stops_2017_datasd.stop_cause, Vehicle_stops_2017_datasd.service_area, Vehicle_stops_2017_datasd.subject_race
FROM Vehicle_stops_2017_datasd
WHERE (((Vehicle_stops_2017_datasd.subject_sex)<>'' And (Vehicle_stops_2017_datasd.subject_sex) Not In ('M','F','X')))
GROUP BY Vehicle_stops_2017_datasd.stop_cause, Vehicle_stops_2017_datasd.service_area, Vehicle_stops_2017_datasd.subject_race;
