
-- CAMADA: 0822TDFE1N2C2LAED0822PT
-- GRUPO 01 
-- INTEGRANTES: 
/*				* Dennis Patrick Juilland Prada
				* Agustin Rios
				* Leidy Hernandez
                * Pablo Ambrogio
*/

USE `dh-noticias`;

-- 1. Listar todos los autores que tengan más de diez artículos en nuestra base de
-- datos. Mostrar apellido, nombre y la cantidad de artículos que posee.

select nombre,apellido, count(a.id) as cantidadArticulos
from articulos a 
inner join autores ar on ar.id = a.autores_id
group by ar.id
having cantidadArticulos > 10;

-- DEVUELVE 4 REGISTROS

-- 2. Listar todos los autores que no tengan artículos publicados en el blog. Mostrar
-- apellido y nombre en mayúsculas dentro de una misma columna denominada
-- "Autor sin publicación".

select concat_ws(",",upper(nombre),upper(apellido)) as "Autor sun publicacion",a.fechapublicacion
from articulos a 
right join autores ar on ar.id = a.autores_id
where a.fechapublicacion is null;

-- DEVUELVE 29 REGISTROS

-- 3. Listar todos los autores que tengan al menos una publicación y que tengan
-- como origen el país Chile. Se debe mostrar el apellido, nombre, título del
-- artículo, fecha de la publicación del artículo, nombre de la ciudad y país.

select ar.id ID,ar.nombre Nombre,ar.apellido Apellido,a.titulo Título,a.fechapublicacion Fecha_publicacion,c.nombre AS Ciudad, p.nombre as Pais
from articulos a
inner join autores ar on ar.id = a.autores_id
inner join ciudad c on c.id = ar.ciudad_id
inner join pais p on p.id = c.pais_id
where p.nombre = "Chile" and a.fechapublicacion is not null;

-- DEVUELVE 24 REGISTROS

-- 4. Listar los autores que tengan uno o más artículos que no se encuentren
-- publicados es decir que el estado es igual a cero y que en la segunda letra de
-- su apellido contenga una "a".
select ar.nombre Nombre, ar.apellido Apellido, count(a.id) as cantidadArticulos, a.estadoart Estado_art
from articulos a
inner join autores ar on ar.id = a.autores_id
group by ar.id
having ar.apellido like ("_a%") and a.estadoart = 0;

-- DEVUELVE 2 REGISTROS

-- 5. Listar absolutamente todos los países y la cantidad de autores que tengan.

select p.nombre,count(*) as cantidadAutores
from autores a
inner join ciudad c on c.id = a.ciudad_id
inner join pais p on p.id = c.pais_id
group by p.nombre;

-- DEVUELVE 4 REGISTROS

/*6. Queremos conocer los comentarios que contengan la palabra "muy bueno”, se
pide el nombre y apellido del usuario, título del artículo, el comentario y la
fecha de publicación del comentario.*/

select us.nombre, us.apellido, ar.titulo, co.fecha, co.Cometario
from comentarios co
inner join articulos ar on ar.id = co.articulos_id
inner join usuario us on us.id = co.usuario_id
where co.Cometario like ("%muy bueno%");

-- DEVUELVE 3 REGISTROS

/*7. Se necesita conocer todas las especialidades del autor Martin Guillermina
Lucia.*/
select a.nombre, a.apellido, es.nombre as especialidadNombre, es.id
from especialidad_x_autores exa
inner join autores a on a.id = exa.autores_id
inner join especialidad es on es.id = exa.especialidad_id
having a.nombre like ("%Guillermina%") and a.apellido like ("%Martin%");

-- DEVUELVE 4 REGISTROS

/*8. Calcular la cantidad de autores por país que no tengan asignada una
especialidad. Para este informe mostrar el nombre del país y la cantidad.
Base de datos I - CheckPoint III - Pág. 1*/

select count(a.id) as cantidadAutores, pa.nombre as paisNombre , es.nombre as especialidadNombre
from autores a
left join especialidad_x_autores exa on a.id = exa.autores_id
left join especialidad es on es.id = exa.especialidad_id
left join ciudad ci on ci.id = a.ciudad_id
left join pais pa on pa.id = ci.pais_id
group by pa.nombre
having especialidadNombre is null;

-- DEVUELVE 1 REGISTROS

