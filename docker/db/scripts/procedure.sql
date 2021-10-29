use airlines;

DELIMITER //

CREATE PROCEDURE getraiseByNameAndSurname(
	IN name VARCHAR(50), in surname varchar(50)
)
BEGIN
	SELECT passenger.name, passenger.surname, depart.airport_name as depart, arrival.airport_name as arrivals,
    flight.departure as departure_time, flight.arrival as arrival_time
	FROM airlines.passenger 
	join ticket on passenger.passenger_id = ticket.passenger 
	join flight on ticket.flight = flight.flight_id
	join airRoute on flight.route_id = airRoute.airRoute_id
	join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
	join airport as depart on  airRoute.departures_airport = depart.airport_id
	where passenger.name=name and passenger.surname=surname;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE createNewRoute(
	IN departureAirportName VARCHAR(50), in arrivalAirportName varchar(50)
)
BEGIN
	
	DECLARE errno INT;
	
    DECLARE depart integer;
	DECLARE arrival integer;
	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    SELECT errno AS MYSQL_ERROR;
    ROLLBACK;
    END;
    
	START TRANSACTION;
    
    select airport_id into depart from airport where airport_name = departureAirportName;
	select airport_id into arrival from airport where airport_name = arrivalAirportName;


	IF(depart IS NULL) THEN
        insert into airport (airport_name) values (departureAirportName);
        select airport_id into depart from airport where airport_name = departureAirportName;
    END IF;
	
    IF(arrival IS NULL) THEN
        insert into airport (airport_name) values (arrivalAirportName);
        select airport_id into arrival from airport where airport_name = arrivalAirportName;
    END IF;
    
    insert into airRoute(departures_airport, arrivals_airport) values (depart,arrival);
    
    COMMIT WORK;
END //

DELIMITER ;