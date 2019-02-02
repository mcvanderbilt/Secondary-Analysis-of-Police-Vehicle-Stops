SELECT combinedVehicleStops.searched, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.searched
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
