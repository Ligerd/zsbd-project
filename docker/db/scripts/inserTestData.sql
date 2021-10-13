SELECT * FROM airlines.aircompany;
use airlines;

insert into aircompany(nip, aircompany_name) values(4854559,"Meemm");
insert into aircompany(nip, aircompany_name) values(1975148,"Demivee");
insert into aircompany(nip, aircompany_name) values(5335416,"Abata");
insert into aircompany(nip, aircompany_name) values(3316880,"Kwilith");
insert into aircompany(nip, aircompany_name) values(4438128,"Fatz");

insert into plane(model, number_of_seats, engine, plane_usage) values("Boeing 737-300",96, 'Turboprop','Recreation');
insert into plane(model, number_of_seats, engine, plane_usage) values("Antonov An-158",65,'Turbojet', 'Recreation');
insert into plane(model, number_of_seats, engine, plane_usage) values("Boeing 737 MAX 7",41,"Turbofan", 'Military');
insert into plane(model, number_of_seats, engine, plane_usage) values("Cessna Citation CJ3",51,"Turbofan", 'Recreation');
insert into plane(model, number_of_seats, engine, plane_usage) values("Canadair Challenger",88,"Turboshaft", 'Recreation');

insert into board(plane_id, aircompany_id, board_number) values(1,2,'4USBU53537C2');
insert into board(plane_id, aircompany_id, board_number) values(2,3,'JTDKN3DU9AQ1');
insert into board(plane_id, aircompany_id, board_number) values(2,4,'1N4AL2APXAW1');
insert into board(plane_id, aircompany_id, board_number) values(3,5,'JA32U2FU8FU3');
insert into board(plane_id, aircompany_id, board_number) values(4,5,'2C4RDGBG8FR9');

insert into city(city_name) values("Barcelona");
insert into city(city_name) values("Warsaw");
insert into city(city_name) values("Dubai");
insert into city(city_name) values("London");
insert into city(city_name) values("Paris");

insert into airport(city, airport_name) values(3, "Dubai International Airport");
insert into airport(city, airport_name) values(1, "Barcelona-El Prat Airport");
insert into airport(city, airport_name) values(2, "Warsaw Chopin Airport");
insert into airport(city, airport_name) values(4, "London Heathrow Airport");
insert into airport(city, airport_name) values(5, "Charles de Gaulle Airport");

insert into airRoute(aircompany_id, plane_id, departures_airport, arrivals_airport, airline_name) values(1, 1, 1, 2, "Ryanair");
insert into airRoute(aircompany_id, plane_id, departures_airport, arrivals_airport, airline_name) values(2, 4, 3, 5, "Flydubai");
insert into airRoute(aircompany_id, plane_id, departures_airport, arrivals_airport, airline_name) values(1, 2, 4, 2, "Wizzair");
insert into airRoute(aircompany_id, plane_id, departures_airport, arrivals_airport, airline_name) values(4, 5, 1, 5, "Vueling");
insert into airRoute(aircompany_id, plane_id, departures_airport, arrivals_airport, airline_name) values(5, 1, 2, 4, "Ryanair");

insert into flight(flight_date, route_id, board) values('2021-01-23',1, 1);
insert into flight(flight_date, route_id, board) values('2021-04-27',2, 2);
insert into flight(flight_date, route_id, board) values('2021-07-13',3, 4);
insert into flight(flight_date, route_id, board) values('2021-03-03',4, 5);
insert into flight(flight_date, route_id, board) values('2021-06-21',5, 2);

insert into passenger(passenger_name,passenger_surname) values('Lewie','Hearnes');
insert into passenger(passenger_name,passenger_surname) values('Wadsworth','Conring');
insert into passenger(passenger_name,passenger_surname) values('Lanae','Mousdall');
insert into passenger(passenger_name,passenger_surname) values('Willamina','Noods');
insert into passenger(passenger_name,passenger_surname) values('Miles','Grafhom');
insert into passenger(passenger_name,passenger_surname) values('Gussie','Napleton');

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
insert into ticket(passenger, tariff, flight_date) values(2,2,'2021-04-27');
insert into ticket(passenger, tariff, flight_date) values(3,3,'2021-07-13');
insert into ticket(passenger, tariff, flight_date) values(4,4,'2021-03-03');
insert into ticket(passenger, tariff, flight_date) values(5,5,'2021-06-21');
