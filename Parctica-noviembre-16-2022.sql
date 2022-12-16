use EMarket;

-- Clientes:

-- 1) ¿Cuántos clientes existen?

select count(*) as cantidadClientes
from Clientes;

-- 2) ¿Cuántos clientes hay por ciudad?

select ciudad,count(*) as cantidadClientes
from Clientes
group by ciudad;

-- Facturas:

-- 1) ¿Cuál es el total de transporte?

select sum(Transporte) as totalTransporte
from Facturas;

-- 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

select EnvioVia,sum(Transporte) as totalTransporte 
from Facturas
group by EnvioVia;

-- 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
-- cantidad de facturas.

select ClienteID,count(*) as cantidadFacturas
from Facturas
group by CLienteID;

-- 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

select ClienteID,count(*) as cantidadFacturas
from Facturas
group by CLienteID
order by cantidadFacturas desc
limit 5;

-- 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

select PaisEnvio,count(*) as cantidadFacturas
from Facturas
group by PaisEnvio
order by cantidadFacturas asc
limit 1;


-- 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
-- realizó más operaciones de ventas?

select EmpleadoID, count(*) as cantidadFacturas
from Facturas
group by EmpleadoID
order by EmpleadoID
limit 1;

-- Factura detalle:

-- 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

select ProductoID, count(*) as facturaDetalle
from FacturaDetalle
group by ProductoID
order by FacturaDetalle desc
limit 1;


-- 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
-- cantidad por precio unitario.

select sum(PrecioUnitario*Cantidad)  as totalFacturado
from FacturaDetalle;

-- 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?


select ProductoID,sum(PrecioUnitario*Cantidad)  as totalFacturado
from FacturaDetalle
group by ProductoID
having ProductoID between 30 and 50;

-- 4) ¿Cuál es el precio unitario promedio de cada producto?

select ProductoID,avg(PrecioUnitario) as precioPromedio
from FacturaDetalle
group by ProductoID;

-- 5) ¿Cuál es el precio unitario máximo?

select ProductoID,max(PrecioUnitario) as maximo
from FacturaDetalle
group by ProductoID
order by maximo desc
limit 1;


-- 1) Generar un listado de todas las facturas del empleado 'Buchanan'.

select Facturas.* , apellido 
from Facturas
inner join Empleados on Empleados.EmpleadoID = Facturas.EmpleadoID
having apellido like 'Buchanan'; 

-- 2) Generar un listado con todos los campos de las facturas del correo 'Speedy
-- Express'.

select Facturas.* , Compania
from Facturas
inner join Correos on Correos.CorreoID = EnvioVia
having Compania like 'Speedy Express';


-- 3) Generar un listado de todas las facturas con el nombre y apellido de los
-- empleados.

select FacturaID , Empleados.nombre , Empleados.apellido
from Facturas
inner join Empleados on Empleados.EmpleadoID = Facturas.EmpleadoID;

-- 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío
-- “USA”.

select FacturaID, Titulo , PaisEnvio
from Facturas
inner join Clientes on Clientes.ClienteID = Facturas.ClienteID
having Titulo like 'Owner' 
and PaisEnvio = 'USA';


-- 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” o que incluyan el producto id = “42”.

select Facturas.*,Empleados.apellido as AP , ProductoID
from Facturas
inner join FacturaDetalle on Facturas.FacturaID = FacturaDetalle.FacturaID
inner join Empleados on Empleados.EmpleadoID = Facturas.EmpleadoID
having AP like 'Leverling' and ProductoID = 42;

-- 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” y que incluya los producto id = “80” o ”42”.

select Facturas.*,Empleados.apellido as AP , ProductoID
from Facturas
inner join FacturaDetalle on Facturas.FacturaID = FacturaDetalle.FacturaID
inner join Empleados on Empleados.EmpleadoID = Facturas.EmpleadoID
having AP like 'Leverling' and ProductoID in (42,80);



-- 7) Generar un listado con los cinco mejores clientes, según sus importes de
-- compras total (PrecioUnitario * Cantidad).

select Facturas.CLienteID , sum(PrecioUnitario*Cantidad) as comprasTotal
from Facturas
inner join Clientes on Clientes.ClienteID = Facturas.ClienteID
inner join FacturaDetalle on FacturaDetalle.FacturaID = Facturas.FacturaID
group by Facturas.CLienteID
order by comprasTotal desc
limit 5;

-- 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
-- fecha de factura, país de envío, Total, ordenado de manera descendente por
-- fecha de factura y limitado a 10 filas.

select FacturaID,NombreEnvio,FechaFactura,PaisEnvio, count(*) as total
from Facturas
group by FacturaID
order by FechaFactura desc
limit 10;