/*9. Se desea conocer el tercer autor que tenga más artículos publicados, el estado
del mismo debe ser uno. Mostrar el nombre y apellido del autor, ciudad, país,
estado de la publicación y la cantidad.*/

select count(ar.id) as cantArticulos,au.nombre, au.apellido, ci.nombre as NombreCiudad, ar.estadoart as estadoArticulo, pa.nombre as paisNombre
from autores au
inner join articulos ar on ar.autores_id = au.id
inner join ciudad ci on au.ciudad_id = ci.id
inner join pais pa on pa.id = ci.pais_id
group by au.nombre
having estadoArticulo = "1"
order by cantArticulos desc
limit 1
offset 2;

-- DEVUELVE 1 REGISTROS

/*10. Calcular la cantidad de artículos por categoría inactiva (estado es igual a cero).
Mostrar el nombre de la categoría y la cantidad.*/

select count(ar.id) as cantArticulos, ca.nombre_categoria, count(ca.id) as cantidadCategoria, ca.estado_categoria
from articulos ar
inner join subcategorias sub on sub.id = ar.subcategorias_id 
inner join categorias ca on ca.id = sub.categorias_id
group by ca.nombre_categoria
having ca.estado_categoria = "0";

-- DEVUELVE 2 REGISTROS

-- 11. Listar todos los autores según la cantidad de artículos publicados, los
-- mensajes serán los siguientes:
-- ▪ "tiene solo un artículo publicado"
-- ▪ "tiene dos artículos publicados"
-- ▪ "tiene más de dos artículos publicados"
-- ▪ "no publicó ningún artículo"
-- Mostrar el nombre y apellido del autor, y el mensaje que corresponda.

select ar.nombre,ar.apellido,count(a.id) as cantidadArticulos,
case
	when count(a.id) = 1 then  "tiene solo un artículo publicado"
    when count(a.id) = 2 then  "tiene dos artículos publicados"
    when count(a.id) > 2 then  "tiene más de dos artículos publicados"
    else "no publicó ningún artículo"
end as cantidadArticulos
from articulos a
inner join autores ar on ar.id = a.autores_id
group by ar.id;

-- DEVUELVE 21 REGISTROS

-- 12. Calcular la cantidad de recursos utilizados en los artículos publicados (estado
-- igual a uno) en el año 2022.

select count(*) as cantidadRecursos , a.estadoart , year(fechaPublicacion) as anio
from recursos r
inner join articulos a on a.id = r.articulos_id
where a.estadoart = 1
group by anio
having anio = "2022" ;

-- DEVUELVE 1 REGISTROS

-- 13. Listar los autores que tengan solo asignadas 3 especialidades.

select a.id, a.nombre,a.apellido,count(e.id) as cantidadEspecialidad
from autores a
inner join especialidad_x_autores ea on ea.autores_id = a.id
inner join especialidad e on e.id = ea.especialidad_id
group by a.id
having cantidadEspecialidad = 3; 

-- DEVUELVE 3 REGISTROS

-- 14. Calcular la cantidad de artículos de cada uno de los autores que no fueron
-- publicados, para este informe necesitamos mostrar el usuario, correo
-- electrónico, país y estado del artículo y la cantidad.

select ar.usuario,ar.email,count(*) as cantidadArticulos , p.nombre , a.estadoart
from articulos a
inner join autores ar on ar.id = a.autores_id
inner join ciudad c on c.id = ar.ciudad_id
inner join pais p on p.id = c.pais_id
where a.estadoart = 0
group by ar.id;

-- DEVUELVE 3 REGISTROS

-- 15. Listar todos los usuarios categorizados por edad. Las categorías son: 'junior'
-- (hasta 35 años), 'semi-senior' (entre 36 a 40 años) y 'senior' (más de 40).
-- Mostrar el apellido, nombre, edad, categoría y ordenar de mayor a menor por
-- categoría y edad.

SELECT u.nombre,u.apellido,  left(datediff(NOW(),fecha_nacimiento)/365 , 2) as edad,
 CASE 
	WHEN  left(datediff(NOW(),fecha_nacimiento)/365 , 2) <= 35 THEN 'Junior' 
    WHEN  left(datediff(NOW(),fecha_nacimiento)/365 , 2) > 35 AND  left(datediff(NOW(),fecha_nacimiento)/365 , 2) <= 40 THEN 'semi-senior' 
    ELSE 'senior' 
