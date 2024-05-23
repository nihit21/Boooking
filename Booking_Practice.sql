-- Q1. Retrieve all bookings made by customers from the United Kingdom (UK).
select booking_id
from bookings
where country = 'GBR'

--Q2 Find the total number of canceled bookings.
select Count(booking_id) total_cancellation
from bookings
where is_canceled = 1

-- Q3.Calculate the average price of bookings made by adults only.
select avg(price)
from bookings
where children = 0

--Q4.List the top 5 countries with the highest number of bookings.

select Country,Sum(price) Total_bookings
from bookings
group by country
order by 2 desc
limit 5

--Q5 Count the number of bookings made by each market segment.
SELECT market_segment , count(booking_id)
from bookings
group by market_segment

--Q6 Determine the percentage of canceled bookings.

with cancel as (
Select count(*) total_cancel_bookings
	from bookings
	where is_canceled = 1 
)

select (total_cancel_bookings * 100.0) / (SELECT COUNT(*) FROM bookings) AS percentage_cancellation
from cancel

-- @2nd solution
SELECT 
    (COUNT(CASE WHEN is_canceled = 1 THEN 1 END) * 100.0 / COUNT(*)) AS percentage_canceled
FROM bookings;

-- Q7 Identify the market segment with the highest average booking price.

select market_segment , avg(price)
from bookings
group by market_segment
order by 2 desc 
limit 1

--Q8 .Find the total number of bookings made for each hotel.
select hotel , count(booking_id) total_hotel_bookings
from bookings
group by hotel
order by 2 desc 

-- Q9 Calculate the average number of children per booking.
select * from bookings

select avg(children) average_children_per_booking
from bookings
where children is not null

--Q10 .List the countries where the majority of bookings are made for weekend stays.

--Q10 .List the countries where the majority of bookings are made for weekend stays.

with cte1 as (select country , count(*) total_weekend_booking
from bookings
where stays_in_weekend_nights != 0
group by country ),
cte2 as(select country , count(*) total_bookings
from bookings
group by country)

select cte1.country, total_weekend_booking , ((total_weekend_booking * 100)/(total_bookings)) percent_booking
from cte1
join cte2
on cte1.country = cte2.country
where (total_weekend_booking * 100)/(total_bookings) > 50
order by 3 desc
 -- second method to do
SELECT country
FROM (
    SELECT 
        country,
        SUM(CASE WHEN stays_in_weekend_nights > 0 THEN 1 ELSE 0 END) AS weekend_bookings,
        COUNT(*) AS total_bookings,
        (SUM(CASE WHEN stays_in_weekend_nights > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS percentage_weekend_bookings
    FROM bookings
    GROUP BY country
) AS country_weekend_stats
WHERE percentage_weekend_bookings > 50

--Q11.Retrieve the bookings made by customers who have provided an email address?

select booking_id , name ,email
from bookings
where email is not null

--Q12. Find the total number of bookings made by agents with IDs above 100.
select count(*) 
from bookings
where agent > 100

--Q13. Calculate the average price of bookings made by customers who stayed for more than 3 weekend nights.

select name , avg(price)
from bookings
where stays_in_weekend_nights > 3
group by name

--Q14. Identify the most common meal choice among bookings.
select meal, count(*) Total_meal_orders
from bookings
group by meal
order by 2 desc

--Q15. List the bookings made by customers who reserved a parking space.

SELECT name , required_car_parking_spaces
from bookings
where required_car_parking_spaces != 0  

-- Q16. Determine the average price of bookings made by customers from each country.
select country , avg(price)
from bookings
group by country
order by 2

--Q17.Retrieve the bookings made by customers with the name "Michael" in their name.
select name
from bookings
where name like '%Michael%'

--Q18.Find the total number of bookings made by market segment for each hotel.

select hotel , market_segment , count(*)
from bookings
group by hotel , market_segment

--Q19.Calculate the percentage of bookings made by adults compared to children.
SELECT
sum(adults) as total_adults,
sum(children) as total_children,
(sum(children) * 100.0 / nullif (sum(adults), 0)) as percentage_childrens_to_adult
from bookings

--Q20 Identify the booking with the highest price.
SELECT *
from bookings
where price is not null
order by price desc
limit 1

--Q21 List the bookings made by customers who canceled but provided an email address
select booking_id, name
from bookings
where is_canceled > 0
and email is not null and email <>''

select * from bookings
--Q22 Determine the average number of adults per booking for each hotel.
select booking_id , hotel , avg(adults)
from bookings
group by booking_id , hotel
select * from bookings
--Q23  Find the total number of bookings made in each year.
select  extract(year from booking_date) booking_year , count(*) 
from bookings
group by extract(year from booking_date)
order by 2

--Q24 Retrieve the bookings made by customers with names starting with the letter "A".
select booking_id , name
from bookings
where name LIKE 'A%'




