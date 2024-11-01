select *
from survey;

create table survey_workbook
like survey;

insert into survey_workbook
select *
from survey;

select *
from survey_workbook;

-- Remove duplicates (if exists)

with duplicates_cte as
(
select *, row_number() over(partition by `timestamp`, age) as row_num
from survey_workbook
)
select *
from duplicates_cte
where row_num > 1;

-- NO DUPLICATES FOUND

-- Standardize the data

select *
from survey_workbook;

select gender
from survey_workbook
where gender like "M%";

update survey_workbook
set gender = "Male"
where gender like "M%";

select gender
from survey_workbook
where gender like "F%";

update survey_workbook
set gender = "Female"
where gender like "F%";

select gender
from survey_workbook
where gender not like "Male" and gender not like "Female";

update survey_workbook
set gender = "Other"
where gender not like "Male" and gender not like "Female";

select distinct gender
from survey_workbook;

select distinct country
from survey_workbook;

select *
from survey_workbook
where country like "Bahamas%";

update survey_workbook
set country = "The Bahamas"
where country like "Bahamas%";

-- Null values or Blank values

select *
from survey_workbook
where state is null
or state ="";
-- NO NULL VALUES OR BLANK VALUES

-- Remove any columns or rows

select *
from survey_workbook
where age < 18;

delete 
from survey_workbook
where age < 18;

select *
from survey_workbook
where age > 72;

delete 
from survey_workbook
where age > 72;

-- Exploratory data analysis

select max(age), min(age)
from survey_workbook;

select gender, count(treatment)
from survey_workbook
where treatment = "Yes"
group by gender
order by 2 desc
;

select gender, count(treatment)
from survey_workbook
where treatment = "No"
group by gender
order by 2 desc
;

select 
case
	when age >= 18 and age < 30 then "Young"
    when age >= 30 and age < 50 then "Middle"
    else "Old"
end as age_range, count(treatment)
from survey_workbook
where treatment = "Yes"
group by age_range
order by treatment
;

select 
case
	when age >= 18 and age < 30 then "Young"
    when age >= 30 and age < 50 then "Middle"
    else "Old"
end as age_range, count(treatment)
from survey_workbook
where treatment = "No"
group by age_range
order by treatment
;

select tech_company, count(tech_company)
from survey_workbook
group by tech_company
;

select country, sum(treatment = "Yes") as Yes, sum(treatment = "No") as `No`
from survey_workbook
group by Country
order by Country
;

