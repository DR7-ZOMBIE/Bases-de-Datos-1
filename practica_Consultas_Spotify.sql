insert into `pais`(idpais,nombre_Pais) 
values (default,"Argentina"),
		(default,"Colombia");

insert into usuario()
values (default,"dcr@jinhk","hjgsd","2002-10-10","Masculino","sp303","Argentina","2004-10-10",1),
		(default,"dcr@jinhk","hjgsd","2002-10-10","Masculino","sp303","Argentina","2004-10-10",2),
        (default,"dcr@jinhk","hjgsd","2002-10-10","Masculino","sp303","Argentina","2004-10-10",3);

select * from usuario;

delete from usuario where idusuario >=2;
 
update usuario set password="sdijs" where idusuario=1; 












