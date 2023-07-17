--Date Function
-- 1) DATEDIFF() get the diference between 2 dates in year or month or day or hour

select datediff(year,'2000-03-01',current_timestamp) --year
select datediff(month,'2000-03-01',current_timestamp) --month
select datediff(day,'2000-03-01',current_timestamp) --day
select datediff(hour,'2000-03-01',current_timestamp) --hour
select datediff(minute,'2000-03-01',current_timestamp) --minute
select datediff(second,'2000-03-01',current_timestamp) --second

-- 2) DAY() get the day from the date
select day(current_timestamp) as TODAY_DATE

-- 3) MONTH() get the day from the date
select month(current_timestamp) as CURRENT_MONTH

-- 4) DATENAME() get the parts of the date in "string"
select datename(day,current_timestamp) as Today_day
select datename(month,current_timestamp) as current_month
select datename(year,current_timestamp) as current_year
select datename(hour,current_timestamp) as current_hour
select datename(weekday,current_timestamp) as Today_day
select datename(week,current_timestamp) as Today_week

-- 5) DATEPART() get the parts of the date in "integer" , work same as DATENAME()
select datepart(day,current_timestamp) as Today_day
select datepart(month,current_timestamp) as current_month
select datepart(year,current_timestamp) as current_year
select datepart(hour,current_timestamp) as current_hour
select datepart(weekday,current_timestamp) as Today_day
select datepart(week,current_timestamp) as Today_week

-- 6) DATEADD(month/year/day...,INTERGER,'DATE')
SELECT DATEADD(MONTH,-6,GETDATE()) AS 'DATE BEFORE 6 MONTH'; --WE CAN PASS INTEGER AS +VE(AFTER) AND -VE(BEFORE)
SELECT DATEADD(MONTH,6,'2023-01-23') AS 'TRAINING PEROID END';
SELECT DATEADD(WEEK,-1,CURRENT_TIMESTAMP) AS 'DATE BEFORE 1 WEEK'; --DATE BEFORE 1 WEEK
SELECT DATEADD(WEEK,5,CURRENT_TIMESTAMP) AS 'DATE AFTER 5 WEEK'; --DATE AFTER 5 WEEK
SELECT DATEADD(MONTH,-1,CURRENT_TIMESTAMP) AS 'DATE BEFORE 1 MONTH'; --DATE BEFORE 1 MONTH
SELECT DATEADD(MONTH,10,CURRENT_TIMESTAMP) AS 'DATE AFTER 10 MONTH'; --DATE AFTER 10 MONTH

-- 7) SYSDATETIME() USED TO GET THE SYSTEM DATE AND TIME
SELECT SYSDATETIME() AS 'SYSTEM DATE TIME';
