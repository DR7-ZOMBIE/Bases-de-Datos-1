use EMarket;

-- Reportes parte I - Repasamos INNER JOIN
-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- ● Id de la factura
-- ● fecha de la factura
-- ● nombre de la empresa de correo
-- ● nombre del cliente
-- ● categoría del producto vendido
-- ● nombre del producto
-- ● precio unitario
-- ● cantidad

select FD.FacturaID,F.FechaFactura,F.EnvioVia,C.ClienteID,CategoriaID,ProductoNombre,FD.PrecioUnitario,Cantidad
from FacturaDetalle FD
inner join Facturas F on FD.FacturaID = F.FacturaID
inner join Productos P on P.ProductoID = FD.ProductoID
inner join Clientes C on C.ClienteID = F.ClienteID;

-- Reportes parte II - INNER, LEFT Y RIGHT JOIN

-- 1. Listar todas las categorías junto con información de sus productos. Incluir todas
-- las categorías aunque no tengan productos.

select *
from Productos P
right join Categorias C on C.CategoriaID = P.CategoriaID;

-- 2. Listar la información de contacto de los clientes que no hayan comprado nunca
-- en emarket.

select c.Contacto , f.FacturaID
from Facturas f
left outer join Clientes c on c.ClienteID = f.ClienteID;

-- 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
-- la información de contacto de su proveedor. Tener en cuenta que puede haber
-- productos para los cuales no se indicó quién es el proveedor.

select ProductoNombre,CategoriaNombre, Contacto
from Productos P
inner join Categorias C on C.CategoriaID = P.CategoriaID
left join Proveedores PV on PV.ProveedorID = P.ProveedorID;

-- 4. Para cada categoría listar el promedio del precio unitario de sus productos.

select  f.ProductoID, avg(f.PrecioUnitario) as promedio
from FacturaDetalle f
inner join Productos p on p.ProductoID = f.ProductoID
inner join Categorias c on c.CategoriaID = p.CategoriaID
group by ProductoID;

-- 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
-- nunca hayan comprado en e-market.

select distinct c.Contacto , f.FacturaID , FechaFactura
from Facturas f
left outer join Clientes c on c.ClienteID = f.ClienteID
group by f.FacturaID
order by FechaFactura desc;


-- 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
-- listado con todas las empresas de correo, y la cantidad de facturas
-- correspondientes. Realizar la consulta utilizando RIGHT JOIN.

select f.EnvioVia  , count(*) as cantidadFacturas
from Facturas f
right join Correos c on c.CorreoID = f.EnvioVia
group by EnvioVia;