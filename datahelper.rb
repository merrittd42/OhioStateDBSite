require 'sinatra'
require 'tiny_tds'

get '/' do
  @title = "Oh boy, this is an index page."
  erb :index
end

get '/about' do
  @title = "We are a team of people who took a class about databases."
  erb :about
end

get '/emptyDB' do
  @title = "Empty database time!"
  executeQuery(@createDatabaseQ)
  erb :emptyDB
end

get '/tableMake' do
  @title = "Cookin' up some tables right quick."
  executeQuery(@tableQ)
  erb :tableMake
end

get '/populateDB' do
  @title = "What is a table but a container for tuples?"
  executeQuery(@insertQ)
  erb :populateDB
end

get '/union' do
  @title = "The union operation, in all its glory."
  executeQuery(@unionQ)
  erb :union
end

get '/intersection' do
  @title = "Intersection, but not of the traffic variety."
  executeQuery(@intersectionQ)
  erb :intersection
end

get '/difference' do
  @title = "Whether these lame titles annoy you makes no DIFFERENCE to me!"
  executeQuery(@differenceQ)
  erb :difference
end

get '/division' do
  @title = "It is such a Joy to do Divison!"
  executeQuery(@divisionQ)
  erb :division
end

get '/aggregation' do
  @title = "Aggregation is a hard word to spell. I know from experience."
  executeQuery(@aggregationQ)
  erb :aggregation
end

get '/innerJoin' do
  @title = "Inner join! Wow! Look at those graphics!"
  executeQuery(@innerJoinQ)
  erb :innerJoin
end

get '/outerJoin' do
  @title = "Outer join! It is ALSO a join! Oh man!"
  executeQuery(@outerJoinQ)
  erb :outerJoin
end

get '/customQuery' do

end

get '/databaseExplode' do
  executeQuery("drop database [Property Management Company]")
  @title = "Dropped that database for you!"
  erb :index
end

before do
  def executeQuery(sql)
    #So obviously this is not secure, but it's for a local database.
    #Also, Vroom Vroom Car is an awesome password, no doubts about that one.
    client = TinyTds::Client.new(username: 'sa', password: 'VroomVroomCar!',
      host: 'localhost', port: 1433)
      puts 'Running command'
      result = client.execute(sql)
      result.each
      if result.affected_rows > 0 then puts "#{result.affected_rows} row(s) affected" end
      result.each do |row|
        puts row
      end
      return result
  end

  @createDatabaseQ = "create database [Property Management Company]"
  @tableQ = "use [Property Management Company]
create table LEASE
(Lease_ID int not null,
Rent_cost int,
Start_date date,
End_date date,
primary key(Lease_ID),
Address_name varchar(100) not null,
);

create table TENANT

(Name varchar(50) not null,
Ssn char(9) not null,
Birthdate date,
Phone_Number char(10),
Gender char(1),
Email varchar(70),
Lease_ID int not null,
primary key(Ssn),
Constraint tenant_lease_foreign_key foreign key(lease_id) references LEASE(lease_id)
);

create table MANAGER
(Ssn char(9) not null,
 Workplace varchar(30) not null,
 Birthdate date,
 Name varchar(50) not null,
 Primary key(Ssn)
);

create table PROPERTY
(Address_name varchar(100) not null,
Building_Type varchar(10),
Amenities int,
Number_of_rooms int,
Parking_spots int,
Zone varchar(255),
Utility_Package int not null,
Manager_Ssn char(9) not null,
primary key(Address_name),
Constraint property_manager_foreign_key foreign key(Manager_Ssn) references MANAGER(Ssn)
);

create table PARKING_PASS
(Pass_Number int not null,
start_date date not null,
End_date date not null,
License_Plate varchar(7),
Tenant_SSN char(9),
Primary key(Pass_Number),
constraint Parking_Tenant_SSN_key foreign key(Tenant_SSN) references TENANT(Ssn)
);

create table HOUSE_KEYS
(key_id int not null,
description varchar(255),
Tenant_SSN char(9),
Primary key(key_id),
constraint housekeys_Tenant_SSN_key foreign key(Tenant_SSN) references TENANT(Ssn)
);

create table ZONING_MANAGER
(zoning_manager_id int not null,
Name varchar(50) not null,
city_office varchar(100),
Zoning_area varchar(50),
Primary key(zoning_manager_id)
);

create table ADVERTISEMENT_PROPERTY
(Ad_ID int not null,
Property_address varchar(100),
primary key(Ad_ID),
Constraint advertisementproperty_property_foreign_key foreign key(Property_address) references PROPERTY(Address_name)
);

