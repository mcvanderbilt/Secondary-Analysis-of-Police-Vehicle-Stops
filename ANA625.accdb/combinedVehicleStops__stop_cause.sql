SELECT combinedVehicleStops.stop_cause, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.stop_cause
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
