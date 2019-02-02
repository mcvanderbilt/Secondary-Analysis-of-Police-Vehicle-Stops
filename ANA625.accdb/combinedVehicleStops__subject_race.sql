SELECT combinedVehicleStops.subject_race, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.subject_race
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
