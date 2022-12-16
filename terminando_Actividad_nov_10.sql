use spotify;

select titulo from cancion where titulo like ("%z%");

select titulo from cancion where titulo like ("_a%s");

select cantcanciones as "Cantidad Canciones" from playlist order by cantcanciones desc;

select fecha_nac from usuario order by fecha_nac desc limit 10 offset 5;

select titulo,cantreproduccion from cancion order by cantreproduccion desc limit 5;

select titulo from album order by titulo;

select titulo,imagenportada from album where imagenportada = NULL order by titulo;

insert into usuario (idUsuario,nyap,nombreusuario,password,fecha_nac,sexo,CP,Pais_idPais)
values (default,"Elmer Gomez","nuevousuariodespotify@gmail.com", "S4321m", "15/11/1991" , 'M' , "B4129ATF" , 1);

delete from cancion where titulo = "pop";







