use  dbDemo1;
SELECT * FROM dbdemo1.airplane_type;

insert into airplane_type values (	"Airbus A220",	100,"Airbus");
insert into airplane_type values (	"Airbus A330",	200,"Airbus");
insert into airplane_type values (	"Airbus A380",	300,"Airbus");
insert into airplane_type values (	"Boeing 737",	300,"Boeing");
insert into airplane_type values (	"Boeing 737-8",	400,"Boeing");
insert into airplane_type values (	"Boeing 787",	300,"Boeing");


SELECT * FROM dbdemo1.airplane;
/**
DELETE FROM airplane WHERE airplane_id='N1000';
DELETE FROM airplane WHERE airplane_id='N1001';
DELETE FROM airplane WHERE airplane_id='N1002';
DELETE FROM airplane WHERE airplane_id='N1003';
DELETE FROM airplane WHERE airplane_id='N1004';
DELETE FROM airplane WHERE airplane_id='N1005';**/


insert into airplane values ("N1000","Boeing",100,"Airbus A220");
insert into airplane values ("N1001","Airbus",20,"Airbus A330");
insert into airplane values ("N1002","Boeing",200,"Airbus A380");
insert into airplane values ("N1003","Airbus",220,"Boeing 787");
insert into airplane values ("N1004","Boeing",200,"Boeing 737");
insert into airplane values ("N1005","Airbus",320,"Boeing 737-8");
insert into airplane values ("N1006","Turkish Airlines",200,"Boeing 737");
insert into airplane values ("N1007","Qatar Airways",320,"Boeing 737-8");
insert into airplane values ("N1008","Qatar Airways",100,"Boeing 737-8");

SELECT * FROM dbdemo1.airport;
#DELETE FROM airport WHERE airport_code='SAW';

insert into airport values("SAW","Sabiha Gökçen Havaalanı","İstanbul","" );
insert into airport values("ISL","Atatürk Havaalanı","İstanbul","" );
insert into airport values('LAX','Los Angeles Airport','California',"");
insert into airport values('JFK','John F Kennedy Airport','New York',"");
insert into airport values('LHR','Heathrow Airport','London',"");
insert into airport values('FCO','Fiumicino Airport','Rome',"");
insert into airport values('YVR','Pearson Airport','Toronto',"");
SELECT * FROM dbdemo1.can_land;

/*boeing tipli uçaklar sabiha gökçene konamaz*/

insert into can_land values("Boeing 737",  "LAX" );
insert into can_land values("Boeing 737",  "JFK" );

insert into can_land values("Boeing 787",  "LAX" );
insert into can_land values("Boeing 787",  "JFK" );

insert into can_land values("Boeing 737-8","LAX" );
insert into can_land values("Boeing 737-8","JFK" );

insert into can_land values("Boeing 737",  "LHR" );
insert into can_land values("Boeing 737",  "FCO" );
                            
insert into can_land values("Boeing 787",  "LHR" );
insert into can_land values("Boeing 787",  "FCO" );
                            
insert into can_land values("Boeing 737-8","LHR" );
insert into can_land values("Boeing 737-8","FCO" );


insert into can_land values("Airbus A220","SAW" );
insert into can_land values("Airbus A220","ISL" );

insert into can_land values("Airbus A330","SAW" );
insert into can_land values("Airbus A330","ISL" );

insert into can_land values("Airbus A380","SAW" );
insert into can_land values("Airbus A380","ISL" );

insert into can_land values("Airbus A220","LAX" );
insert into can_land values("Airbus A220","JFK" );

insert into can_land values("Airbus A330","LAX" );
insert into can_land values("Airbus A330","JFK" );

insert into can_land values("Airbus A380","LAX" );
insert into can_land values("Airbus A380","JFK" );

insert into can_land values("Airbus A220","LHR" );
insert into can_land values("Airbus A220","FCO" );

insert into can_land values("Airbus A330","LHR" );
insert into can_land values("Airbus A330","FCO" );

insert into can_land values("Airbus A380","LHR" );
insert into can_land values("Airbus A380","FCO" );

insert into can_land values("Airbus A220","YVR" );
insert into can_land values("Airbus A330","YVR" );
insert into can_land values("Airbus A380","YVR" );

insert into can_land values("Boeing 737","YVR" );
insert into can_land values("Boeing 737-8","YVR" );
insert into can_land values("Boeing 787","YVR" );

insert into can_land values("Boeing 737","ISL" );
insert into can_land values("Boeing 737-8","ISL" );
insert into can_land values("Boeing 787","ISL" );

select * from can_land;