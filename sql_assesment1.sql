
create table city1(city_id int primary key auto_increment,
city_name varchar(20),
lat long,
longitute long,
country_id int,department
foreign key (country_id) references country2(country_id))

create table country2(country_id int primary key auto_increment,
country_name varchar(40),
country_name_eng varchar(40),
country_code varchar(20))

insert into city1(city_name,lat,longitute,country_id) values
 ("berlin",52.520008,13.404954,1),
 ("belgrade",44.787197,20.457273,2),
 ("zaagreb",45.815399,15.966568,3),
 ("new york",40.730610,-73.935242,4),
 ("Los angeles",34.052235,-118.243683,4),
 ("warsaw",52.237049,21.017532,5)
 
 insert into country2(country_name,country_name_eng,country_code) values
 ("Deutschland","germany","DEU"),
 ("serbia","serbia","SRB"),
 ("hrvatska","croatia","HRV"),
 ("United states of America","United states of America","USA"),
 ("polska","poland","POL"),
 ("Espana","spain","ESP"),
 ("Rossiya","Russia","RUS")
 
 CREATE TABLE customer2 (
    c_id INT PRIMARY KEY AUTO_INCREMENT,
    c_name VARCHAR(20),
    city_id INT,
    c_add VARCHAR(30),
    next_call_date DATE,
    ts_inserted DATETIME,
    FOREIGN KEY (city_id) REFERENCES city1(city_id)
);

INSERT INTO customer2 (c_name, city_id, c_add, next_call_date, ts_inserted) VALUES
('jewelry store', 4, 'Long street 120', '2020-01-21', '2020-01-09 14:01:20'),
('bakery', 1, 'kufustendamm 25', '2020-02-21', '2020-01-09 17:52:15'),
('cafe', 1, 'tauentzienstrabe 44', '2020-01-21', '2020-01-10 08:02:49'),
('restraunt', 3, 'Ulica Lipa 15', '2020-01-21', '2020-01-10 09:20:21');

-- List all Countries and customers related to these countries
select country_name,c_name from country2,city1,customer2 where city1.country_id=country2.country_id
and customer2.city_id=city1.city_id
 
 -- For each country displaying its name in English, the name of the city customer is located in as
-- well as the name of the customer.
 select country_name_eng,city_name,c_name from country2,customer2 left join city1 
 on city1.city_id=customer2.city_id

-- Return even countries without related cities and customers
select country2.country_id,country_name,city_name from country2 left join city1  
on city1.country_id=country2.country_id where city_name is null 
order by country_name

-- Return the list of all countries that have pairs(exclude countries which are not referenced by any
-- city). For such pairs return all customers.
SELECT country_name_eng,city_name,c_name FROM country2 JOIN city1 
ON city1.country_id = country2.country_id 
LEFT JOIN customer2 ON customer2.city_id = city1.city_id

 -- Return even pairs of not having a single customer
select country2.country_id,country_name from country2 left join city1  
on city1.country_id=country2.country_id 
left join customer2 on customer2.city_id=city1.city_id
where city_name is null and c_name is null
order by country_name
