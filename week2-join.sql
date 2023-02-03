use LittleLemonDB;
select c.CustomerID, c.Name, o.OrderID, o.TotalCost, m.Name, mi.Course, mi.Starter 
from Customers as c inner join Orders as o on c.CustomerID=o.CustomerID 
inner join Menus as m on o.MenuID=m.MenuID 
inner join MenuContent as mc on m.MenuID=mc.MenuID 
inner join MenuItems as mi on mc.MenuItemID=mi.MenuItemID 
where o.TotalCost>500;