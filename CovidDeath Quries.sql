--select
--*
--from
--CovidDeaths

--select
--*
--from
--CovidDeaths
--order by location, date desc

--select
--*
--from
--CovidVaccinations
--order by location, date desc

--select data that we are planing to use

--select
--location, date, total_cases, new_cases, total_deaths, population
--from
--CovidDeaths

--Looking at Total Cases vs Total Deaths.  Had to cast total deaths and total cases due to nvarchar issues.

--select
--location, date, total_cases,  total_deaths, (cast(total_deaths as float)/cast(total_cases as float))
--from
--CovidDeaths

--select
--location, date, total_cases,  total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as DeathPercentage
--from
--CovidDeaths

--select
--location, date, total_cases,  total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as DeathPercentage
--from
--CovidDeaths
--where location = 'United States'

--I had covid 9/1/2020 according to this I had a 3.1% chance of dieing from Covid.

--Looking at Total Cases Vs Population.  Shows % of positive Covid

--select
--location, date, total_cases,  population, (total_cases/population)*100 as CovidPercentage
--from
--CovidDeaths
--where location = 'United States'

--Looking at countries with hightest infection rate compared to poplation.


--select
--location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
--from
--CovidDeaths
--where location = 'United States'
--group by location, population

--select
--location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
--from
--CovidDeaths
--group by location, population
--order by PercentPopulationInfected

--Showing countries with highest death count per population.


--select
--location, max(cast(total_deaths as int)) as TotalDeathCount
--from
--CovidDeaths
--where continent is not null
--group by location
--order by TotalDeathCount desc

--break things down by continent

--select
--continent, max(cast(total_deaths as int)) as TotalDeathCount
--from
--CovidDeaths
--where continent is not null
--group by continent
--order by TotalDeathCount desc

--showing the contintents with the highest death count per population

--select
--continent, sum(new_deaths) as TotalDeathCount
--from
--CovidDeaths
--where continent is not null
--group by continent
--order by TotalDeathCount desc

--Joins

--Looking at total population vs vaccinations

--select
--*
--from
--CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date

--select
--dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from
--CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date
--where dea.continent is not null

--USE CTE

--With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
--as
--(
--select
--dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from
--CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date
--where dea.continent is not null
--)
--select
--*, (RollingPeopleVaccinated/population)
--from
--PopvsVac

--Temp Table

--drop table if exists #PercentPopulationVaccinated
--create table #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--insert into #PercentPopulationVaccinated
--select
--dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from
--CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date
--where dea.continent is not null

--select
--*, (RollingPeopleVaccinated/Population)*100
--from
--#PercentPopulationVaccinated


--creating view to store data for later visualizations

--create view PercentPopulationVaccinated as
--select
--dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from
--CovidDeaths dea
--join CovidVaccinations vac
--on dea.location = vac.location
--and dea.date = vac.date
--where dea.continent is not null