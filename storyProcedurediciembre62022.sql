use EMarket;

-- Consignas
-- 1) Empleados

-- a) Crear un SP que liste los apellidos y nombres de los empleados ordenados
-- alfabéticamente.

Delimiter $$
create procedure sp_apellido_Nombre_Alfabeticamente()
begin
		select apellido,nombre
        from Empleados
        order by apellido,nombre;
end $$

-- b) Invocar el SP para verificar el resultado.

call sp_apellido_Nombre_Alfabeticamente();

-- 2) Empleados por ciudad

-- a) Crear un SP que reciba el nombre de una ciudad y liste los empleados de esa
-- ciudad.

Delimiter $$
create procedure sp_ciudad_Empleados(in ciudadNombre  varchar(20))
begin
		select e.Nombre, e.apellido,e.ciudad
        from Empleados e
        where ciudad = ciudadNombre;
end $$

-- b) Invocar al SP para listar los empleados de Seattle.

call sp_ciudad_Empleados("Seattle");

-- 3) Clientes por país

-- a) Crear un SP que reciba el nombre de un país y devuelva la cantidad de clientes
-- en ese país.

Delimiter $$
create procedure sp_pais_CountCLientes(in paisIngresado  varchar(20))
begin
		select c.pais, count(*)
        from Clientes c
        where c.pais = paisIngresado
		group by c.pais;
end $$

-- b) Invocar el SP para consultar la cantidad de clientes en Portugal.

call sp_pais_CountCLientes("Portugal");

-- 4) Productos sin stock

-- a) Crear un SP que reciba un número y liste los productos cuyo stock está por
-- debajo de ese número. El resultado debe mostrar el nombre del producto, el
-- stock actual y el nombre de la categoría a la que pertenece el producto.

Delimiter $$
create procedure sp_numero_ListeProductos_Stock(in cantidad int)
begin
		select p.ProductoNombre,p.UnidadesStock,c.CategoriaNombre
        from Productos p
        inner join Categorias c on c.CategoriaID = p.CategoriaID
        where p.UnidadesStock < cantidad;

end $$

-- b) Listar los productos con menos de 10 unidades en stock.

call sp_numero_ListeProductos_Stock(10);

-- c) Listar los productos sin stock.

call sp_numero_ListeProductos_Stock(1);

-- 5) Ventas con descuento

-- a) Crear un SP que reciba un porcentaje y liste los nombres de los productos que
-- hayan sido vendidos con un descuento igual o superior al valor indicado,
-- indicando además el nombre del cliente al que se lo vendió.

Delimiter $$
create procedure sp_porcentaje_NombreProductos_NombreCliente(in numero double)
begin
		select p.ProductoNombre, CONCAT(ROUND((p.PrecioUnitario / p.CantidadPorUnidad * 100), 2), '%') as descuento
        from Productos p
        where p.descuento >= numero
        group by p.ProductoNombre;
end $$

select @total := (SELECT SUM(CantidadPorUnidad) FROM Productos);
select @cantidad = CONCAT(ROUND((CantidadPorUnidad/ @total * 100), 2), '%');

-- b) Listar la información de los productos que hayan sido vendidos con un
-- descuento mayor al 10%.

call sp_porcentaje_NombreProductos_NombreCliente(@cantidad);
