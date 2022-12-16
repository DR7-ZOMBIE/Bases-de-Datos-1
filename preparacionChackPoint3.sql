-- Checkpoint III: Integrador de SQL

-- Realizar los siguientes reportes:

-- 1. Generar un reporte que indique la cantidad de usuarios por país,
-- mostrando el nombre del país y su cantidad.

select count(*) as cantidaUsuarios , p.Nombre
from usuario u
inner join pais p on p.idPais = u.Pais_idPais
group by p.nombre; 

-- 2. Mostrar el Top 5 de avatars utilizados por los usuarios, listando el
-- nombre del avatar y la cantidad de veces utilizado.

select a.nombre, count(Avatar_idAvatar) as cantidadAvatar
from usuario u
inner join avatar a on a.idavatar = u.Avatar_idAvatar
group by a.nombre
order by cantidadAvatar desc
limit 5;

-- 3. Emitir un listado de todas las playlists públicas, informando el nombre
-- del usuario que la creó, el título de cada video que posee y el nombre
-- y año de creación de la playlist.

select p.privado as publico , u.nombre, v.titulo , p.nombre , p.fechaCreacion
from playlist p
inner join usuario u on u.idUsuario = p.Usuario_idUsuario
inner join playlist_video pv on pv.Playlist_idPlaylist = p.idPlaylist
inner join video v on v.idVideo = pv.Video_idVideo
having publico = 0;


-- 4. Listar las 10 etiquetas menos usadas.

select e.nombre,count(*) as cantidadEtiquetas 
from etiqueta e
inner join video_etiqueta ve on ve.Etiqueta_idEtiqueta = e.idEtiqueta
inner join video v on v.idVideo = ve.Video_idVideo
group by nombre
order by cantidadEtiquetas asc
limit 10;

-- 5. Generar un reporte de las últimas 10 reacciones, listando la fecha, el
-- nombre de la reacción, el id y nombre de usuario, y el título del video.

select r.fecha,tr.nombre,r.idReaccion,u.nombre,v.titulo
from reaccion r
inner join tiporeaccion tr on tr.idTipoReaccion = r.TipoReaccion_idTipoReaccion
inner join usuario u on u.idUsuario = r.Usuario_idUsuario
inner join video v on v.idVideo = r.Video_idVideo
order by r.fecha desc
limit 10;

-- 6. Mostrar por usuario la cantidad de playlists que posee, pero solo para
-- aquellos que tengan más de 1 playlist creada en el año 2021.

select idUsuario,count(*) as cantidadPlaylist, YEAR(fechaCreacion) as fecha
from playlist p
inner join usuario u on u.idUsuario = p.Usuario_idUsuario
group by idUsuario
having fecha = "2021" and cantidadPlaylist > 1;


-- 7. Generar un reporte de las reacciones generadas en el 2021, con el
-- siguiente formato :
-- Nombre de Reacción Nombre de Usuario Título de Video Fecha

select year(r.fecha) as fecha,tr.nombre,u.nombre,v.titulo
from reaccion r
inner join tiporeaccion tr on tr.idTipoReaccion = r.TipoReaccion_idTipoReaccion
inner join usuario u on u.idUsuario = r.Usuario_idUsuario
inner join video v on v.idVideo = r.Video_idVideo
having fecha = "2021";

-- 8. Listar la cantidad de videos según sean públicos o privados.

select
case
	when privado = 1 then "privado"
    when privado = 0 then "publico"
end as pripu,
count(idVideo)
from video
group by privado;


-- 9. Generar un reporte con los nombres de los usuario que no poseen
-- ninguna Playlist.

select u.nombre, p.nombre
from playlist p
right join usuario u on u.idUSuario = p.Usuario_idUsuario
where p.nombre is null;


-- 10.Listar todos los videos hayan o no recibido reacciones en el último
-- mes; indicar cuántas reacciones tuvieron y si han sido reproducidos o
-- no. El listado debe estar ordenado alfabéticamente por título del vídeo.

