-- SELECT * FROM moviesdb.movies;

-- select title from moviesdb.movies;

use moviesdb;

-- select title, industry from movies;

-- select * from movies where industry='bollywood';

-- select count(*) from movies where industry='bollywood';

-- select distinct industry from movies;

-- wildcard serach
-- select * from movies where title like '%thor%';

-- handling missing data
select * from movies where studio='';