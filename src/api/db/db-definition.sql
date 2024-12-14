create table barber_stores (
    barber_store_id int primary key auto_increment,
    name text not null,
    address text
);
insert into barber_stores set name = 'I Barbieri Lissone', address = 'Via Giosuè Carducci, 35, 20851 Lissone MB';

create table barber_service (
    barber_service_id int primary key auto_increment,
    barber_id int,
    service_name text not null,
    service_price int default 0,
    duration int default 0,
    foreign key (barber_id) references barbers(barber_id)
);