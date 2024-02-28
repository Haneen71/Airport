 create schema `Airport` ;
use Airport;

create table airplane (
airplaneID VARCHAR(10) NOT NULL,
capacity INT,
airlineName VARCHAR(30),
CONSTRAINT airplane_PK PRIMARY KEY (airplaneID)
);

create table passenger (
passportNumber VARCHAR(10) NOT NULL,
firstName VARCHAR(20),
lastName VARCHAR(20),
nationality VARCHAR(20),
dateOfBirth DATE,
gender CHAR(1),
carrID VARCHAR(10) ,
CONSTRAINT passenger_PK PRIMARY KEY (passportNumber),
CONSTRAINT passenger_FK FOREIGN KEY (carrID) REFERENCES airplane (airplaneID)
);

create table emp_SRank (
jopRank VARCHAR(20) NOT NULL,
salary DECIMAL,
CONSTRAINT emp_SRank_PK PRIMARY KEY (jopRank) 
);

create table employee (
ID VARCHAR(10) NOT NULL,
firstName VARCHAR(20),
lastName VARCHAR(20),
dateOfBirth DATE,
gender CHAR(1),
jopRank VARCHAR(20),
phoneNumber CHAR(10),
nationality VARCHAR(20),
airID  VARCHAR(10),
CONSTRAINT employee_PK PRIMARY KEY (ID) ,
CONSTRAINT employee_FK FOREIGN KEY (airID) REFERENCES  airplane (airplaneID),
CONSTRAINT employee_FK2 FOREIGN KEY (jopRank) REFERENCES emp_SRank (jopRank)
);

create table ticket (
ticketCode varchar(10) not null,
airlineCompanyName varchar(30),
classOfTicket varchar(15),
gate VARCHAR(5),
ticketPrice DECIMAL,
payPassportNumber VARCHAR(10),
CONSTRAINT ticket_PK PRIMARY KEY (ticketCode),
CONSTRAINT ticket_FK FOREIGN KEY (payPassportNumber) REFERENCES passenger (passportNumber)
);

create table flight (
flightNumber VARCHAR(10) NOT NULL,
duration TIME,
dateOfFlight DATE,
destination VARCHAR(20),
timeOfLanding TIME,
timeOfTakeoff TIME,
ticCode varchar(10),
CONSTRAINT flight_PK PRIMARY KEY (flightNumber),
CONSTRAINT flight_FK FOREIGN KEY (ticCode) REFERENCES ticket (ticketCode)
);

create table Seat (
seatNumber VARCHAR(4) NOT NULL,
ticketCode varchar(10) NOT NULL,
specialService VARCHAR(30) ,
CONSTRAINT Seat_PK PRIMARY KEY (seatNumber),
CONSTRAINT Seat_FK FOREIGN KEY (ticketCode) REFERENCES ticket (ticketCode)
);

insert into airplane
values ('KR458902',300,'QATAR');
insert into airplane
values ('OU567895',155,'ANA');
insert into airplane
values ('WW679032',200,'Emirates');
insert into airplane
values ('ss134451',150,'SAUDIA');
insert into airplane
values ('ZA370056',300,'SAUDIA');

insert into passenger
values ('A678922','Ahmed','Salem','saudi arabia','1992-10-3','M','KR458902');
insert into passenger
values ('M567843','Maha','Tareq','saudi arabia','2000-5-1','F','OU567895');
insert into passenger
values ('V234187','Azam','Ahmed','Egypt','1989-8-1','M','WW679032');
insert into passenger
values ('M679866','Mwaddah','Salem','Jordan','2001-4-3','F','ss134451');
insert into passenger
values ('J439907','Mustafa','Jaber','saudi arabia','2003-4-11','M','ZA370056');


insert into emp_SRank
values ('cabin crew',7000);
insert into emp_SRank
values ('pilot',37000);
insert into emp_SRank
values ('copilot',20000);
insert into emp_SRank
values ('Flight attendant',8000);
insert into emp_SRank
values ('safty officer',10000);


insert into employee
values (1124535622,'Ahmad','otabi', '2001-11-1','M', 'cabin crew', 0555431290, 'Saudi', 'KR458902');
insert into employee
values (1287653311,'noor','otabi', '2001-1-5','F', 'copilot', 0555123422, 'Saudi', 'OU567895');
insert into employee
values (1123678889,'Dani','malk', '1996-3-5', 'M', 'pilot', 0539993413, 'Saudi', 'WW679032');
insert into employee
values (1098456671,'Dalia','Saad', '1991-7-4', 'F', 'Flight attendant', 0511335566, 'Saudi', 'ss134451');
insert into employee
values (1109874411,'Mohmmad','Saleh', '1994-2-16', 'M', 'safty officer', 0511227766, 'Saudi', 'ZA370056');


