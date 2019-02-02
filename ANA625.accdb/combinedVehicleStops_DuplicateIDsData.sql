SELECT combinedVehicleStops.stop_id, combinedVehicleStops.stop_cause, combinedVehicleStops.service_area, combinedVehicleStops.subject_race, combinedVehicleStops.subject_sex, combinedVehicleStops.subject_age, combinedVehicleStops.timestamp, combinedVehicleStops.stop_date, combinedVehicleStops.stop_time, combinedVehicleStops.sd_resident, combinedVehicleStops.arrested, combinedVehicleStops.searched, combinedVehicleStops.obtained_consent, combinedVehicleStops.contraband_found, combinedVehicleStops.property_seized
FROM combinedVehicleStops_DuplicateIDs INNER JOIN combinedVehicleStops ON combinedVehicleStops_DuplicateIDs.stop_id = combinedVehicleStops.stop_id
ORDER BY combinedVehicleStops.stop_id, combinedVehicleStops.timestamp;
