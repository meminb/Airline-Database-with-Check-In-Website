

create database dbDemo1;
use  dbDemo1;
Create table Companies(
Company_Name varchar(127) not null primary key,
#Company_type varchar(55),
#number_of_airplanes int,
Contact varchar(255),
CONSTRAINT lenghtConstraints2 CHECK(char_length(Company_Name)>2)
);

Create table Airline (
	Company_Name varchar(127) not null primary key references Companies(Company_Name),
	airline_code varchar(3) not null unique key,
    
    check (regexp_like(airline_code,'[A-Z][A-Z][A-Z]'))
    
);

Create table Air_Comp (
    Company_Name varchar(127) not null primary key references Companies(Company_Name)
    #number_of_airplanetype int
);


Create table Flight(
Flight_Number varchar(6) not null primary key,
weekdays int not null,
airline_Name varchar(127)  references Airline(Company_Name),

/*flightnumber için regex constraints yazılacak örnek aq2131       [a-z][a-z][0-9][0-9][0-9][0-9]
airline_id için kısıt yazılmalı mı ?
*/
check (regexp_like(flight_number,'[A-Z|| ][A-Z|| ][A-Z][0-9][0-9][0-9]')),
constraint check (weekdays<8)

);

create table Fare(
Flight_Number varchar(6)  not null,
fare_Code varchar(2) not null,
amount int,
restriction varchar(55),

/* farecode için regex onstraint  örnek: f1 */
foreign key (Flight_Number) references Flight(Flight_Number),
check (regexp_like(fare_code,'^(F|J|W|Y)')),
check (regexp_like(restriction,'^(Unrestricted|Restricted|Capacity controlled|Internet only)$')),
primary key(Flight_number,fare_code)
);

create table airport(
airport_code varchar(3) not null primary key,
AirportName varchar(127),
city varchar(127) NOT NULL,
state varchar(127) ,

check (regexp_like(airport_code,'[A-Z][A-Z][A-Z]'))
);

create table Flight_Leg(
flight_Number varchar(6) not null references flight(flight_Number),
leg_no int not null,
scheduled_Departure_Time Time,
scheduled_Arrival_Time Time,
departure_Airport varchar(3) references airport(airport_code),
arrival_Airport varchar(3) references airport(airport_code),

/*  departuretime > arrivaltime
departure time formatı  %H %i  şeklinde yani  21 45 gibi

*/
foreign key (Flight_Number) references Flight(Flight_Number),
#foreign key (departure_Airport) references airport(airport_code),
#foreign key (arrival_Airport) references airport(airport_code),
check (regexp_like(leg_no,'[1-9]')),
check (scheduled_Departure_Time<scheduled_Arrival_Time),
primary key (flight_Number,leg_no)
);



create table customer(
customer_name varchar(127) NOT NULL,
phone varchar(11),
passport_number varchar(9) primary key,
adress varchar(255),
country varchar(127),
email varchar(155),


/* phone un digit olmasını sağla*/
/*primary key (customer_name,phone),*/

CONSTRAINT CT_PHONE CHECK(char_length(phone)=10),
CONSTRAINT CT_PASSPORTLENGTH CHECK(char_length(passport_number)>5)
);

#drop table ffc;
create table ffc(
passport_number varchar(9) not null ,
millage_info int not null,
segmentation varchar(55),
airline_code varchar(3) references airline(airline_code),



/*millaee inf 0 dan başlayacak*/#
check (regexp_like(segmentation,'^(Bronze|Silver|Gold|Platin|)$')),
#check (regexp_like(segmentation,'^(Loyal|Urgent|Business|Budget|)$')),
foreign key (passport_number) references customer(passport_number),
primary key( passport_number,airline_code )
);



create table airplane_type(
airplane_type_name varchar(127) not null primary key,
max_seats int not null,
Company_Name varchar(255) not null   ,

foreign key (Company_Name ) references Air_Comp(Company_Name),
constraint check (max_seats<1000 AND max_seats>2)

);

create table airplane(
	airplane_id   varchar(55) primary key,
	company_name varchar(127)  ,
    total_number_of_seats int ,
    airplane_type varchar(127) not null ,
	foreign key (airplane_type) references airplane_type(airplane_type_name),
	foreign key (company_name) references Companies(Company_Name)
    
    
	/*total_number_of_seat'daki max_number_of_seats'den küçük olmalı 
    airplane id için constraint ekle*/
);

create table can_land(
airplane_type_name varchar(127) not null ,
airport_code varchar(3) not null ,

foreign key (airplane_type_name) references airplane_type(airplane_type_name),
foreign key (airport_code) references airport(airport_code),
primary key (airplane_type_name ,airport_code)
);




create table leg_instance(
flight_Number varchar(6) not null ,
leg_no int not null ,
instance_date date not null,
airplane_id   varchar(55) not null ,
number_of_available_seats int,
distance  int ,

departure_time time,
arrival_time time ,
departure_Airport varchar(3)  references airport(Airport_Code),
arrival_Airport varchar(3) references airport(Airport_Code),

foreign key (flight_Number,leg_no) references flight_leg(flight_Number,leg_no),
foreign key (airplane_id) references airplane(airplane_id),


primary key (flight_number,leg_no,instance_date),
constraint check (arrival_time>departure_time),
constraint check (number_of_available_seats>-1),
constraint check (distance>40)
);


create table seats(
flight_Number varchar(6) ,
leg_no int,
instance_date date ,
seat_number int not null ,
/**custumer_name varchar(127) references costumer(costumer_name),
custumer_phone varchar(11) not null references customer(phone),**/
customer_passport varchar(9) not null,
fare_code varchar(2) references Fare(fare_code),

foreign key (flight_Number,leg_no,instance_date) references leg_instance(flight_Number,leg_no,instance_date),
foreign key (customer_passport) references customer(passport_number),

primary key(flight_Number,leg_no,instance_date,seat_number)
);


create table ticket_info(
passport_number varchar(9) not null ,
flight_Number varchar(6) not null,
leg_no int not null ,
instance_date date not null,
seat_no int,


foreign key (flight_Number,leg_no,instance_date,seat_no) references seats(flight_Number,leg_no,instance_date,seat_number),
foreign key (passport_number) references customer(passport_number),
primary key(flight_number,leg_no,passport_number,instance_date,seat_no)
);


