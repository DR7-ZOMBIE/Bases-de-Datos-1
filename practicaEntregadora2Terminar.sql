use `dh-noticias`;


select id as "Numero de autor",nombre,apellido from autores where nombre like ("a%");

select nombre,apellido,password from autores where telefono_movil like ("5492645661478");

select estadoart,count(id) as "cantidad articulos" from articulos where estadoart = 0;

select id,nombre_recurso,ruta from recursos where id in (8,16,29,35);

select id,fechapublicacion,titulo from articulos where id = 1; 

select nombre_recurso,ruta,TiposRecursos
from recursos
inner join tiposrecursos on tiposrecursos.id = recursos.tiposrecursos_id
where TiposRecursos = "Audio";

select usuario.nombre,date_format(fecha_nacimiento , "%d %m %Y") ,ciudad.nombre
from usuario
inner join ciudad on ciudad.id = usuario.ciudad_id
where ciudad.nombre != "Las Condes-Santiago"
and (date_format(fecha_nacimiento , "%d %m %Y")>"3/9/1989" 
or date_format(fecha_nacimiento , "%d %m %Y")="7/11/1986") 
order by fecha_nacimiento asc;

select titulo,date_format(fechalta , "%d %m %Y") as fecha_real ,nombre_subcat
from articulos
inner join subcategorias on subcategorias.id = articulos.subcategorias_id
having (fecha_real>"5/09/2021" or fecha_real="25/06/2021")
order by fecha_real desc;

select Cometario, DATE_FORMAT(Fecha, "%m") as fecha_Nueva, Fecha
from comentarios
having Cometario like "%Gracias%"
and fecha_Nueva=10;

select titulo,contenido,nombre,fechapublicacion
from articulos
inner join autores on autores.id = articulos.autores_id
having nombre="Guillermina Lucia"
order by fechapublicacion desc;

select Cometario,Fecha
from comentarios
having Fecha between "2021/07/14" and "2021/08/15"
order by Fecha asc;

select nombre,apellido,telefono_movil
from autores
where nombre like "%ia";

select count(id) as "Cantidad Articulos", date_format(fechapublicacion , "%Y") as Fecha
from articulos
group by Fecha
having Fecha="2021";

select id,date_format(fechapublicacion , "%Y") as Fecha, fechapublicacion
from articulos
having Fecha="2022"
and id = 64
order by fechapublicacion asc;


/*15. La fecha de publicación del primer post que se realizó en DH-Noticias fue el
"2019-03-03" , lo que necesitamos calcular es cuantos días transcurrieron hasta
el día de hoy.*/

select (max(fechapublicacion)-min(fechapublicacion)) as result
from articulos;

/*16. Mostrar todas las ciudades que contengan una palabra de cinco caracteres, pero
el tercer carácter debe ser igual a "n".*/

select nombre
from ciudad 
where nombre like "__%n%__";


/*17. Modificar el tipo de categoría "Cultura y Arte" a solo "Cultura".*/

select nombre_categoria
from categorias
where nombre_categoria like "Cultura y Arte";

/*18. Listar el nombre de todas las categorías inactivas (el estado de la categoría es
igual a cero) en nuestro blog*/

select nombre_categoria,estado_categoria 
from categorias 
where estado_categoria = 0;

/*19. Agregar al usuario Aznar Ricardo Omar cuyo usuario es rica28, contraseña
az123, proveniente de la ciudad de 'Las Heras - Mendoza’, fecha de nacimiento
5/1/1980, teléfono móvil +542645667714 y el correo electrónico es
pal1980sj@gmail.com.*/

-- Hacer un insert aca 

/*20. Eliminar el registro de la categoría número ocho*/

-- Hacer un delete aca