create table MAINTENANCE_WORKER
(name varchar(50) not null,
ssn char(9) not null,
employed_in_house binary not null,
Job_role varchar(20),
Primary key(ssn),
);

create table MAINTENANCE_REQUEST
(RequestID int not null,
 Description varchar(255),
 Cost money,
 Date_Requested date not null,
 Date_Finished date not null,
 Worker_ssn char(9),
 Property_Address varchar(100) not null,
 Primary key(RequestID),
 Constraint maintenanceRequest_worker_forKey FOREIGN KEY  (Worker_ssn) REFERENCES MAINTENANCE_WORKER(ssn)
);

create table UTILITY_PACKAGE
(UID int not null,
 Gas binary not null,
 Electricity binary not null,
 Water binary not null,
 Cable binary not null,
 Primary key(UID)
);

create table RENT_PAYMENT
(Payment_Type varchar(50) not null,
Payment_ID int not null,
Due_Date date,
Paid_On date,
Amount money,
Paid_By_Ssn char(9) not null,
Primary key(Payment_ID),
Constraint Paid_By_Key foreign key(Paid_By_Ssn) references Tenant(Ssn)
);

create table PET
(Pet_Name varchar(50) not null,
Animal_Type varchar(50),
Pet_ID int not null,
Owner_Ssn char(9) not null,
Primary key(Pet_ID),
Constraint _Owner_Key foreign key(Owner_Ssn) references Tenant(Ssn)
);

Create table SUBLEASE
(Name varchar(50) not null,
Ssn char(9) not null,
Phone# char(10),
Start_Date date,
End_Date date,
Lease_ID int not null,
Primary key(Ssn),
Constraint Lease_Key foreign key(Lease_ID) references Lease(Lease_ID)
);

Create table COSIGNER
(Name varchar(50) not null,
Ssn char(9) not null,
Relationship varchar(50),
Tenant_Ssn char(9) not null,
Primary key(Ssn),
Constraint Tenant_Key foreign key(Tenant_Ssn) references Tenant(Ssn)
);
create table ADVERTISEMENT
(AdID int not null,
 Manager_SSN char(9) not null,
 Description varchar(300),
 Cost money,
 Start_Date date not null,
 End_Date date not null,
 Primary key(AdID),
 Constraint advertisementforkey FOREIGN KEY  (AdID) REFERENCES ADVERTISEMENT_PROPERTY(Ad_ID)
);

alter table ADVERTISEMENT
add Constraint managerforkey FOREIGN KEY  (Manager_SSN) REFERENCES MANAGER(SSN);

alter table PROPERTY
add Constraint utilitypackageforkey FOREIGN KEY (Utility_Package) REFERENCES UTILITY_PACKAGE(UID);
Alter table PROPERTY
Add Constraint chckroom CHECK (Number_of_rooms > 0);
alter table LEASE
add Constraint lease_property_foreign_key foreign key(address_name) references PROPERTY(address_name);

CREATE TABLE TENANT_AUDIT
(Name varchar(50) not null,
Ssn char(9) not null,
Birthdate date,
Phone_Number char(10),
Lease_ID int not null,
Audit_Action varchar(100),
Audit_Timestamp datetime);

CREATE TABLE PROPERTY_AUDIT
(Address varchar(50) not null,
Zone varchar(255),
Manager_Ssn char(9) not null,
Audit_Action varchar(100),
Audit_Timestamp datetime);"

@insertQ = "use [Property Management Company]
INSERT INTO UTILITY_PACKAGE
values
(123, 1, 1, 1, 1),
(321, 1, 1, 1, 0),
(455, 1, 1, 1, 1),
(420, 1, 1, 1, 1),
(690, 1, 1, 1, 0);

INSERT INTO ZONING_MANAGER
Values
(123,'John Smith', 'zoning committee of columbus', '43201'),
(321, 'Leah Aldridge', 'zoning committee of Franklin County', '43221'),
(455, 'Ty Lue', 'zoning committee of Cleveland', '44101'),
(420, 'Mayor West', 'zoning committee of Quahog', '00093'),
(690, 'Doc Rivers', 'zoning committee of Boston', '01901');

INSERT INTO MAINTENANCE_WORKER
Values
('Michael Jordan', '123456789', 1, 'Electrician'),
( 'Christina Rock','987654321' , 0, 'Plumber');

INSERT INTO MANAGER
values
('123456789', 'SlumlordsRUs', '2017-04-05', 'Jim Jimmerson'),
('987654321', 'SlumlordsRUs', '2017-04-05', 'Jim Jimmerson Jr.'),
('287989827', 'Jasons Houses',  '2017-04-05', 'Jason Sudeikus');

