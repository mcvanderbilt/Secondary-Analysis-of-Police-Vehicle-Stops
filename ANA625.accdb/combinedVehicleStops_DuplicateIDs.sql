SELECT combinedVehicleStops.stop_id, Count(combinedVehicleStops.stop_id) AS CountOfstop_id
FROM combinedVehicleStops
GROUP BY combinedVehicleStops.stop_id
HAVING (((Count(combinedVehicleStops.stop_id))>1));