END AS Categoria 
FROM usuario u
order by edad desc, Categoria desc;

-- DEVUELVE 26 REGISTROS

/*
16. Listar de manera ordenada, los usuarios que no pertenezcan a la ciudad
"Monroe - Buenos Aires" y que la fecha de alta del comentario se halle dentro
del rango 2019 al 2020. Mostrar el email del usuario, comentario realizado y el
nombre de la ciudad. Ordenar por fecha del comentario.
*/
SELECT U.email Email, CO.Cometario Comentario, C.nombre Ciudad, CO.Fecha
FROM usuario U
INNER JOIN ciudad C
ON U.ciudad_id = C.id
INNER JOIN comentarios CO
ON U.id = CO.usuario_id
WHERE C.nombre != "Monroe - Buenos Aires" AND YEAR(CO.fecha) BETWEEN 2019 AND 2020
ORDER BY CO.Fecha;

-- DEVUELVE 5 REGISTROS

/*
17. Calcular la cantidad de comentarios que realizaron los usuarios. Solo mostrar
los cinco primeros, como también el nombre, el apellido y país del usuario.
*/

SELECT U.nombre Nombre_usuario, U.apellido Apellido_usuario, P.nombre Pais, COUNT( CO.id ) Cantidad_comentarios
FROM comentarios CO
INNER JOIN usuario U 
ON CO.usuario_id = U.id
INNER JOIN ciudad C
ON U.ciudad_id = C.id 
INNER JOIN pais P
ON C.pais_id = P.id
GROUP BY U.nombre;

-- DEVUELVE 21 REGISTROS

/*
18. Listar los recursos del tipo audio y que tengan formato MP3 que fueron
utilizados por los artículos con fecha de alta en el mes de octubre. Para este
informe mostrar el título y fecha de alta del artículo, la ruta del recurso y la
subcategoría.
*/

SELECT AR.titulo Título, AR.fechalta Fecha_alta, R.ruta Ruta_recurso, SUB.nombre_subcat Nombre_subcategoria 
FROM recursos R
INNER JOIN articulos AR 
ON R.articulos_id = AR.autores_id
INNER JOIN tiposrecursos TP 
ON R.tiposrecursos_id = TP.id
INNER JOIN subcategorias SUB 
ON SUB.id = AR.subcategorias_id
WHERE TP.TiposRecursos = 'Audio' AND MONTH(AR.fechalta) = 10 ;

-- DEVUELVE 6 REGISTROS

/*
19. Listar todos los comentarios realizados por los usuarios que tengan entre 36 y
40 años. Mostrar nombre y apellido del usuario, ciudad, país y el comentario
del mismo.
*/

SELECT U.nombre Nombre_usuario, U.apellido Apellido_usuario, C.nombre Ciudad, PA.nombre Pais, CO.Cometario,
CASE 
	WHEN LEFT( DATEDIFF( NOW(), U.fecha_nacimiento )/365 , 2 ) > 35 AND LEFT( DATEDIFF( NOW(), U.fecha_nacimiento )/365 , 2) < 41 THEN true
    END AS FechaCASE
FROM comentarios CO 
INNER JOIN usuario U 
ON CO.usuario_id = U.id
INNER JOIN ciudad C 
ON U.ciudad_id = C.id 
INNER JOIN pais PA 
ON C.pais_id = PA.id
GROUP BY U.fecha_nacimiento
HAVING FechaCASE = true;

-- DEVUELVE 6 REGISTROS
/*
20. Listar de manera ordenada y ascendente por fecha de nacimiento, el nombre ,
apellido , ciudad de los usuarios y que la fecha de nacimiento sea mayor que
1989-02-12 o igual a 1979-12-17
*/

SELECT U.nombre Nombre_usuario, U.apellido Apellido_usuario, C.nombre Ciudad, U.fecha_nacimiento
FROM usuario U 
INNER JOIN ciudad C 
ON U.ciudad_id = C.id
WHERE U.fecha_nacimiento > '1989-02-12' OR U.fecha_nacimiento < '1979-12-17'
ORDER BY U.fecha_nacimiento;

-- DEVUELVE 11 REGISTROS
