SELECT combinedVehicleStopsSearchDetails.stop_id, CONCATRELATED('search_details_type','combinedVehicleStopsSearchDetails',"cstr(stop_id) = '" & [stop_id] & "'") AS search_details_type_flat, CONCATRELATED('search_details_description','combinedVehicleStopsSearchDetails',"cstr(stop_id) = '" & [stop_id] & "'") AS search_details_description_flat INTO combinedVehicleStopsSearchDetails_Flat
FROM combinedVehicleStopsSearchDetails
GROUP BY combinedVehicleStopsSearchDetails.stop_id;
