#SELECT * FROM moviesdb.movie_actor;
#SELECT title, industry FROM moviesdb.movies;
use moviesdb;
#SELECT * FROM movies;
#SELECT title, industry FROM movies;
#SELECT * FROM movies WHERE industry='Bollywood';
#SELECT COUNT(*) FROM movies WHERE industry='Bollywood';
#SELECT distinct industry FROM movies;
#SELECT * FROM movies WHERE title LIKE '%THOR%';
#SELECT * FROM movies WHERE studio="";
#SELECT title, release_year FROM movies WHERE studio="Marvel Studios";
#SELECT * FROM movies WHERE title LIKE '%Avenger%';
#SELECT release_year FROM movies WHERE title="The Godfather";
#SELECT distinct studio FROM movies  WHERE industry="Bollywood";
#SELECT * FROM movies WHERE imdb_rating>=9;
#SELECT * FROM movies WHERE imdb_rating>=6 AND imdb_rating<=8;
#SELECT * FROM movies WHERE imdb_rating BETWEEN 6 AND 8;
#SELECT * FROM movies WHERE release_year=2022 or release_year=2019 or release_year=2018;
#SELECT * FROM movies WHERE release_year IN (2022, 2019,2018);
#SELECT * FROM movies WHERE imdb_rating is NULL;
#SELECT * FROM movies WHERE imdb_rating is not NULL;
#SELECT * FROM movies WHERE industry='Bollywood' ORDER BY imdb_rating;
#SELECT * FROM movies WHERE industry='Bollywood' ORDER BY imdb_rating ASC;
#SELECT * FROM movies WHERE industry='Bollywood' ORDER BY imdb_rating DESC;
#SELECT * FROM movies WHERE industry='hollywood' ORDER BY imdb_rating DESC LIMIT 5;
#SELECT * FROM movies WHERE industry='hollywood' ORDER BY imdb_rating DESC LIMIT 5 OFFSET 2;
#SELECT * FROM movies WHERE release_year=2022;
#SELECT * FROM movies ORDER BY release_year DESC;
#SELECT * FROM movies WHERE release_year>2020;
#SELECT * FROM movies WHERE release_year>2020 AND imdb_rating>8;
#SELECT * FROM movies WHERE studio IN ('Marvel studios','Hombale Films');
#SELECT title, release_year FROM movies WHERE title LIKE '%THOR%' ORDER BY release_year ASC;
#SELECT * FROM movies WHERE studio!='Marvel studios';
#SELECT COUNT(imdb_rating) FROM movies WHERE industry='Bollywood';
#SELECT MAX(imdb_rating) FROM movies WHERE industry='Bollywood';
#SELECT MIN(imdb_rating) FROM movies WHERE industry='Bollywood';
#SELECT ROUND(AVG(imdb_rating),2) FROM movies WHERE industry='Bollywood';
#SELECT ROUND(AVG(imdb_rating),2) as avg_rating,
#	MAX(imdb_rating) as max_rating,
	#MIN(imdb_rating) as min_rating
#FROM movies WHERE industry='Bollywood';
#SELECT
#	studio, COUNT(*) as cnt
#FROM movies
#GROUP BY studio
#ORDER BY cnt DESC;
#SELECT COUNT(*) FROM movies WHERE industry='hollywood';
#SELECT
#	industry, COUNT(*) as cnt,
#    avg(imdb_rating) as avg_rating
#FROM movies
#GROUP BY industry
#ORDER BY cnt DESC;
#SELECT COUNT(*) FROM movies WHERE release_year BETWEEN 2015 and 2022;
#SELECT 	MAX(release_year) as max_release,
#	MIN(release_year) as min_release
#FROM movies;

#SELECT
#	release_year, COUNT(*) as cnt
#FROM movies
#GROUP BY release_year
#ORDER BY release_year DESC;
#order of execution goes like> FROM --> WHERE --> GROUP BY --> HAVING --> ORDER BY
#SELECT
#	release_year, COUNT(*) as cnt
#FROM movies
#GROUP BY release_year
#Having cnt>2
#ORDER BY release_year DESC;
#SELECT *, YEAR(curdate())-birth_year as age FROM actors;
#SELECT *, IF(currency='USD',revenue*77, revenue) as revenue_inr FROM financials;
#SELECT distinct unit FROM financials;
#SELECT *, 
#CASE
#WHEN unit='thousands' THEN revenue/1000
#WHEN unit='billions' THEN revenue*1000
#ELSE revenue
#END as revenue_mln
#FROM financials;
#select 
#        *, 
#    (revenue-budget) as profit, 
#    (revenue-budget)*100/budget as profit_pct 
#   from financials;
   
SELECT 
            m.movie_id, title, budget, revenue, currency, unit 
	FROM movies m
	INNER JOIN financials f
	ON m.movie_id=f.movie_id;
    
SELECT 
            m.movie_id, title, budget, revenue, currency, unit 
	FROM movies m
	LEFT JOIN financials f
	ON m.movie_id=f.movie_id;

SELECT 
            m.movie_id, title, budget, revenue, currency, unit 
	FROM movies m
	RIGHT JOIN financials f
	ON m.movie_id=f.movie_id;
SELECT 
            m.movie_id, title, budget, revenue, currency, unit 
	FROM movies m
	LEFT JOIN financials f
	ON m.movie_id=f.movie_id

	UNION

SELECT 
		m.movie_id, title, budget, revenue, currency, unit 
	FROM movies m
	RIGHT JOIN financials f
	ON m.movie_id=f.movie_id;
Select 
	   movie_id, title, revenue 
	from movies m 
        right join financials f
	USING (movie_id);
    
select m.language_id, title, l.name 
	from movies m
		right join languages l
        on m.language_id=l.language_id
        
union
select m.language_id, title, l.name 
	from movies m
		left join languages l
        on m.language_id=l.language_id;
        
select title, l.name 
	from movies m
		right join languages l
        using(language_id)
        
union
select title, l.name 
	from movies m
		left join languages l
        using(language_id);
select title, l.name 
	from movies m
		right join languages l
        using(language_id)
                
union
select title, l.name 
	from movies m
		left join languages l
        using(language_id);
        
        
select title, l.name 
	from movies m
		right join languages l
        using(language_id)
        where l.name='Telugu'
        
union
select title, l.name 
	from movies m
		left join languages l
        using(language_id)
        where l.name='Telugu';
        
select l.name, count(l.name) as cnt
	from movies m
		left join languages l
        using(language_id)
        group by l.name
        order by cnt desc;
        
SELECT m.movie_id, title, budget, revenue, currency, unit,
CASE
WHEN unit='thousands' THEN (revenue-budget)/1000
WHEN unit='billions' THEN (revenue-budget)*1000
ELSE (revenue-budget)
END as profit_mln
FROM movies m
JOIN financials f ON m.movie_id = f.movie_id
WHERE industry='bollywood'
ORDER BY profit_mln DESC;      

select
	m.title, group_concat(a.name separator '| ') as actors
from movies m
join movie_actor ma on m.movie_id=ma.movie_id
join actors a on a.actor_id=ma.actor_id
group by m.movie_id;


select 
	a.name,
    group_concat(m.title separator ' | ') as shows,
    count(m.title) as no_of_movies
from actors a
join movie_actor ma on ma.actor_id = a.actor_id
join movies m on m.movie_id = ma.movie_id
group by a.actor_id
order by no_of_movies desc;