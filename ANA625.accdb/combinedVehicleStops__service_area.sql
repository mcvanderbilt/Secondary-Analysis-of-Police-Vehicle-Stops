SELECT combinedVehicleStops.service_area, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.service_area
ORDER BY combinedVehicleStops.service_area;
