SELECT combinedVehicleStops.contraband_found, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.contraband_found
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
