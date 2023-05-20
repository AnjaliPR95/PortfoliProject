
-- performing queries on covid data from Jan 2020 to May 2023 of continent Asia
............................................................................................................................................
select * from coviddeath; 
select * from covidvaccinated;
select max(dates), min(dates) from coviddeath;
select count(*) 
from coviddeath;
select count(*) 
from covidvaccinated;
select max(dates), min(dates) from covidvaccinated;


select * 
from coviddeath 
order by 3,4; 

--select data that we are going to be using
 select 
 location, 
 dates,
 total_cases,
 new_cases,
 total_deaths,
 population from coviddeath
 order by 1,2 ;
 
 --total cases vs total death
 select 
 location, 
 dates,
 total_cases,
 new_cases,
 total_deaths,
 (total_deaths/total_cases)from coviddeath
 order by 1,2 ;

select 
 location, 
 dates,
 total_cases,
 new_cases,
 total_deaths,
 round((nvl(total_deaths,0)/total_cases)*100)as death_percentage from coviddeath
 where location like 'I%'
 order by 1,2 ;
 
 --looking at total cases vs population
 --shows what percentage of population got covid
 select 
 location, 
 dates, 
 population,
 total_cases,
 total_deaths,
 (nvl(total_cases,0)/population)*100 as Casepercentage
 from coviddeath
 --where location like 'I%'
 order by 1,2 ;
 
 --looking at countries with highest infection rate compared to population
 select 
 location, 
 population,
 max(total_cases) highestinfectioncount,
 max((total_cases/population))*100 as Casepercentage
 from coviddeath
 --where location like 'I%'
 group by location,population
 order by 1,2 ;
 
 
 select 
 location, 
 population,
 max(total_cases) hic,
 min(total_cases) lic,
 max((total_cases/population))*100 as percentpopulationinfected
 from coviddeath
 group by location,population
 order by percentpopulationinfected desc;
 
 --showing highest death count with location
 select 
 location, 
 max(total_deaths) as hdc
 from coviddeath
 group by location
 order by hdc desc;
 

select 
 location, 
 min(total_deaths) as hdc
 from coviddeath
 group by location
 order by hdc desc;
 
--numbers
    select
    dates,
    location,
    sum(total_cases),
    sum(new_cases), 
    sum(total_deaths)
    from coviddeath
    where location in ('India','Yemen','Pakistan')
    group by dates,location;

select 
iso_code,
max(total_vaccinations)
from covidvaccinated
group by iso_code ;

select 
dates,
sum(new_cases) as total_cases,
sum(cast(new_deaths as int)) as total_deaths
from coviddeath
group by dates
order by 1,2;

-- vaccination status across particular locations using joins
select dea.location,dea.total_deaths,vac.total_vaccinations,vac.new_vaccinations
from coviddeath dea
inner join covidvaccinated vac
on dea.location=vac.location
and dea.dates=vac.dates
where dea.location in ('India','Yemen') and vac.total_vaccinations is not null
and vac.new_vaccinations is not null
order by 1,2; 

-- created view 
create view VacAccLoc as
select dea.location,dea.total_deaths,vac.total_vaccinations,vac.new_vaccinations
from coviddeath dea
inner join covidvaccinated vac
on dea.location=vac.location
and dea.dates=vac.dates
where dea.location in ('India','Yemen') and vac.total_vaccinations is not null
and vac.new_vaccinations is not null
order by 1,2;

create view VacAccLocc as
select dea.location,dea.total_deaths,vac.total_vaccinations,vac.new_vaccinations
from coviddeath dea
inner join covidvaccinated vac
on dea.location=vac.location
and dea.dates=vac.dates
where dea.location in ('India','Yemen','Afghanistan') and vac.total_vaccinations is not null
and vac.new_vaccinations is not null
order by 1,2;

select * 
from VacAccLocc;