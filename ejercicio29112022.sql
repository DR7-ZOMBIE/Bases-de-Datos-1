use adventureworks;


-- Where

-- 1. Mostrar los nombre de los productos que tengan cualquier combinación de
-- ‘mountain bike’
-- Tablas: Product
-- Campos: Name

select p.name
from product p
where p.name like("%mountain bike%");

-- 2. Mostrar las personas cuyo nombre empiece con la letra “y”
-- Tablas: Contact
-- Campos: FirstName

select c.firstname
from contact c
where c.firstname like ("y%");

-- Order by

-- 1. Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
-- Tablas: Product
-- Campos: Name, ListPrice

select p.name,p.listprice
from product p
order by p.listprice desc , p.name asc
limit 5;

-- Operadores & joins

-- 1. Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea
-- johnson
-- Tablas: Contact
-- Campos: FirstName, LastName

select concat_ws(",",c.firstname,c.lastname) as nombreConcatenadoApellido
from contact c
where c.lastname = "johnson";

-- 2. Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo
-- precio sea mayor a 500$ de color negro
-- Tablas: Product
-- Campos: ListPrice, Color

select p.listprice , p.color
from product p
where p.listprice < 150 and p.listprice > 500 and color = "black";

-- Funciones de agregación

-- 1. Mostrar la fecha más reciente de venta
-- Tablas: SalesOrderHeader
-- Campos: OrderDate

select orderdate 
from salesorderheader
order by orderdate desc
limit 1;


-- 2. Mostrar el precio más barato de todas las bicicletas
-- Tablas: Product
-- Campos: ListPrice, Name

select p.name,p.listprice
from product p
order by p.listprice asc
limit 1;

-- Group by

-- 1. Mostrar los productos y la cantidad total vendida de cada uno de ellos
-- Tablas: SalesOrderDetail
-- Campos: ProductID, OrderQty

select p.name , count(s.salesorderid) as cantidadSales
from salesorderdetail s
inner join product p on p.productid = s.productid
group by p.name;

-- Having

-- 1. Mostrar la cantidad de facturas que vendieron más de 20 unidades.
-- Tablas: Sales.SalesOrderDetail
-- Campos: SalesOrderID, OrderQty

select  count(so.salesorderid) as cantidadSales
from salesorderdetail so
group by salesorderid
having cantidadSales > 20;

-- Joins

-- 1. Mostrar el código de logueo, número de territorio y sueldo básico de los
-- vendedores
-- Tablas: Employee, SalesPerson
-- Campos: LoginID, TerritoryID, Bonus, BusinessEntityID


-- 2. Mostrar los productos que sean ruedas
-- Tablas: Product, ProductSubcategory
-- Campos: Name, ProductSubcategoryID

select p.name , p.ProductSubcategoryID
from product p
inner join productsubcategory ps on ps.ProductSubcategoryID = p.ProductSubcategoryID
where p.name like "%road%";

-- 3. Mostrar los nombres de los productos que no son bicicletas
-- Tablas: Product, ProductSubcategory
-- Campos: Name, ProductSubcategoryID

select p.name , p.ProductSubcategoryID
from product p
inner join productsubcategory ps on ps.ProductSubcategoryID = p.ProductSubcategoryID
where p.name != "bicycle";