insert into ticket
values ('MW44','QATAR','business man','A1',1500.25,'A678922');
insert into ticket
values ('YT45','Emirates','economic','B3',1000.50,'M567843');
insert into ticket 
values ('RV67','ANA','economic','A2',1200.50,'V234187');
insert into ticket
values ('nw11','SAUDIA','business man','B4',2000.25,'M679866');
insert into ticket
values('fg87','SAUDIA','economic','C1',500.00,'J439907');


insert into flight
values (54, '9:15' , '2023-6-14' ,'italy', '17:15' , '2:15', 'MW44');
insert into flight
values (13,'6:45' , '2023-7-14' ,'rome', '9:45' , '15:45', 'YT45');
insert into flight
values (50, '15:05' , '2023-7-4' ,'france', '22:00' , '16:05','RV67');
insert into flight
values (23, '14:30' , '2023-8-11' ,'newyork', '23:00' , '15:30','nw11');
insert into flight
values (31, '12:30' , '2023-12-15' ,'london', '21:00' , '10:30','fg87');

insert into Seat
values ('B27','MW44','coffee');
insert into Seat
values ('C11','YT45','tea');
insert into Seat
values ('A15','RV67','smothie');
insert into Seat
values ('A3','nw11','Fruits');
insert into Seat
values ('B7','fg87','Water');

 
# find the capacity and arrange them in ascending, display them with the  airplaneID & airlineName ..
 SELECT airplaneID , capacity , airlineName 
 FROM airplane 
 ORDER BY capacity ASC;
 

# Search for people whose birth year is less than the year 2000, with the printing of their first name and passport number ..
SELECT passportNumber , firstName , dateOfBirth
FROM passenger
WHERE dateOfBirth < '2000/3/1';

#Find all female passengers
select passportNumber ,firstName, lastName,nationality,gender 
from airport.passenger
where gender = 'F' ;

# find all non-Jordan passengers
select *
FROM airport.passenger
where nationality not like "Jordan" ;

# Print the number of passengers according to the country, provided that they are less than 3 ..
SELECT COUNT( passportNumber ) AS " Number of Passport",  nationality 
FROM passenger
GROUP BY  nationality 
HAVING COUNT(passportNumber)<3
ORDER BY  COUNT(passportNumber) DESC;


#Arrangement of job ranks by the salary of each rank ..
SELECT jopRank , salary
FROM emp_SRank
order by salary ASC;


#Find the number of male employees by identity, first name, last name, nationality and job rank .. 
SELECT ID ,  firstName , lastName , nationality , jopRank , gender
FROM airport.employee
WHERE gender = 'M';

# Show me the number of employees by nationality ..
SELECT COUNT( ID) AS "Number of employee", nationality
FROM employee 
GROUP BY nationality ;

# View employee data with the  airplaneID in it through more than one table using JOIN ..
SELECT employee.ID , employee.firstName , airplane.airplaneID
 FROM employee
 INNER JOIN  airplane
 ON  employee.airID =  airplane.airplaneID;
 

#Show the lowest  price in tickets
SELECT min(ticketPrice)  
FROM airport.ticket;

# show all business class tickets and find the ticket price and arrange it from lowest to highest 
select ticketCode ,airlineCompanyName, classOfTicket, ticketPrice 
from airport.ticket
where classOfTicket like 'business man' 
order by ticketPrice asc ;

# Using subquery select average ticket prices display with classOfTicket , flightCompanyName and ticket price ..
SELECT classOfTicket , airlineCompanyName , ticketPrice , 
(SELECT avg(ticketPrice ) FROM ticket) AS avg_Price
 FROM ticket;


# Arranging flights according to the flight date and show the flight number, flight date, destination, take-off time and landing time 
SELECT flightNumber , dateOfFlight ,destination , timeOfLanding ,timeOfTakeoff 
FROM airport.flight
order by dateOfFlight;


#Number of services according to the seat .. 
SELECT COUNT(specialService ) AS " Number of Service", seatNumber
FROM  Seat
GROUP BY seatNumber;


 


 
 
 
