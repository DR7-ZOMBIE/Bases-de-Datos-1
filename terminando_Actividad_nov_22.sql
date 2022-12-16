USE EMarket;

-- Crear una vista con los siguientes datos de los clientes: ID, contacto, y el
-- Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por
-- ejemplo: “TEL: (01) 123-4567”.

Create view V_Clientes as
Select ClienteID,Contacto,Fax,
Case
	when (Fax is null ) or (Fax = '') then '(01) 123-4567'
    when (Fax is not null) then telefono
End as FaxNuevo
from Clientes;

select * from V_Clientes;

-- 2. Se necesita listar los números de teléfono de los clientes que no tengan
-- fax. Hacerlo de dos formas distintas:
-- a. Consultando la tabla de clientes.
-- b. Consultando la vista de clientes.

select ClienteID,telefono, fax
from Clientes c 
where fax is null or fax = '';

select ClienteID,Contacto,FaxNuevo
from V_Clientes
where FaxNuevo = '(01) 123-4567';


-- Proveedores

-- 1. Crear una vista con los siguientes datos de los proveedores: ID,
-- contacto, compañía y dirección. Para la dirección tomar la dirección,
-- ciudad, código postal y país.

Create view VistaProveedores as 
select ProveedorID,Contacto,Compania, concat_ws(",",Direccion,Ciudad,CodigoPostal,Pais) as Direccion
from Proveedores;

drop view VistaProveedores;

select * from VistaProveedores;

-- 2. Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo
-- de dos formas distintas:
-- a. Consultando la tabla de proveedores.
-- b. Consultando la vista de proveedores.
-- Vistas - Parte II

select ProveedorID,left(Direccion , Locate(',',Direccion )-1) as Calle
from VistaProveedores
where Direccion like "%Brazil%" and Direccion like "%Americanas%";

-- 1. Crear una vista de productos que se usará para control de stock. Incluir el ID
-- y nombre del producto, el precio unitario redondeado sin decimales, las
-- unidades en stock y las unidades pedidas. Incluir además una nueva
-- columna PRIORIDAD con los siguientes valores:
-- ■ BAJA: si las unidades pedidas son cero.
-- ■ MEDIA: si las unidades pedidas son menores que las unidades
-- en stock.
-- ■ URGENTE: si las unidades pedidas no duplican el número de
-- unidades.
-- ■ SUPER URGENTE: si las unidades pedidas duplican el número
-- de unidades en caso contrario.

create view vista_Productos as 
select ProductoID,
ProductoNombre,
round(PrecioUnitario,0) as precioUnitarioSinDecimal,
UnidadesStock,UnidadesPedidas,
case
	when UnidadesPedidas = 0 then 'Baja'
    when UnidadesPedidas < UnidadesStock then 'Media'
    when UnidadesPedidas < 2*UnidadesStock then 'Urgente'
    when UnidadesPedidas > 2*UnidadesStock then 'Super Urgente'
end as Prioridad
from Productos;

select * from vista_Productos;

-- 2. Se necesita un reporte de productos para identificar problemas de stock.
-- Para cada prioridad indicar cuántos productos hay y su precio promedio.
-- No incluir las prioridades para las que haya menos de 5 productos.

select Prioridad,UnidadesStock, count(*) as cantidadProductos , avg(precioUnitarioSinDecimal)
from vista_Productos
group by ProductoID
having UnidadesStock >=5;
