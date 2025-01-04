create table barber_stores (
    barber_store_id int primary key auto_increment,
    name text not null,
    address text
);
insert into barber_stores set name = 'I Barbieri Lissone', address = 'Via Giosuè Carducci, 35, 20851 Lissone MB';

create table barbers (
    barber_id int primary key auto_increment,
    name text not null,
    img_url text null
);
insert into barbers set name = 'Gianny', img_url = 'https://images.unsplash.com/photo-1543965170-4c01a586684e?q=80&w=2349&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
insert into barbers set name = 'Arianna', img_url = 'https://plus.unsplash.com/premium_photo-1705018501151-4045c97658a3?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

create table barber_store_services (
    barber_service_id int primary key auto_increment,
    service_name text not null,
    service_price int default 0,
    duration int default 0
);
insert into barber_store_services set service_name = 'Taglio capelli', service_price = 2000, duration = 30;
insert into barber_store_services set service_name = 'Barba disegnata', service_price = 1500, duration = 30;
insert into barber_store_services set service_name = 'Taglio under 10', service_price = 1800, duration = 30;
insert into barber_store_services set service_name = 'Taglio + Barba disegnata', service_price = 1000, duration = 30;

create table barber_store_schedules (
    barber_store_schedule_id int primary key auto_increment,
    barber_store_id int not null,
    day date null,
    weekday enum('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') null,
    opening time not null,
    closing time not null
);
insert into barber_store_schedules set barber_store_id = 1, weekday = 'monday', opening = '9:00', closing = '20:00';
insert into barber_store_schedules set barber_store_id = 1, weekday = 'tuesday', opening = '9:00', closing = '20:00';
insert into barber_store_schedules set barber_store_id = 1, weekday = 'wednesday', opening = '9:00', closing = '20:00';
insert into barber_store_schedules set barber_store_id = 1, weekday = 'thursday', opening = '9:00', closing = '20:00';
insert into barber_store_schedules set barber_store_id = 1, weekday = 'friday', opening = '9:00', closing = '20:00';
insert into barber_store_schedules set barber_store_id = 1, weekday = 'saturday', opening = '9:00', closing = '20:00';
insert into barber_store_schedules set barber_store_id = 1, weekday = 'sunday', opening = '9:00', closing = '20:00';

create table barber_store_reservations (
    barber_store_reservation_id int primary key auto_increment,
    barber_store_id int null,
    barber_id int,
    barber_store_service_id int,
    day date not null,
    start_time time not null,
    end_time time not null
);