SELECT combinedVehicleStops.sd_resident, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.sd_resident
ORDER BY Count(combinedVehicleStops.stop_id) DESC;
