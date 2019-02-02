SELECT combinedVehicleStops.property_seized, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.property_seized
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
