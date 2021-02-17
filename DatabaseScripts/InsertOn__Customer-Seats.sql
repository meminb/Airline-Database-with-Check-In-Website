SELECT * FROM dbdemo1.flight;

insert into flight values (" TK100",2,"Turkish Airlines");
insert into flight values (" TK101",3,"Turkish Airlines");
insert into flight values (" TK102",4,"Turkish Airlines");

insert into flight values ("QTR100",1,"Qatar Airways");
insert into flight values ("QTR101",4,"Qatar Airways");
insert into flight values ("QTR102",6,"Qatar Airways");

insert into flight values(' XQ100',2,'Sun Express');
insert into flight values(' XQ101',5,'Sun Express');
insert into flight values(' XQ102',3,'Sun Express');

insert into flight values(' AA100',2,'American Airlines');
insert into flight values(' AA101',4,'American Airlines');
insert into flight values(' AA102',5,'American Airlines');


SELECT * FROM dbdemo1.flight_leg;

insert into flight_leg values(' AA100',1,'11:00','13:00','JFK','SAW');

insert into flight_leg values(' AA101',1,'11:00','13:00','JFK','SAW');
insert into flight_leg values(' AA101',2,'13:00','17:45','SAW','LAX');

insert into flight_leg values(' AA102',1,'11:00','13:00','LAX','ISL');
insert into flight_leg values(' AA102',2,'13:00','17:45','ISL','JFK');







insert into flight_leg values(' XQ100',1,'05:30','10:45','SAW','JFK');

insert into flight_leg values(' XQ101',1,'11:00','13:00','ISL','LAX');
insert into flight_leg values(' XQ101',2,'13:00','17:45','LAX','JFK');

insert into flight_leg values(' XQ102',1,'11:00','13:00','FCO','LHR');
insert into flight_leg values(' XQ102',2,'13:00','17:45','LHR','JFK');
insert into flight_leg values(' XQ102',3,'11:00','13:00','JFK','ISL');
insert into flight_leg values(' XQ102',4,'13:00','17:45','ISL','YVR');

insert into flight_leg values (" TK100",1,"08:00","10:00","SAW","ISL");
insert into flight_leg values (" TK100",2,"10:00","12:00","ISL","SAW");

insert into flight_leg values (" TK101",1,"10:00","12:00","ISL","SAW");

insert into flight_leg values ("QTR101",1,"18:00","20:00","LAX","JFK");
insert into flight_leg values ("QTR101",2,"20:00","22:00","JFK","LHR");

insert into flight_leg values ("QTR102",1,"18:00","20:00","SAW","ISL");
insert into flight_leg values ("QTR102",2,"20:00","22:00","ISL","SAW");

/**rt values("SAW","Sabiha Gökçen Havaalanı","İstanbul","" );
insert into airport values("ISL","Atatürk Havaalanı","İstanbul","" );
insert into airport values('LAX','Los Angeles Airport','California',"");
insert into airport values('JFK','John F Kennedy Airport','New York',"");
insert into airport values('LHR','Heathrow Airport','London',"");
insert into airport values('FCO','Fiumicino Airport','Rome',"");
insert into airport values('YVR',**/
alter table leg_instance drop distance;
alter table leg_instance add distance int;



SELECT * FROM dbdemo1.leg_instance;
insert into leg_instance values (" TK100",1,"2020-02-10","N1000",100,"08:10","10:10","SAW","FCO",100);
insert into leg_instance values (" TK100",2,"2020-02-10","N1002",100,"10:20","12:30","FCO","LAX",140);

insert into leg_instance values (" TK100",1,"2020-05-10","N1000",100,"08:10","10:10","SAW","FCO",100);
insert into leg_instance values (" TK100",2,"2020-05-10","N1002",100,"10:20","12:30","FCO","LAX",140);

insert into leg_instance values (" TK101",1,"2021-03-22","N1002",100,"10:20","12:30","SAW","JFK",100);

insert into leg_instance values ("QTR102",1,"2020-02-11","N1001",10,"10:20","12:30","SAW","LAX",200);
insert into leg_instance values ("QTR102",2,"2020-02-11","N1001",10,"10:20","12:30","LAX","FCO",120);

insert into leg_instance values ("QTR101",1,"2020-02-11","N1001",10,"10:20","12:30","LAX","JFK",100);
insert into leg_instance values ("QTR101",2,"2020-02-11","N1001",10,"13:20","17:30","JFK","LHR",320);

insert into leg_instance values ("QTR101",1,"2021-03-11","N1001",10,"10:20","12:30","LAX","JFK",100);
insert into leg_instance values ("QTR101",2,"2021-03-11","N1001",10,"13:20","17:30","JFK","LHR",100);


