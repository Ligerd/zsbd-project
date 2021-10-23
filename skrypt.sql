use airlines;

SELECT passenger.name, passenger.surname, depart.airport_name as depart, arrival.airport_name as arrivals 
FROM airlines.passenger 
join ticket on passenger.passenger_id = ticket.passenger 
join flight on ticket.flight = flight.flight_id
join airRoute on flight.route_id = airRoute.airRoute_id
join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
join airport as depart on  airRoute.departures_airport = depart.airport_id
where passenger.name="Lewie" and passenger.surname="Hearnes";



select airport.city as departures_city, flight.flight_date, passenger.passenger_name, passenger.passenger_surname from airport
join airRoute on airRoute.departures_airport = airport.airport_id
join flight on airRoute.airRoute_id = flight.route_id
join ticket on flight.flight_date = ticket.flight_date
join passenger on passenger.passenger_id = ticket.passenger
where airport.city = "Dubai"
order by passenger.passenger_name;

-- procedury 


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


CALL createNewRoute("Lewie", "Hearnes"); 

CALL getraiseByNameAndSurname("Lewie", "Hearnes"); 


DELIMITER //

-- funkcje 

CREATE FUNCTION flightLenght ( start_city varchar(15), end_city varchar(15) )
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
    

   RETURN TIMEDIFF(arrival,depart);

END; //

DELIMITER ;

SELECT flightLenght ("Dubai","Barcelona");
DROP FUNCTION CalcIncome;


-- Widoki

CREATE VIEW allFlightsWithTime AS
select depart.city as depart, arrival.city as arrivals, tariff.cost as price, flight.departure as timeofdeparture, 
flight.arrival as timeofarrival, aircompany.aircompany_name as transporter
from flight
join airRoute on flight.route_id = airRoute.airRoute_id
join tariff on tariff.airRoute_id = airRoute.airRoute_id
join aircompany on aircompany.aircompany_id = airRoute.aircompany
join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
join airport as depart on  airRoute.departures_airport = depart.airport_id;

SELECT * FROM allFlightsWithTime;

CREATE VIEW passengersWithDestinations AS
select passenger.name, passenger.surname, passenger.passport, depart.city as depart, arrival.city as arrivals from passenger
join ticket on ticket.passenger = passenger_id
join tariff on tariff.tariff_id = ticket.tariff
join airRoute on airRoute.airRoute_id = tariff.airRoute_id
join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
join airport as depart on  airRoute.departures_airport = depart.airport_id;

select * from passengersWithDestinations;

