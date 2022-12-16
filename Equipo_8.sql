

select * from Categorias;FacturaID

select CategoriaNombre,Descripcion from Categorias;

select * from Productos;

select ProductoNombre,Discontinuado from Productos where Discontinuado = 1;

select ProductoNombre,ProveedoriD from Productos where ProveedoriD = 8;

select ProductoNombre,PrecioUnitario from Productos where PrecioUnitario between 10 AND 22;

select ProductoNombre,UnidadesStock,NivelReorden 
from Productos
where UnidadesStock < NivelReorden; 

select ProductoNombre,UnidadesStock,NivelReorden,UnidadesPedidas
from Productos
where UnidadesStock < NivelReorden AND UnidadesPedidas = 0;

 /*Obtener un listado de todos los clientes con Contacto, Compania, Título,
País. Ordenar el listado por País.*/

select Contacto, Compania, Titulo, Pais
from Clientes order by Pais;

/*Queremos conocer a todos los clientes que tengan un título “Owner”.*/

select Contacto,Titulo
from Clientes where Titulo = "Owner";

/*El operador telefónico que atendió a un cliente no recuerda su nombre.
Solo sabe que comienza con “C”. ¿Lo ayudamos a obtener un listado con
todos los contactos que inician con la letra “C”?*/

select Contacto 
from Clientes 
where Contacto 
like ("C%");

/*1. Obtener un listado de todas las facturas, ordenado por fecha de factura
ascendente.*/

select FechaFactura,NombreEnvio from Facturas order by FechaEnvio desc;

select FechaEnvio , ClienteID from Facturas where ClienteID = 'GOURL';

/*4. Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.*/
select FechaEnvio , EmpleadoID from Facturas where EmpleadoID in (2, 3, 5, 8, 9);

/* 1. Obtener el listado de todos los productos ordenados descendentemente por precio unitario. */
select PrecioUnitario  from productos order by PrecioUnitario desc;

/*2. Obtener el listado de top 5 de productos cuyo precio unitario es el más caro.*/
select PrecioUnitario from productos order by PrecioUnitario desc limit 5;

/*3. Obtener un top 10 de los productos con más unidades en stock.*/
select UnidadesStock from productos order by UnidadesStock desc limit 10;

/* 1. Obtener un listado de FacturaID, Producto, Cantidad. */
select FacturaID, ProductoID, Cantidad from facturadetalle;

/*2. Ordenar el listado anterior por cantidad descendentemente. */

select FacturaID, ProductoID, Cantidad from facturadetalle order by Cantidad desc;

/*3. Filtrar el listado solo para aquellos productos donde la cantidad se encuentre entre 50 y 100.*/

select FacturaID, ProductoID, Cantidad from facturadetalle where Cantidad between 50 and 100 order by Cantidad desc;

/*4. En otro listado nuevo, obtener un listado con los siguientesnombres de columnas: NroFactura (FacturaID), Producto(ProductoID), Total (PrecioUnitario*Cantidad). */

Alter table FacturaDetalle Add PrecioUnitarioCantidad int not null;

select FacturaID, ProductoID, Cantidad , PrecioUnitario, PrecioUnitarioCantidad 
from FacturaDetalle 
where PrecioUnitarioCantidad = Cantidad * PrecioUNitario;