select titulo,count(*) as cantidadReacciones,cantidadReproducciones,
case
	when cantidadReproducciones > 0 then "reproducir"
    when cantidadReproducciones = 0 then "no reproducir"
end as rn
from reaccion r
inner join video v on v.idVideo = r.Video_idVideo
group by titulo
order by titulo asc;


-- 11. Generar un reporte con el nombre del usuario y el título de videos del
-- usuario que no pertenecen a ninguna playlist.

select u.nombre,v.titulo,idPlaylist
from playlist p
right join usuario u on u.idUsuario = p.Usuario_idUsuario
inner join video v on v.Usuario_idUsuario = u.idUsuario
group by u.nombre
having idPlaylist is null;

-- 12.Listar a todos los usuarios que no poseen ningún video.

select idUsuario,titulo
from video v
right join usuario u on u.idUsuario = v.Usuario_idUsuario
where titulo is null;


-- 13.Listar la cantidad total de reacciones por cada tipo de reacción, en el
-- período del 01-01-2021 al 01-04-2021

select idTipoReaccion,count(idReaccion) as cantidad,fecha
from reaccion r
inner join tiporeaccion tr on tr.idTipoReaccion = r.TipoReaccion_idTipoReaccion
where fecha BETWEEN '2021-01-01' AND '2021-04-01'
group by idTipoReaccion;


-- 14.Listar los videos que tienen los usuarios cuyo nombre contiene la letra
-- “a” y son del país Argentina.

select u.nombre,titulo,p.nombre
from video v
inner join usuario u on u.idUsuario = v.Usuario_idUsuario
inner join pais p on u.Pais_idPais = p.idPais
where p.nombre = "Argentina" and u.nombre like ("%a%");

-- 15.Generar un informe estilo ranking de avatars utilizados por país.

select idAvatar,p.nombre
from usuario u
inner join pais p on p.idPais = u.Pais_idPais
inner join avatar a on a.idAvatar = u.Avatar_idAvatar
group by p.nombre
order by idAvatar desc;


-- 16.Generar un reporte de todos los videos, mostrando los que poseen
-- reacciones y cuántas veces han sido reproducidos.

select titulo,idReaccion,cantidadReproducciones
from reaccion r
inner join video v on v.idVideo = r.Video_idVideo
group by titulo;

-- 17.Mostrar los 5 videos de menor duración, listando el título del vídeo y el
-- nombre de usuario y país al que corresponde.

select v.titulo,v.duracion
from usuario u
inner join pais p on p.idPais = u.Pais_idPais
inner join video v on v.Usuario_idUsuario = u.idUsuario
group by titulo
order by v.duracion asc
limit 5;

-- 18. Listar el usuario brasilero con más reacciones durante el 2021.

select u.nombre,count(*) as cantidad,YEAR(fecha) as anio, p.nombre
from reaccion r
inner join usuario u on u.idUsuario = r.Usuario_idUsuario
inner join pais p on p.idPais = u.Pais_idPais
group by u.nombre
having p.nombre = "Brasil" and anio = "2021"
order by cantidad desc
limit 1;

-- 19. Generar un reporte listando los usuarios, sus canales, playlists y los
-- videos que integran esas playlists.

select u.nombre,c.nombre,idPLaylist,v.titulo
from usuario u
left join playlist p on u.idUsuario = p.Usuario_idUsuario
left join canal c on c.Usuario_idUsuario = u.idUsuario
left join video v on v.Usuario_idUsuario = u.idUsuario
group by u.nombre;

-- 20. Listar todas las playlists que posean menos de 3 videos, mostrando el
-- nombre de usuario y el avatar que posee.

select u.nombre,idPlaylist,v.titulo, count(idVideo) as cantidadVideo
from usuario u
inner join playlist p on u.idUsuario = p.Usuario_idUsuario
inner join playlist_video pv on pv.Playlist_idPlaylist = p.idPLaylist
inner join video v on v.idVideo = pv.Video_idVideo
inner join avatar a on a.idAvatar = u.Avatar_idAvatar
group by idPLaylist
having cantidadVideo < 3;