insert into leg_instance values (' XQ100',1,"2021-02-11","N1001",10,"10:20","12:30","SAW","FCO",870);
                                 
insert into leg_instance values (' XQ101',1,"2021-02-12","N1002",100,"10:20","12:30","SAW","LHR",400);
insert into leg_instance values (' XQ101',2,"2021-02-12","N1002",100,"10:20","12:30","LHR","JFK",400);
                                 
insert into leg_instance values (' XQ102',1,"2021-02-21","N1005",160,"10:20","12:30","LAX","JFK",120);
insert into leg_instance values (' XQ102',2,"2021-02-21","N1002",120,"13:20","17:30","JFK","LHR",220);
insert into leg_instance values (' XQ102',3,"2021-03-21","N1002",120,"18:20","19:30","LAX","JFK",400);
insert into leg_instance values (' XQ102',4,"2021-03-21","N1002",100,"20:20","22:30","JFK","LHR",70);




insert into leg_instance values (' AA100',1,"2021-03-21","N1001",10,"10:20","12:30",'JFK','SAW',870);
                                                                                    
insert into leg_instance values (' AA101',1,"2020-03-11","N1001",10,"10:20","12:30",'JFK','SAW',100);
insert into leg_instance values (' AA101',2,"2020-03-11","N1002",200,"13:20","17:30",'SAW','LAX',320);
                                                                                    
insert into leg_instance values (' AA102',1,"2021-03-12","N1005",310,"10:20","12:30",'LAX','ISL',160);
insert into leg_instance values (' AA102',2,"2021-03-12","N1003",100,"13:20","17:30",'ISL','JFK',150);


select * from leg_instance
;
#insert into leg_instance values (" TK100",1,"2020-02-11","N1008",80,"10:20","12:30","SAW","ISL",100);

/**
insert into leg_instance values (' AA102',1,"2021-03-25","N1005",310,"10:20","12:30",'SAW','JFK',160);

insert into flight_leg values(' XQ100',1,'05:30','10:45','SAW','JFK');

insert into flight_leg values(' XQ101',1,'11:00','13:00','ISL','LAX');
insert into flight_leg values(' XQ101',2,'13:00','17:45','LAX','JFK');

insert into flight_leg values(' XQ102',1,'11:00','13:00','FCO','LHR');
insert into flight_leg values(' XQ102',2,'13:00','17:45','LHR','JFK');
insert into flight_leg values(' XQ102',3,'11:00','13:00','JFK','ISL');
insert into flight_leg values(' XQ102',4,'13:00','17:45','ISL','YVR');




drop table ticket_info;
drop table ffc;**/


/**insert into ticket_info values ("000000033","QTR102",1,"2020-02-11");
insert into ticket_info values ("000000033","QTR102",2,"2020-02-11");
**/
SELECT * FROM dbdemo1.ffc;
 # atanmış uçak planlanan havaalanlarından birine konamıyorsa
 /*
insert into leg_instance values (" TK101",1,"2020-02-12","N1004",150,"10:20","12:30","ISL","SAW");*/



SELECT * FROM dbdemo1.fare;

insert into fare values ("QTR102","F1",250,"Capacity controlled");
insert into fare values ("QTR102","F2",250,"Capacity controlled");
insert into fare values ("QTR102","F3",250,"Capacity controlled");
insert into fare values ("QTR102","J1",700,"Internet only");
insert into fare values ("QTR102","W1",800,"Unrestricted");
insert into fare values ("QTR102","Y1",400,"Unrestricted");

insert into fare values (" AA100","F1",1250,"Capacity controlled");
insert into fare values (" AA100","J1",700,"Internet only");
insert into fare values (" AA100","W1",300,"restricted");
insert into fare values (" AA100","Y1",400,"Unrestricted");


insert into fare values (" AA101","F1",250,"Capacity controlled");
insert into fare values (" AA101","J1",700,"Internet only");

insert into fare values (" AA102","W1",800,"restricted");
insert into fare values (" AA102","Y1",400,"Unrestricted");

insert into fare values (" TK100","F1",250,"Capacity controlled");
insert into fare values (" TK100","J1",700,"Internet only");

insert into fare values (" TK101","W1",800,"restricted");
insert into fare values (" TK102","Y1",400,"Unrestricted");


insert into fare values ("QTR101","W1",800,"restricted");
insert into fare values ("QTR100","Y1",400,"Unrestricted");

insert into fare values (" XQ102","F1",250,"Capacity controlled");
insert into fare values (" XQ102","J1",700,"Internet only");

insert into fare values (" XQ101","W1",800,"restricted");
insert into fare values (" XQ100","Y1",400,"Unrestricted");



