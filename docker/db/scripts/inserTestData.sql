use airlines;

insert into aircompany(nip, aircompany_name) values(4854559,"Meemm");
insert into aircompany(nip, aircompany_name) values(1975148,"Demivee");
insert into aircompany(nip, aircompany_name) values(5335416,"Abata");
insert into aircompany(nip, aircompany_name) values(3316880,"Kwilith");
insert into aircompany(nip, aircompany_name) values(4438128,"Fatz");

insert into plane(aircompany, model, number_of_seats, engine, board_number) values(1, "Boeing 737-300",96, 'Turboprop','4USBU53537C2');
insert into plane(aircompany, model, number_of_seats, engine, board_number) values(2, "Antonov An-158",65,'Turbojet', 'JTDKN3DU9AQ1');
insert into plane(aircompany, model, number_of_seats, engine, board_number) values(3, "Boeing 737 MAX 7",41,"Turbofan", '1N4AL2APXAW1');
insert into plane(aircompany, model, number_of_seats, engine, board_number) values(4, "Cessna Citation CJ3",51,"Turbofan", 'JA32U2FU8FU3');
insert into plane(aircompany, model, number_of_seats, engine, board_number) values(5, "Canadair Challenger",88,"Turboshaft", '2C4RDGBG8FR9');

-- insert into board(plane_id, aircompany_id, board_number) values(1,2,'4USBU53537C2');
-- insert into board(plane_id, aircompany_id, board_number) values(2,3,'JTDKN3DU9AQ1');
-- insert into board(plane_id, aircompany_id, board_number) values(2,4,'1N4AL2APXAW1');
-- insert into board(plane_id, aircompany_id, board_number) values(3,5,'JA32U2FU8FU3');
-- insert into board(plane_id, aircompany_id, board_number) values(4,5,'2C4RDGBG8FR9');

-- insert into city(city_name) values("Barcelona");
-- insert into city(city_name) values("Warsaw");
-- insert into city(city_name) values("Dubai");
-- insert into city(city_name) values("London");
-- insert into city(city_name) values("Paris");

insert into airport(city, airport_name) values("Dubai", "Dubai International Airport");
insert into airport(city, airport_name) values("Barcelona", "Barcelona-El Prat Airport");
insert into airport(city, airport_name) values("Warsaw", "Warsaw Chopin Airport");
insert into airport(city, airport_name) values("London", "London Heathrow Airport");
insert into airport(city, airport_name) values("Paris", "Charles de Gaulle Airport");

insert into airRoute( plane_id, departures_airport, arrivals_airport, airline_name) values( 1, 1, 2, "Ryanair");
insert into airRoute( plane_id, departures_airport, arrivals_airport, airline_name) values( 4, 3, 5, "Flydubai");
insert into airRoute( plane_id, departures_airport, arrivals_airport, airline_name) values( 2, 4, 2, "Wizzair");
insert into airRoute( plane_id, departures_airport, arrivals_airport, airline_name) values( 5, 1, 5, "Vueling");
insert into airRoute( plane_id, departures_airport, arrivals_airport, airline_name) values( 1, 2, 4, "Ryanair");

insert into pilot(pilot_name,pilot_surname) values('Nicolis','Tiddeman');
insert into pilot(pilot_name,pilot_surname) values('Rozelle','Dimbleby');
insert into pilot(pilot_name,pilot_surname) values('Fran','Shulem');
insert into pilot(pilot_name,pilot_surname) values('Raddy','McLardie');
insert into pilot(pilot_name,pilot_surname) values('Roderich','Bonnell');
insert into pilot(pilot_name,pilot_surname) values('Hervey','Watkin');


insert into flight(flight_date, route_id, plane, pilot) values('2021-01-23',1, 2, 1);
insert into flight(flight_date, route_id, plane, pilot) values('2021-04-27',2, 1, 2);
insert into flight(flight_date, route_id, plane, pilot) values('2021-07-13',3, 4,  3);
insert into flight(flight_date, route_id, plane, pilot) values('2021-03-03',4, 5, 4);
insert into flight(flight_date, route_id, plane, pilot) values('2021-06-21',5, 3, 5);

