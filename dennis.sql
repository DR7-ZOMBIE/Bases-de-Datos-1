use movies_db;


select count(*) from movies;

select count(*) from movies group by awards having count(awards) between 3 and 7;

select count(awards) from movies where rating > 7 group by awards having count(awards) between 3 and 7;

select genre_id,count(length) from movies group by genre_id;

select genre_id,count(length),sum(awards) from movies group by genre_id having sum(awards) > 5;

select movies.id,title,genre_id,genres.id,name
from movies , genres
where genre_id = genres.id;

select title,first_name,last_name
from movies,actor_movie,actors 
where movie_id = movies.id and actor_id = actors.id;

select * 
from movies
inner join genres on genre_id = genres.id;

/*Inner join nos junta las dos tablas*/

/*Left join acepta el de la izquierda aun que la derecha no tenga nada*/

/*Right join acepta la trabla de la derecha aunque la izquierda no lo acepte*/

select title,first_name,last_name
from movies
inner join actor_movie on movie_id = movies.id
inner join actors on actor_id = actors.id;

select distinct first_name,last_name
from movies
inner join actor_movie on movie_id = movies.id
inner join actors on actor_id = actors.id
where title like ("Harry%");

/* Si hay filas repetidas debemos usar la palabra reservada distinc en la consulta*/

select concat(first_name," " ,last_name) as nombre_Completo
from actors;

/* Concat pega dos columnas er una sola*/

select title,coalesce(name,"No tiene genero")
from movies
left join genres on genres.id = movies.genre_id;

/* coalesce lo que hace si encuentra un null es agregarle un valor para que 
lo veamos mas formal*/

select title, datediff( now() , release_date )
from movies;

/* datediff con now nos trae la diferencia de fecha hasta la fecha actual*/

select title, extract(day from release_date)
from movies;

/* Extract para estraer un dato en especifico de un conjunto de datos*/

select title, date_format(release_date, "%d/%m/%Y")
from movies;

/* Date fromat cambia el formato de la fecha*/

select replace(title, "Harry" , "Pendejo")
from movies;

/* CAmbia un texto por algo dentro de una columna */ 

select Length(title)
from  movies;

/* No da el tamano de un texto */ 

select title
from movies
where length(title) > 5;

/*Otro uso del length*/

select title,rating,
case 
	when rating < 5 then "Mala"
    when rating > 5 then "Buena"
    else "Muy buena"
end
from movies;

/* Un switch case dentro de mysql esta muy util*/

select title,name
from series
inner join genres on genres.id = series.genre_id;

select title,first_name,last_name
from episodes
inner join actor_episode on episodes.id = actor_episode.episode_id
inner join actors on actors.id = actor_episode.actor_id;


/*Para nuestro próximo desafío, necesitamos obtener a todos los actores o
actrices (mostrar nombre y apellido) que han trabajado en cualquier película
de la saga de La Guerra de las galaxias.*/



select first_name,last_name,title
from actors
inner join actor_movie on actors.id = actor_movie.actor_id
inner join movies on movies.id = actor_movie.movie_id
where title like ("La Guerra de las galaxias%");


select name,count(length)
from movies
inner join genres on genres.id = movies.genre_id
group by(name);














