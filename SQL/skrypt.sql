use airlines;
SHOW VARIABLES LIKE "secure_file_priv";
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


CALL createNewRoute("Lewie", null);  

CALL getraiseByNameAndSurname("Lewie", "Hearnes");  




-- funkcje 
DELIMITER //
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

SELECT flightLenght ("Dubdai","Barcelona");

DROP FUNCTION flightLenght; 

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
		SIGNAL sqlstate '45001' set message_text = "Selected citys is not exist";
	end if;
   RETURN TIMEDIFF(arrival,depart);

END; //

DELIMITER ;


-- Widoki

CREATE VIEW allFlightsWithTime AS
select depart.city as depart, arrival.city as arrivals, tariff.cost as price, flight.departure as timeofdeparture, 
flight.arrival as timeofarrival, aircompany.aircompany_name as transporter
from flight
join airRoute on flight.route_id = airRoute.airRoute_id
join tariff on tariff.airRoute_id = airRoute.airRoute_id
join aircompany on aircompany.aircompany_id = airRoute.aircompany
join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
join airport as depart on  airRoute.departures_airport = depart.airport_id
order by (depart.city);

SELECT * FROM allFlightsWithTime;

CREATE VIEW passengersWithDestinations AS
select passenger.name, passenger.surname, passenger.passport, depart.city as depart, arrival.city as arrivals from passenger
join ticket on ticket.passenger = passenger_id
join tariff on tariff.tariff_id = ticket.tariff
join airRoute on airRoute.airRoute_id = tariff.airRoute_id
join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
join airport as depart on  airRoute.departures_airport = depart.airport_id
order by passenger.surname;

select * from passengersWithDestinations;



-- trigger 
DELIMITER $$
create trigger airlines before insert on passenger for each row
begin 
	DECLARE rowcount INT;
	SELECT COUNT(*) 
	INTO rowcount
    FROM passenger
    where passenger.passport = new.passport;
	IF rowcount > 0 THEN
        SIGNAL sqlstate '45001' set message_text = "Passport must be unique. This passenger alredy in database";
    END IF; 
END $$

DELIMITER ;

-- insert into passenger(name,surname, passport) values('Lewie','Hearnes',"2G3WD58236");

-- index
 
CREATE unique INDEX Ix_passport_surname_name ON passenger(passport, surname, name);

CREATE INDEX Ix_city ON airport(city);

CREATE unique INDEX Ix_depart ON flight(departure);

CREATE INDEX Ix_flight_number ON flight(flight_number);

drop index Ix_passport_surname_name on passenger;

SHOW INDEX FROM passenger;


--

SET GLOBAL event_scheduler = ON; 
SET @@GLOBAL.event_scheduler = ON; 
SET GLOBAL event_scheduler = 1; 
SET @@GLOBAL.event_scheduler = 1;

delimiter |
  CREATE EVENT e_daily_flight_stat
     ON SCHEDULE
       EVERY 1 MINUTE
     COMMENT 'Saves total number of sessions then clears the table each day'
     DO
     begin
     
	SET @TS = DATE_FORMAT(NOW(),'_%Y_%m_%d_%H_%i_%s');
	SET @FOLDER = '/usr/local/raport/';
	SET @PREFIX = 'report';
	SET @EXT    = '.csv';
	set @QUARY = "select CURRENT_DATE as fly_date, flight.flight_number as flight_number, count(*) as number_pass from passenger join ticket on ticket.passenger = passenger_id join flight on ticket.flight = flight.flight_id WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR) AND departure <= NOW() group by flight.flight_number INTO OUTFILE '";
	SET @CMD = CONCAT(@QUARY,@FOLDER,@PREFIX,@TS,@EXT,
	"' FIELDS ENCLOSED BY '\"'",
	" TERMINATED BY ','"," 
	ESCAPED BY '\"'",
	" LINES TERMINATED BY '\\n';");

	PREPARE statement FROM @CMD;
	EXECUTE statement;
END |
delimiter ;

drop event e_daily_flight_stat;

select count(*) as number_pass, flight.flight_number from passenger 
join ticket on ticket.passenger = passenger_id
join flight on ticket.flight = flight.flight_id
WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR)
  AND departure <= NOW()
group by flight.flight_number;
  
  
--   SELECT CURRENT_DATE;

insert into flight( route_id, plane, pilot, departure, arrival, flight_number) values(5, 3, 5, '2021-10-27 06:45:56', '2021-10-27 12:45:56', "JH4CL96938");
insert into ticket(passenger, tariff, flight) values(1,1,6);
SELECT *
FROM flight
WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR)
  AND departure <= NOW();
-- select CURRENT_DATE as fly_date, flight.flight_number as flight_number, count(*) as number_pass from passenger join ticket on ticket.passenger = passenger_id join flight on ticket.flight = flight.flight_id WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR) AND departure <= NOW() group by flight.flight_number 


		-- select CURRENT_DATE as fly_date, flight.flight_number as flight_number, count(*) as number_pass from passenger 
-- 		join ticket on ticket.passenger = passenger_id
-- 		join flight on ticket.flight = flight.flight_id
-- 		WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR)
-- 			AND departure <= NOW()
-- 		group by flight.flight_number 


SET @TS = DATE_FORMAT(NOW(),'_%Y_%m_%d_%H_%i_%s');
SET @FOLDER = '/usr/local/raport/';
SET @PREFIX = 'report';
SET @EXT    = '.csv';
set @QUARY = "select CURRENT_DATE as fly_date, flight.flight_number as flight_number, count(*) as number_pass from passenger join ticket on ticket.passenger = passenger_id join flight on ticket.flight = flight.flight_id WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR) AND departure <= NOW() group by flight.flight_number INTO OUTFILE '";
SET @CMD = CONCAT(@QUARY,@FOLDER,@PREFIX,@TS,@EXT,
"' FIELDS ENCLOSED BY '\"'",
" TERMINATED BY ','"," 
ESCAPED BY '\"'",
" LINES TERMINATED BY '\\n';");

PREPARE statement FROM @CMD;
EXECUTE statement;


use airlines;
insert into flight( route_id, plane, pilot, departure, arrival, flight_number) values(1, 2, 1, '2021-10-29 12:45:56', '2021-10-29 15:45:56', "1G6D357V58");
insert into flight( route_id, plane, pilot, departure, arrival, flight_number) values(2, 3, 3, '2021-10-29 12:43:56', '2021-10-29 12:45:56', "1G6DT57V53");
insert into ticket(passenger, tariff, flight) values(1,1,6);
insert into ticket(passenger, tariff, flight) values(2,1,6);
insert into ticket(passenger, tariff, flight) values(4,1,7);

insert into passenger(name,surname, passport) values('Lewie','Hearnes',"2G4WD58236");