INSERT INTO PROPERTY
Values
('123 sesame st', 'apartment', 5, 3, 2, 'no zoning restriction', 123,'123456789'),
('456 ohio st', 'condo', 5, 4, 3, 'setback 10 yards from the street', 321,'987654321'),
('101 quicken', 'condo', 5, 4, 3, 'across from quicken loans arena', 455, '287989827'),
('198 spooner st', 'house', 4, 2, 2, 'next to Joe', 420, '287989827'),
('999 checker rd', 'apartment', 3, 3, 2, 'free zoning', 690, '987654321');

INSERT INTO LEASE
Values
(123, 500, '2016-09-09', '2017-04-05', '123 sesame st'),
(321, 600, '2015-09-21', '2017-09-12', '456 ohio st'),
(455, 700, '2014-08-12', '2017-08-03', '101 quicken'),
(420, 800, '2003-09-12', '2018-04-21', '198 spooner st'),
(690, 950,'2010-12-01','2019-12-01', '999 checker rd');


INSERT INTO TENANT
values
('Jon Jones', '123456789', '2001-01-01', '5432346798', 'M', 'yusuf@farah.uk', 123),
('Jim Jimmerson', '123543567', '2011-09-09', '4409387364','M', 'email1@gmail.com', 123),
('Alison Jim', '987654321', '2007-10-10', '4334556698', 'F', 'alison@jim.uk', 321),
('Lebron James', '657456345', '2006-10-09', '9178721345', 'M', 'lebron@cavs.nba', 455),
('Kyrie Irving', '432123786', '2010-10-01','765434212', 'M', 'kyrie@cavs.nba', 455),
('Kevin Love', '231213987', '2009-06-03', '614345566', 'M', 'kevin@cavs.nba', 455),
('Jason Sudeikus', '575776234', '2001-12-11', '1235431290', 'F', 'megan@family.guy', 420),
('Lois Griffin', '567321345','2004-10-12', '1235431289', 'F', 'lois@family.guy', 420),
('stewie Griffin', '413456543', '2017-06-05', '9998882333', 'M', 'stewie@family.guy', 420),
('Peter Griffin', '099221345', '2004-12-10', '3434890987', 'M', 'peter@family.guy', 420),
('Chris Griffin', '987334556', '2010-12-12', '3453212345', 'M', 'chris@family.guy', 420),
('Rondo Rajon', '776677622', '2004-05-03','1237653459', 'M ', 'rondo@celtics.nba', 690),
('Isaiah Thomas', '678987543', '2004-05-12', '6178990967', 'M', 'isaiah@celtics.nba', 690);



INSERT INTO RENT_PAYMENT
Values
('Cash', 123, '2017-3-21', '2017-3-1', $450,'123456789'),
('Credit', 321, '2017-3-21', '2017-3-5', $500, '987654321'),
('Credit', 124, '2017-3-21', '2017-3-5', $500, '432123786'),
('Cash', 125, '2017-3-22', '2017-3-10', $600, '657456345'),
('Credit', 126, '2017-3-22', '2017-3-10', $600, '657456345'),
('Cash', 127, '2017-3-24', '2017-3-10', $650, '099221345'),
('Credit', 128, '2017-3-24', '2017-3-15', $700, '987334556'),
('Cash', 129, '2017-3-24', '2017-3-16', $700, '575776234'),
('Credit', 130, '2017-3-24', '2017-3-17', $450, '231213987');

INSERT INTO PET
Values
('Fluffy', 'fish', 123, '123456789'),
('Mr Wuddles', 'pitbull', 321, '987654321'),
('Brain', 'dog', 420, '099221345');

INSERT INTO SUBLEASE
values
('Marshall Mathers', '123456789', '4405960192', '2016-9-22', '2017-9-22', 123),
('Lebrons James', '987654321', '4403859405', '2015-9-20', '2017-9-20', 321);

INSERT INTO COSIGNER
Values
('Emma Watson', '987654321', 'Sister', '123456789'),
('Jennifer Lawrence', '123456789', 'Mother', '987654321'),
('Jaime Speigel', '473849585', 'Mother', '657456345'),
('Mary Moore', '292045058', 'Mother', '432123786'),
('Emma Taillon', '294045058', 'Mother', '231213987'),
('Jack Watson', '292048058', 'Father', '575776234'),
('Barry Sanders', '292045958', 'Father', '567321345'),
('John Watson', '392045058', 'Brother', '413456543');

