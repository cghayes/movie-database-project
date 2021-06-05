-- Join with set operator (Calley)
-- Shows the movie name, runtime, and format type for all BluRay movies with runtime over 100 minutes
SELECT moviename,
runtime,
formattype
FROM movie m LEFT JOIN movie_format mf
ON m.movieid = mf.movieid
JOIN format f
ON mf.formatid = f.formatid
WHERE formattype = 'Blu Ray'
EXCEPT
SELECT moviename,
runtime,
formattype
FROM movie m JOIN movie_format mf
ON m.movieid = mf.movieid
JOIN format f
ON mf.formatid = f.formatid
WHERE runtime <= 100
ORDER BY runtime;
---------------------------------------------

-- Subquery (Calley)
-- Shows first and last names of actors and the name of movies with the genreID of 1000 (comedy)
SELECT firstname,
lastname,
m.moviename
FROM person p JOIN movie_person mp
ON p.personid = mp.personid
JOIN movie_genre mg
ON mp.movieid = mg.movieid
JOIN movie m
ON mg.movieid = m.movieid
WHERE mg.genreid IN
(SELECT genreid
FROM movie_genre
WHERE genreid = '1000')
ORDER BY moviename;