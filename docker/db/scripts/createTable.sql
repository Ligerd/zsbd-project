create database `airlines` character set 'utf8';

use airlines;

create table aircompany(
    aircompany_id int not null auto_increment,
    aircompany_name varchar(30) not null,
    primary key (aircompany_id)
);

create table plane(
    plane_id int not null auto_increment,
    plane_type varchar(30) not null,
    number_of_seats int not null,
    engine_type varchar(15) not null,
    plane_usage varchar(15), 
    primary key (plane_id)
);    

create table board (
    board_id int not null auto_increment,
    plane_id int not null,
    aircompany_id int not null,
    board_number varchar(15) not null,   
    primary key (board_id),
    foreign key (plane_id) references plane (plane_id),
    foreign key (aircompany_id) references aircompany (aircompany_id)
);

create table city (
    city_id int not null auto_increment,
    city_name varchar(15),
    primary key (city_id)
);

create table airport(
    airport_id int not null auto_increment,
    city int,
    airport_name varchar(15) not null,
    primary key (airport_id),
    foreign key (city) references city(city_id)
);

create table airRoute (
    airRoute_id int not null auto_increment,
    aircompany_id int,
    plane_id int,
    departures_airport int,
    arrivals_airport int,
    airline_name varchar(15),
    primary key (airRoute_id),
    foreign key (departures_airport) references airport (airport_id),
    foreign key (arrivals_airport) references airport (airport_id)
);

create table flight (
    flight_date datetime not null,
    route_number int,
    board_number int,
    primary key (flight_date),
    foreign key (route_number) references airRoute (airRoute_id),
    foreign key (board_number) references board (board_id)
);


create table passenger (
    passenger_id int not null auto_increment,
    passenger_name varchar(15),
    passenger_surname varchar(15),
    primary key (passenger_id)  
);

create table timesheet(
    airport_id int,
    airRoute_id int,
    departure_time datetime,
    arrival_time datetime,
    foreign key (airport_id) references airport (airport_id),
    foreign key (airRoute_id) references airRoute (airRoute_id)
);

create table tariff(
    tariff_id int auto_increment,
    airRoute_id int,
    deparutures_airport int,
    arrivals_airport int,
    cost int not null,
    primary key (tariff_id),
    foreign key (deparutures_airport) references airport (airport_id),
    foreign key (arrivals_airport) references airport (airport_id)
);

create table ticket(
    ticket_id int auto_increment,
    passenger int not null, 
    tariff int not null,
    flight_date datetime not null,
    airRoute int not null,
    primary key (ticket_id),
    foreign key (passenger) references passenger (passenger_id),
    foreign key (tariff) references tariff (tariff_id),
    foreign key (flight_date) references flight (flight_date),
    foreign key (airRoute) references airRoute (airRoute_id)
);