INSERT INTO combinedVehicleStops ( stop_id, stop_cause, service_area, subject_race, subject_sex, subject_age, [timestamp], stop_date, stop_time, sd_resident, arrested, searched, obtained_consent, contraband_found, property_seized )
SELECT Vehicle_stops_2015_datasd.stop_id, Vehicle_stops_2015_datasd.stop_cause, Vehicle_stops_2015_datasd.service_area, Vehicle_stops_2015_datasd.subject_race, Vehicle_stops_2015_datasd.subject_sex, Vehicle_stops_2015_datasd.subject_age, Vehicle_stops_2015_datasd.timestamp, Vehicle_stops_2015_datasd.stop_date, Vehicle_stops_2015_datasd.stop_time, Vehicle_stops_2015_datasd.sd_resident, Vehicle_stops_2015_datasd.arrested, Vehicle_stops_2015_datasd.searched, Vehicle_stops_2015_datasd.obtained_consent, Vehicle_stops_2015_datasd.contraband_found, Vehicle_stops_2015_datasd.property_seized
FROM Vehicle_stops_2015_datasd;
