SELECT combinedVehicleStops.arrested, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.arrested
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
