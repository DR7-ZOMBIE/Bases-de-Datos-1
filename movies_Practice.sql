use musimundos;

select pais,count(id) from clientes group by pais;

select count(id_genero) from canciones where id_genero = 6 group by id_genero ;

select sum(total) from facturas;

select avg(milisegundos) from canciones group by id_album;

select sum(bytes) from canciones group by bytes having sum(bytes) order by bytes;

select sum(total) from facturas where id_cliente = 6 group by id_cliente ;

select compositor,generos.nombre
from canciones,generos
where generos.id = canciones.id_genero and
compositor = "Willie Dixon"
and generos.nombre = "Blues";




