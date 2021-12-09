use airlines;

-- funkcje 
DELIMITER //
CREATE FUNCTION flightLenght ( start_city varchar(30), end_city varchar(30) )
RETURNS varchar(255)
DETERMINISTIC
BEGIN

   DECLARE depart datetime;
   DECLARE arrival datetime;
   
	select  flight.departure into depart from flight
	join airRoute on flight.route_id = airRoute.airRoute_id
	join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
	join airport as depart on  airRoute.departures_airport = depart.airport_id
	where depart.city = start_city and arrival.city=end_city;
    
	select  flight.arrival into arrival from flight
	join airRoute on flight.route_id = airRoute.airRoute_id
	join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
	join airport as depart on  airRoute.departures_airport = depart.airport_id
	where depart.city = start_city and arrival.city=end_city;
	if (depart is not null and arrival is not null) then
		RETURN TIMEDIFF(arrival,depart);
	else
		SIGNAL sqlstate '45001' set message_text = "Selected citys is not correct ";
	end if;
   RETURN TIMEDIFF(arrival,depart);

END; //

DELIMITER ;