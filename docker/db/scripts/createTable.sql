create database `airlines` character set 'utf8';

use airlines;

create table aircompany(
    aircompany_id int not null auto_increment,
    nip int not null,
    aircompany_name varchar(30) not null,
    primary key (aircompany_id)
);

create table plane(
    plane_id int not null auto_increment,
    aircompany int not null,
    model varchar(30) not null,
    number_of_seats int not null,
    engine varchar(15) not null,
    -- plane_usage varchar(15),
    board_number varchar(15) not null, 
    primary key (plane_id),
    foreign key (aircompany) references aircompany (aircompany_id)
);    

create table airport(
    airport_id int not null auto_increment,
    city varchar(15),
    airport_name varchar(50) not null,
    primary key (airport_id)
);

create table airRoute (
    airRoute_id int not null auto_increment,
    plane_id int,
    departures_airport int,
    arrivals_airport int,
    aircompany int,
    primary key (airRoute_id),
    foreign key (departures_airport) references airport (airport_id),
    foreign key (arrivals_airport) references airport (airport_id),
    foreign key (aircompany) references aircompany(aircompany_id)
);

create table pilot(
    pilot_id int not null auto_increment,
    name varchar(15),
    surname varchar(15),
    primary key (pilot_id)  
);

create table flight (
    flight_id int not null auto_increment,
    -- flight_date date not null,
    route_id int not null,
    plane int,
    pilot int,
    departure datetime,
    arrival datetime,
    flight_number varchar(15),
    primary key (flight_id),
    foreign key (pilot) references pilot (pilot_id),
    foreign key (route_id) references airRoute (airRoute_id),
    foreign key (plane) references plane (plane_id)
);

create table passenger (
    passenger_id int not null auto_increment,
    name varchar(15),
    surname varchar(15),
    passport varchar(15) not null unique,
    primary key (passenger_id)  
);

create table tariff(
    tariff_id int auto_increment,
    airRoute_id int,
    cost int not null,
    primary key (tariff_id),
    foreign key (airRoute_id) references airRoute (airRoute_id)
);

create table ticket(
    ticket_id int auto_increment,
    passenger int not null, 
    tariff int not null,
    flight int not null,
    primary key (ticket_id),
    foreign key (passenger) references passenger (passenger_id),
    foreign key (tariff) references tariff (tariff_id),
    foreign key (flight) references flight (flight_id)
);