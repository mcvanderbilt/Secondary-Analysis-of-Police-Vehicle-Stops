SELECT combinedVehicleStops.subject_sex, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.subject_sex
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