insert into passenger(passenger_name,passenger_surname, passport) values('Lewie','Hearnes',"2G4WD58236");
insert into passenger(passenger_name,passenger_surname, passport) values('Wadsworth','Conring',"1YVHZ8BA9A");
insert into passenger(passenger_name,passenger_surname, passport) values('Lanae','Mousdall',"JH4CU2E60A");
insert into passenger(passenger_name,passenger_surname, passport) values('Willamina','Noods',"WBASP2C55C");
insert into passenger(passenger_name,passenger_surname, passport) values('Miles','Grafhom',"WAUKF78P49");
insert into passenger(passenger_name,passenger_surname, passport) values('Gussie','Napleton',"5YMKT6C56F");

-- insert into timesheet(airport_id,airRoute_id,departure_time, arrival_time) values(1,1,"12:15","15:35")-- ;
-- insert into timesheet(airport_id,airRoute_id,departure_time, arrival_time) values(4,3,"12:35","15:35");
-- insert into timesheet(airport_id,airRoute_id,departure_time, arrival_time) values(1,4,"13:35","15:35");
-- insert into timesheet(airport_id,airRoute_id,departure_time, arrival_time) values(3,2,"16:15","21:35");
-- insert into timesheet(airport_id,airRoute_id,departure_time, arrival_time) values(2,5,"07:25","15:35");


insert into timesheet(airRoute_id,departure_time, arrival_time) values(1,"12:15","15:35");
insert into timesheet(airRoute_id,departure_time, arrival_time) values(3,"12:35","15:35");
insert into timesheet(airRoute_id,departure_time, arrival_time) values(4,"13:35","15:35");
insert into timesheet(airRoute_id,departure_time, arrival_time) values(2,"16:15","21:35");
insert into timesheet(airRoute_id,departure_time, arrival_time) values(5,"07:25","15:35");

insert into tariff(airRoute_id,cost) values(1,20);
insert into tariff(airRoute_id,cost) values(2,700);
insert into tariff(airRoute_id,cost) values(3,300);
insert into tariff(airRoute_id,cost) values(4,80);
insert into tariff(airRoute_id,cost) values(5,100);

insert into ticket(passenger, tariff, flight_date) values(1,1,'2021-01-23');
insert into ticket(passenger, tariff, flight_date) values(2,1,'2021-01-23');
insert into ticket(passenger, tariff, flight_date) values(3,1,'2021-01-23');
insert into ticket(passenger, tariff, flight_date) values(2,2,'2021-04-27');
insert into ticket(passenger, tariff, flight_date) values(3,3,'2021-07-13');
insert into ticket(passenger, tariff, flight_date) values(4,4,'2021-03-03');
insert into ticket(passenger, tariff, flight_date) values(5,5,'2021-06-21');


CREATE USER 'readonly'@'%' IDENTIFIED BY 'readonly';
GRANT SELECT ON *.* TO 'readonly'@'%';

FLUSH PRIVILEGES;

CREATE USER 'readinsert'@'%' IDENTIFIED BY 'readinsert';
GRANT SELECT, INSERT, UPDATE ON *.* TO 'readinsert'@'%';


FLUSH PRIVILEGES;


-- SELECT passenger.passenger_name, passenger.passenger_surname, ticket.flight_date, depart.airport_name as depart, arrival.airport_name as arrivals 
-- FROM airlines.passenger 
-- join ticket on passenger.passenger_id = ticket.passenger 
-- join flight on ticket.flight_date = flight.flight_date 
-- join airRoute on flight.route_id = airRoute.airRoute_id
-- join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
-- join airport as depart on  airRoute.departures_airport = depart.airport_id
-- where passenger.passenger_name="Lewie" and passenger.passenger_surname="Hearnes";

-- select airport.city as departures_city, flight.flight_date, passenger.passenger_name, passenger.passenger_surname from airport
-- join airRoute on airRoute.departures_airport = airport.airport_id
-- join flight on airRoute.airRoute_id = flight.route_id
-- join ticket on flight.flight_date = ticket.flight_date
-- join passenger on passenger.passenger_id = ticket.passenger
-- where airport.city = "Dubai"
-- order by passenger.passenger_name;