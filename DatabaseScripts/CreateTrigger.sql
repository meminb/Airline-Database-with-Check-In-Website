
use dbDemo1;
/* Increase FFC's millage info after checked in  */
#drop trigger increase_millage_info;
DELIMITER $$
create  trigger increase_millage_info
after insert on ticket_info
for each row
begin
update ffc set millage_info =millage_info+( select distance from leg_instance
									where new.flight_number= leg_instance.flight_number and 
									new.leg_no = leg_instance.leg_no and
                                    new.instance_date = leg_instance.instance_date)
                                    
				where new.passport_number= ffc.passport_number and
								ffc.airline_code = ( select airline_code from airline  
													where airline.Company_name = (select airline_name from flight
																						where flight_number = new.flight_number));
end
;$$


/* Creates FFC for customer who checked-in if not exist  */
#drop trigger insert_ffc;
delimiter $$
create  trigger insert_ffc
before insert on ticket_info
for each row
begin
if (not exists ( select * from ffc where new.passport_number=ffc.passport_number and ffc.airline_code =( select airline_code from airline  
													where airline.company_name = (select airline_name from flight
																						where flight_number = new.flight_number))))
then
insert into ffc values ( new.passport_number, 0 ,"Bronze", ( select airline_code from airline  
													where airline.company_name = (select airline_name from flight
																						where flight_number = new.flight_number)));
end if;
end;$$



/* increases available seats of leg instance before canceling seat reservation**/
#drop trigger increase_number_available_seats;
create trigger increase_number_available_seats
before delete on seats 
for each row
update  leg_instance
set leg_instance.number_of_available_seats=number_of_available_seats+1
where old.flight_number=leg_instance.flight_number and
		old.leg_no=leg_instance.leg_no and 
		old.instance_date=leg_instance.instance_date  ;
        


        
/* decreases available number of seats of leg instance before buying seat ***/
#drop trigger decrease_number_available_seats;
delimiter $$
create trigger decrease_number_available_seats
before insert on seats 
for each row
update  leg_instance
set leg_instance.number_of_available_seats=leg_instance.number_of_available_seats-1
where new.flight_number=leg_instance.flight_number and
		new.leg_no=leg_instance.leg_no and 
		new.instance_date=leg_instance.instance_date  ;
        
        $$


#drop trigger number_of_seats_validation;
 /*Ensures that the newly added aircraft does not have more
 seats than the airplane type  it belongs to**/
delimiter $$         
create trigger number_of_seats_validation
before insert on airplane
for each row
begin
if (new.total_number_of_seats>(select max_seats 
								from airplane_type
                                where new.airplane_type = airplane_type.airplane_type_name))
then
signal sqlstate'45000';
end if;
end;$$



/* Ensures that  newly created leg instance does not have
more available seats than the airplane it assigned to* */
delimiter $$  	
create trigger number_of_seats_validation_for_leg_instance
before insert on leg_instance
for each row
begin
if (new.number_of_available_seats>(select total_number_of_seats 
								from airplane
                                where new.airplane_id = airplane.airplane_id))
then
signal sqlstate'45000';
end if;
end;$$


/*ensures that the aircraft assigned to leg_instance 
can be put into airports assigned to leg instance* */
delimiter $$		
create trigger leg_instance_can_land_problem
before insert on leg_instance
for each row
begin
if ( not EXISTS  (select * from can_land 
					where can_land.airplane_type_name = (select airplane_type from airplane 
													  where airplane.airplane_id=new.airplane_id and airport_code=new.departure_Airport
												) 
                  ) 
                  or 
     not EXISTS  (select * from can_land 
					where can_land.airplane_type_name = (select airplane_type from airplane 
													  where airplane.airplane_id=new.airplane_id and airport_code=new.arrival_Airport
												) 
                  )             
    )                   
then
signal sqlstate'45000';
end if;
end;$$

SELECT * FROM dbdemo1.ticket_info;
#select * from ticket_info;
#drop trigger adding_ticket_info;
SHOW TRIGGERS;


