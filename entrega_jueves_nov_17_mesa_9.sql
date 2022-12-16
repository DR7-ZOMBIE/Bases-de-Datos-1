use musimundos;

-- n1. Listar las canciones cuya duración sea mayor a 2 minutos.

select milisegundos 
from canciones 
where milisegundos > 120000;


-- 2. Listar las canciones cuyo nombre comience con una vocal.

select c.nombre 
from canciones c
where c.nombre in ('a%','e%','i%','o%','i%');

select nombre from canciones where nombre LIKE "A%" OR nombre LIKE "E%" OR nombre LIKE "I%" OR nombre LIKE "O%" OR nombre LIKE "U%"; 

-- 3. Listar las canciones ordenadas por compositor en forma descendente.
-- Luego, por nombre en forma ascendente. Incluir únicamente aquellas
-- canciones que tengan compositor.

select id,compositor,nombre
from canciones
group by id
having compositor != ""
order by compositor and nombre;



-- 4. a) Listar la cantidad de canciones de cada compositor.
-- b) Modificar la consulta para incluir únicamente los compositores que
-- tengan más de 10 canciones.

select count(*) as cantidadCanciones,compositor
from canciones
group by compositor
having cantidadCanciones > 10;

-- 5. a) Listar el total facturado agrupado por ciudad.
-- b) Modificar el listado del punto (a) mostrando únicamente las ciudades
-- de Canadá.
-- c) Modificar el listado del punto (a) mostrando únicamente las ciudades
-- con una facturación mayor a 38.
-- d) Modificar el listado del punto (a) agrupando la facturación por país, y
-- luego por ciudad.

select sum(total) as total, ciudad_de_facturacion
from facturas
group by ciudad_de_facturacion;

select sum(total) as total, ciudad_de_facturacion as cn
from facturas
group by cn
having cn in ('Toronto','Vancouver','Motreal','Victoria','Quebec');

select sum(total) as total, ciudad_de_facturacion
from facturas
group by ciudad_de_facturacion
having total > 38;

select sum(total) as total, pais_de_facturacion as pf
from facturas
group by pf
having total > 38;

-- 6. a) Listar la duración mínima, máxima y promedio de las canciones.
-- b) Modificar el punto (a) mostrando la información agrupada por género.

select min(milisegundos/60000),max(milisegundos/60000), avg(milisegundos)/60000 
from canciones;

select id_genero,g.nombre,min(milisegundos/60000),max(milisegundos/60000), avg(milisegundos)/60000 
from canciones c
inner join generos g on g.id = c.id_genero
group by id_genero;



