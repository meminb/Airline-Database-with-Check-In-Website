/* All Customers which are FFC or not.
*/
create  or replace view all_customers as
select c.*,f.millage_info,f.segmentation,f.airline_code from customer c
left join ffc f on
c.passport_number=f.passport_number; 

select * from all_customers;


/*All reservations that have not been checked in */
create or replace view notCheckIn as
select s.* ,ai.airline_code from seats s
inner join airline ai on  company_name=( select airline_name from flight   f
													where f.flight_number =s.flight_number) and
 not exists (select * from ticket_info ti
					where ti.flight_Number =s.flight_number and
							ti.leg_no =s.leg_no and
                            ti.instance_date =s.instance_date and
                            ti.seat_no =s.seat_number );
 
select * from notCheckIn;

/* Leg Instances with fare infos*/
create  or replace view instances_with_prices as
select lf.*,f.fare_code,f.amount from leg_instance lf
left join fare f on f.flight_number=lf.flight_number
;
select * from instances_with_prices;