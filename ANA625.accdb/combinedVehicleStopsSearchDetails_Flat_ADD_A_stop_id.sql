INSERT INTO combinedVehicleStopsSearchDetails_Flat ( stop_id )
SELECT combinedVehicleStopsSearchDetails.stop_id
FROM combinedVehicleStopsSearchDetails
WHERE (((combinedVehicleStopsSearchDetails.search_details_id)<>'NULL') AND ((combinedVehicleStopsSearchDetails.search_details_type)<>'NULL') AND ((combinedVehicleStopsSearchDetails.search_details_description)<>'NULL'))
GROUP BY combinedVehicleStopsSearchDetails.stop_id;