INSERT INTO MAINTENANCE_REQUEST
values
(123, 'Broken toilet', $465000, '2012-12-12', '2017-12-12',  '123456789' ,'200 East West Street, Columbus Ohio'),
(321, 'Drywall hole', $999465000, '2012-12-12', '2017-12-12', '123456789' , '200 East West Street, Columbus Ohio');

INSERT INTO ADVERTISEMENT_PROPERTY
values
(123, '123 sesame st'),
(455, '101 quicken'),
(420, '198 spooner st'),
(690, '999 checker rd'),
(321, '456 ohio st');

INSERT INTO ADVERTISEMENT
values
(123, '123456789', 'Bus Advertisement Banner', $4600.00, '2012-12-12', '2017-12-12'),
(455, '287989827', 'TV commercial during the playoff', $9800.89, '2017-05-02', '2019-04-23'),
(420, '123456789', 'Subway Advertisement Banner', $3200.00, '2012-03-01', '2018-01-01'),
(690, '987654321', 'TV commercial during the playoffs', $9800.89, '2014-04-20', '2020-06-04'),
(321, '987654321', 'Bus Advertisement Banner With Flowery Font', $4600.50, '2012-12-12', '2017-12-12');

INSERT INTO PARKING_PASS
Values
(123,'2012-8-17','2013-5-5', 'AUW5467', '123456789'),
(321,'2012-8-17','2013-5-5', 'ADHENB7', '987654321'),
(455,'2012-4-13','2015-4-1','AEHEN31', '432123786'),
(420,'2012-4-13','2015-4-1','AFUH675','099221345'),
(720,'2013-5-2','2015-3-2','AMNS908', '776677622');


INSERT INTO HOUSE_KEYS
Values
(123, 'electronic', '123456789'),
(321, 'metal', '987654321'),
(455,'shared', '432123786'),
(420, 'barcore', '099221345'),
(690, 'electronic', '987654321'),
(720, 'shared', '776677622');

INSERT into PROPERTY values
('789 chillicothe','condo',1,3,2,1,123,'123456789');"

@unionQ = "use [Property Management Company]
--union (Table of attributes from properties '123 sesame st' and '456 ohio st')
SELECT Building_Type, Amenities, Number_of_rooms, Parking_Spots, Utility_Package
FROM PROPERTY
WHERE Address_name = '123 sesame st'
UNION
SELECT Building_Type, Amenities, Number_of_rooms, Parking_Spots, Utility_Package
FROM  PROPERTY
WHERE Address_name = '456 ohio st'"

@inertsectionQ = "use [Property Management Company]
--intersection (Tenants have the same name as their manager i.e. same person)
SELECT Name
FROM TENANT
INTERSECT
SELECT Name
FROM  MANAGER"

@differenceQ = "use [Property Management Company]
--difference (people who don't have a pet and parking pass
SELECT Name
FROM TENANT
EXCEPT
(SELECT Name FROM TENANT WHERE Ssn IN(SELECT Owner_Ssn FROM PET)
INTERSECT
SELECT Name FROM  TENANT WHERE Ssn IN(SELECT Tenant_SSN FROM PARKING_PASS))"

@divisionQ = "use [Property Management Company]
--division
SELECT name,ssn FROM MAINTENANCE_WORKER as w WHERE NOT EXISTS (SELECT RequestID FROM MAINTENANCE_REQUEST as m WHERE NOT
EXISTS (SELECT * FROM MAINTENANCE_REQUEST WHERE Worker_ssn=w.ssn and RequestID=m.RequestID))"

@aggregationQ = "use [Property Management Company]
--aggregation (Table of apartment types and the number of properties each one has)
SELECT Building_Type, count(Address_name) as Num_props FROM PROPERTY
GROUP BY Building_Type"

@innerJoinQ = "use [Property Management Company]
--joins (Table of each tenant name & ID, their cosigner's name & ID, along with their relationship and address)
Select t.ssn as Ten_Id, t.Name as Ten_Name, c.Ssn as Cos_Id, c.Name as Cos_name, c.Relationship as relationship, p.Address_name as Prop_add
FROM TENANT as t, COSIGNER as c, PROPERTY as p, LEASE as l
WHERE  p.Address_name=l.Address_name and t.Lease_ID IN
(SELECT Lease_ID FROM TENANT WHERE c.Tenant_SSN=Ssn
INTERSECT
SELECT Lease_ID FROM TENANT WHERE l.Lease_ID=Lease_ID)"

@outerJoinQ = "use [Property Management Company]
SELECT t.Name, c.Name
FROM TENANT as t
FULL OUTER JOIN SUBLEASE as c ON t.Lease_ID = c.Lease_ID
ORDER BY t.Name;"
end
