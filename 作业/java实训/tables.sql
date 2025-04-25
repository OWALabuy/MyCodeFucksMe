create table Book (
    isbn varchar(17) primary key not null,
    title varchar(255) not null,
    author varchar(255) not null,
    price decimal(10,2) not null,
    total_stock int not null,
    available_stock int not null,
    borrow_count int not null
);

create table Reader(
    email varchar(255) primary key not null,
    name varchar(255) not null,
    max_borrow_days int not null,
    lost_flag boolean not null
);

create table Borrow(
    id int primary key auto_increment,
    email varchar(255) not null,
    isbn varchar(17) not null,
    borrow_date date not null,
    return_date date,
    --primary key (email, isbn),
    foreign key (email) references Reader(email) on delete cascade,
    foreign key (isbn) references Book(isbn) on delete cascade
);

create table Staff(
    staff_id varchar(10) not null,
    name varchar(255) not null,
    role varchar(50) not null
);
