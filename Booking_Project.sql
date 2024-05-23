--Q1.What is the overall cancellation rate for hotel bookings?
select ((select count(is_canceled) from bookings where is_canceled > 0)*100.0 /count(*)) as cancellation_rate
from bookings

--Q2.Which countries are the top contributors to hotel bookings?
select country , count(*) total_bookings
from bookings
group by country
order by 2 desc

--Q3.What are the main market segments booking the hotels, such as leisure or corporate?
select market_segment , count(*)
from bookings
group by market_segment
order by 2 desc

select * from bookings

--Q4.Is there a relationship between deposit type (e.g., non-refundable, refundable) and the likelihood of cancellation?
select  deposit_type, count(*) total_bookings ,
sum(case when is_canceled = 1 then 1 else 0 end) total_cancelation,
(sum(case when is_canceled = 1 then 1 else 0 end))*100.00 / count(*) as total_cancellationRate
from bookings
group by deposit_type 
order by total_cancellationRate desc

--Q5.How long do guests typically stay in hotels on average?


--Q6. What meal options (e.g., breakfast included, half-board) are most preferred by guests?
select meal , count(*)
from bookings
group by meal
order by 2 desc

'''Q7 Do bookings made through agents exhibit different cancellation rates or 
booking durations compared to direct bookings?'''

select case when agent is null or agent = 0 then 'Direct' else 'Agent'
end as modeOF_booking ,
(sum(case when is_canceled = 1 then 1 else 0 end ))*100.0 / count(*) as total_cancellationRate
from bookings
group by  case when agent is null or agent = 0 then 'Direct' else 'Agent' end

--Q8 How do prices vary across different hotels and room types? Are there any seasonal pricing trends?

select hotel , sum(price) total_price
from bookings
group by hotel
order by 2
--Q9. Seasonal Pricing trends
SELECT extract(month from booking_date) as season , Sum(price)
from bookings
group by extract(month from booking_date)
order by extract(month from booking_date)

--Q10.What percentage of bookings require car parking spaces, and does this vary by hotel location or other factors?
select hotel , country ,(count(case when required_car_parking_spaces = 0 then 1  end )*100.0 / count(*) ) percentage_parking
from bookings
group by hotel , country
order by 3 desc

--Q11..What are the main reservation statuses (e.g., confirmed, canceled, checked-in),and how do they change over time?

select extract(year from booking_date) as year,reservation_status , count(*)
from bookings
group by year ,reservation_status 
order by year 

--Q12.What is the distribution of guests based on the number of adults, children, and stays on weekend nights?


select adults , children , stays_in_weekend_nights , count(*) total_booking
from bookings
group by adults , children , stays_in_weekend_nights 

--Q13.Which email domains are most commonly used for making hotel bookings?
select substring(email from position ('@' in email )+1) as domain , count(*)
from bookings
where email is not null and email != ''
group by domain

--Q14.Are there any frequently occurring names in hotel bookings, and do they exhibit any specific booking patterns?
select * from bookings
select name , count(*) total_bookings
from bookings
group by name
order by name desc

--Q15.Which market segments contribute the most revenue to the hotels?
select market_segment , sum(price) total_amount
from bookings
group by market_segment
order by 2 desc

--Q16.How do booking patterns vary across different seasons or months of the year?
SELECT 
extract(year from booking_date) as season_year ,
extract(month from booking_date) as season_month , count(*) total_booking
from bookings
group by  extract(year from booking_date), extract(month from booking_date)
order by extract(year from booking_date),extract(month from booking_date) , 2








