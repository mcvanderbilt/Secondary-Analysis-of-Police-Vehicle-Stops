SELECT combinedVehicleStopsSearchDetails.stop_id, combinedVehicleStopsSearchDetails.search_details_type
FROM combinedVehicleStopsSearchDetails
WHERE (((combinedVehicleStopsSearchDetails.search_details_id)<>'NULL') AND ((combinedVehicleStopsSearchDetails.search_details_description)<>'NULL'))
GROUP BY combinedVehicleStopsSearchDetails.stop_id, combinedVehicleStopsSearchDetails.search_details_type
HAVING (((combinedVehicleStopsSearchDetails.search_details_type)<>'NULL'));
