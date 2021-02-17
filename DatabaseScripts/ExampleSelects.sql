

/* aktarmasız uçuşlar 
select flight_number ,leg_no
from flight_leg
group by flight_number
having count(*)=1;*/

/* İstanbul şehrinden uçağa binmiş ve herhangi bir yere gitmiş 
yolcuların bilgilerini ve kullandıkları uçuşları  döndürür ,count(*)
 4 tablo  - nested 
*/
select customer.*,se.flight_number, se.leg_no, se.instance_date 
from customer
right join seats se on 
se.customer_passport=customer.passport_number
inner join airport airp on
airp.airport_code=( select departure_Airport from leg_instance li
						where se.flight_number=li.flight_number and
								se.leg_no=li.leg_no and
                                se.instance_date=li.instance_date and
                                airp.city="İstanbul")
group by flight_number, leg_no, instance_date
;



select* from seats;



/* İstanbul şehrinde herhangi bir havaalanına konabilecek
uçakları ve bunların sahiplarini döndürür
 3 tablo nest*/
select * from airplane ap
where "İstanbul" in(Select ai.city
					from airport ai
					right join can_land cl on
                    ai.airport_code=cl.airport_code and
                    ap.airplane_type=cl.airplane_type_name);
select * from airplane;


/*  İstanbula en çok sefer düzenleyen havayolu şirketlerini ve
kaçar tane uçuş düzenlediklerini döndürür ve bunları çoktan aza sıralar
*/
select airl.*,count(*)
from airline airl
right join leg_instance li on 
li.flight_Number in (select flight_number 	
						from flight f where
                        f.airline_name=airl.company_name)
                      and
(li.arrival_Airport in (select airport_code from airport where city="İstanbul") or
li.departure_Airport in (select airport_code from airport where city="İstanbul"))
 group by airl.Company_Name
 order by count(*) desc
;

 select * from leg_instance;
 
 
 
 /* 400 milden daha uzun ve hiçbir ayağında istanbula uğramayan
 uçuşları  ve bunların kaçar mil olduklarını sıralar
 
 2 tablo sum-having
 */
 select Flight_Number,sum(distance) sm
 from leg_instance li
 where
 (li.arrival_Airport not in (select airport_code from airport where city="İstanbul") and
li.departure_Airport  not in (select airport_code from airport where city="İstanbul"))
 group by flight_number
having sum(distance)>400
 ;

/* istanbuldan kalkmış uçakların en çok gittikleri şehirleri ve
bu şehirlere kaçar uçağın gittiğini sıralar

2 tablo inner nested count
*/
select (select city from airport where airport_code=li.arrival_Airport) as varis,count(*) from leg_instance li
inner join airport ai on
li.departure_Airport=ai.airport_code and
ai.city="İstanbul" group by varis;


/*hangi uçuşların kaç gün uçtuğu bilgisini ve airline code'unu döndüren,
 restriction çıktısını veren ve sonuçların da fare_code'a göre sıralandığı sorgu
 3 tablo inner */
select a.Airline_code, f.Flight_number, far.Fare_code, far.Restriction, f.Weekdays 
from airline as a 
inner join flight as f on a.Company_Name=f.Airline_name 
inner join fare as far on far.Flight_number=f.Flight_number 
order by far.Fare_code, f.Weekdays;


/* Kendi ürettiğirettiği uçak tipinden farklı uçağa
 sahip air_company firmaları ve uçaklarını 
sıralar.  

3 tablo  exsists*/
select ai.company_name,ai.airplane_id
from airplane ai 
where ai.company_name not in ( select at.company_name from airplane_type at
								where ai.airplane_type=at.airplane_type_name
                               ) and exists (select * from air_comp where ai.company_name =company_name);


/* Ücreti 200 ve 300 arasındaki uçuşların aktarma yapıp yapmadığını, 
hangi airline'a ait olduğunu uçuş numaralarıyla gösteren sorgu
3 tabloright join inner join*/
select f.Airline_name, f.Flight_number, far.Amount,far.fare_Code,  fl.Leg_no
from flight as f 
right join fare as far on far.Flight_number=f.Flight_number
inner join flight_leg as fl on f.Flight_number=fl.Flight_number
 where far.Amount between 200 and 300;


/**uçuşların tarihlere göre 
sıralı bir şekilde kalkış 
yaptığı havalimanlarını geri döndüren sorgu
 
 */
select f.Flight_number, fl.Leg_no, li.instance_date, li.Departure_Airport
from Flight as f 
inner join flight_leg as fl on f.Flight_number=fl.Flight_number 
inner join leg_instance as li on fl.Leg_no=li.Leg_no
								and fl.Departure_airport=li.Departure_Airport
                                and fl.Arrival_airport=li.Arrival_Airport
                                inner join airport as ai on ai.airport_code=li.Departure_Airport
order by li.instance_date;


/*Sabiha gökçen havaalanına konamayan uçakları listeler
not exists nested
*/
select * from airplane ai
where not exists (select * from can_land cl
					 where ai.airplane_type =cl.airplane_type_name and 
                     cl.airport_code="SAW");

