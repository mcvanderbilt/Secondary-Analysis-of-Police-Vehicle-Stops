INSERT INTO combinedVehicleStopsSearchDetails ( stop_id, search_details_id, search_details_type, search_details_description )
SELECT Vehicle_stops_search_details_2017_datasd.stop_id, Vehicle_stops_search_details_2017_datasd.search_details_id, Vehicle_stops_search_details_2017_datasd.search_details_type, Nz([search_details_description],'') & IIf(IsNull([Field5]),'',IIf(IsNull([search_details_description]),'',' - ') & [Field5]) AS description
FROM Vehicle_stops_search_details_2017_datasd;
