-- total cases vs total death (percentage) : probabilitas kematian

SELECT location, date, total_deaths, total_cases, (CAST(total_deaths AS float)/CAST(total_cases AS float))*100 AS percentage
FROM deaths
WHERE location = 'Indonesia'
ORDER BY date

-- total cases vs population (percentage) : presentase populasi yang terpapar virus

SELECT location, date, population, total_cases, (CAST(total_cases AS float)/CAST(population AS float))*100 AS percentage
FROM deaths
WHERE location = 'Indonesia'
ORDER BY date

-- negara dengan tingkat infeksi tertinggi dibandingkan dengan populasi

SELECT location, population, MAX(total_cases) AS highest, MAX(CAST(total_cases AS float)/CAST(population AS float))*100 AS percentage
FROM deaths
WHERE total_cases IS NOT NULL
GROUP BY location, population
ORDER BY percentage DESC
LIMIT 1

-- benua dengan jumlah kematian tertinggi

SELECT continent, MAX(total_deaths) AS count
FROM deaths
WHERE continent IS NOT NULL
GROUP BY continent 
ORDER BY count DESC

-- berapa jumlah orang yang telah divaksin di seluruh dunia

SELECT SUM(CAST(new_cases AS float)) AS total_cases, SUM(CAST(new_deaths AS float)) AS total_deaths, SUM(CAST(new_deaths AS float))/SUM(CAST(new_cases AS float))*100 AS death_percentage
FROM deaths
WHERE continent IS NOT NULL

-- 

SELECT location, SUM(cast(new_deaths AS float)) AS total_death
FROM deaths
WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'International', 'Upper middle income', 'Lower middle income', 'Low income', 'High income')
GROUP BY location
ORDER BY total_death DESC

---

SELECT location, population, MAX(CAST(total_cases AS float)) AS highest_infected, MAX((CAST(total_cases AS float))/CAST(population AS float))*100 AS percented_infected_population
FROM deaths
GROUP BY location, population
ORDER BY percented_infected_population

--

SELECT location, population, MAX(CAST(total_cases AS float)) AS highest_infected, MAX(CAST(total_cases AS float)/CAST(population AS float))*100 AS infected_population_percent
FROM deaths
GROUP BY location, population
ORDER BY infected_population_percent DESC

--

SELECT location, population, date, MAX(CAST(total_cases AS float)) AS highest_infected, MAX(CAST(total_cases AS float)/CAST(population AS float))*100 AS infected_population_percent
FROM deaths
GROUP BY location, population, date
ORDER BY highest_infected DESC

--

SELECT location, population, date, MAX(CAST(total_cases AS int)) AS highest_infected, MAX(CAST(total_cases AS int)/CAST(population AS numeric))*100 AS infected_population_percent
FROM deaths
GROUP BY location, population, date
ORDER BY infected_population_percent DESC