/*İstanbula uçuş yapacak bütün 
havayolu şirketlerini sıralar
inner nested exists
*/
select Ai.*,li.* from airline ai
inner join flight f on
			f.airline_Name=ai.Company_Name
            inner join leg_instance li on
				li.flight_Number=f.Flight_Number
                where exists (select * from airport air where
								li.arrival_Airport=air.airport_code and
                                air.city="İstanbul");


/* 100 kmden uzun herhangi bir leg_instance
 için birden fazla koltuk satın almış yolcular
 inner 2 tablo
 
 */
 
select s.customer_passport,s.leg_no,s.instance_date,s.flight_number,count(*) ,li.distance from seats s
inner join leg_instance li on 
	li.distance>100 and
    li.flight_number=s.flight_number and
    li.leg_no=s.leg_no and
    li.instance_date=s.instance_date
group by s.flight_number,s.leg_no,s.instance_date,s.customer_passport
having count(*)>1 ;

/* ffc olan veya olmayan bütün müşterileri stutan view
web için kullanıldı

*/
create  or replace view all_customers as
select c.*,f.millage_info,f.segmentation,f.airline_code from customer c
left join ffc f on
c.passport_number=f.passport_number; 

select * from all_customers;



select * from ffc;

/* Satın alınmış fakan henüz
check-in yapılmamış bütün koltukları tutan VİEW*/
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

/* leg instanceların bağlı oldukları flightlar 
için atanmış uçuş ücretlerini tutar 
web için kullanıldı */
create  or replace view instances_with_prices as
select lf.*,f.fare_code,f.amount from leg_instance lf
left join fare f on f.flight_number=lf.flight_number
;
select * from instances_with_prices;


/* uzaklıkları 300-800 km dışındaki kayıların uçuş numaraları ile beraber uygun sayıdak 
koltuk numaraları ile beraber tarihleriyle döndürür */
SELECT instance_date, number_of_available_seats, Flight_number, Distance 
FROM leg_instance AS li WHERE NOT EXISTS
(SELECT * FROM flight_leg AS flg 
WHERE flg.Flight_number=li.Flight_number and 
flg.leg_no=li.leg_no and 
li.Distance between 300 and 800);






/*Hangi uçak id'sinin hangi şirkete ait
 olduğunu gösteren, airplane type name'ini
 de gösteren ve sonuçları da max_seat 
 sayısına göre sıralı bir şekilde veren sorgu*/
select a.Airplane_id, a.company_name, a.Airplane_type, airt.max_seats 
from airplane as a 
inner join Companies as c on a.company_name=c.Company_name 
inner join airplane_type as airt on a.Airplane_type=airt.Airplane_type_name 
order by airt.max_seats;


Create VIEW Customer_information 
as Select c.Customer_name, c.Passport_number, s.Seat_number, 
li.Distance, far.Amount, s.fare_code, li.Departure_airport, li.Arrival_Airport
from customer as c inner join seats as s on 
c.Passport_number=s.Customer_passport
inner join leg_instance as li on (s.Leg_no=li.Leg_no and 
s.Flight_number=li.Flight_number and s.Instance_date=li.instance_date) 
inner join flight_leg as fl on (li.Flight_number=fl.Flight_number and 
li.Leg_no=fl.Leg_no) and (li.Departure_Airport=fl.Departure_airport and 
li.Arrival_airport=fl.Arrival_airport)
 inner join flight as F on fl.Flight_number=F.Flight_number inner join
fare as far on (s.Flight_number=far.Flight_number and s.fare_code=far.Fare_code) order by amount;
select * from customer_information;


select * from airport;
/*londrada herhangi bir airporta konalecek uçakları sorgular*/
select * from airplane ap
where "London" in(Select ai.city
					from airport ai
					left join can_land cl on
                    ai.airport_code=cl.airport_code and
                    ap.airplane_type=cl.airplane_type_name);



select company_name, count(1) from airline a
left join has_airplane h
on a.company_id = h.company_id
group by company_name;



/* hangi şirketin hangi fair kodunu ne kadar kullandığını gösteren ve
şirkekleri kendi içlerin kullandıkları codun çokluğuna göre sıralayan sorgu
*/
select * ,count(*)from companies co
left join fare fa on
fa.flight_number in ( select flight_number from leg_instance li
						inner join airplane on li.airplane_id in 
                        (select airplane_id from airplane
						where co.company_name=airplane.company_name))
group by fa.fare_code ,co.company_name    
order by co.company_name,count(*) desc                                                            
                                                                    ;

                                                        
                                                                 
/* hangi müşterinin hangi şirketi ne kadar kullandığını gösterir*/
select *,count(*) from companies co
left join Customer cu  on
cu.passport_number in ( select customer_passport from seats si
						inner join flight f on f.flight_number in 
                        (select flight_number from flight
						where flight.airline_name=co.company_name))
group by cu.passport_number , co.company_name                                               
                                                                    ;

                                                   
                                                                    ;

select * from leg_instance;