use airlines;

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

-- SELECT * FROM allFlightsWithTime;

CREATE VIEW passengersWithDestinations AS
select passenger.name, passenger.surname, passenger.passport, depart.city as depart, arrival.city as arrivals from passenger
join ticket on ticket.passenger = passenger_id
join tariff on tariff.tariff_id = ticket.tariff
join airRoute on airRoute.airRoute_id = tariff.airRoute_id
join airport as arrival on airRoute.arrivals_airport = arrival.airport_id
join airport as depart on  airRoute.departures_airport = depart.airport_id
order by passenger.surname;

-- select * from passengersWithDestinations;