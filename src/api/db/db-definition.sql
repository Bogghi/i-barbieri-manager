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

create table barber_service (
    barber_service_id int primary key auto_increment,
    barber_id int,
    service_name text not null,
    service_price int default 0,
    duration int default 0,
    foreign key (barber_id) references barbers(barber_id)
);