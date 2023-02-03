use LittleLemonDB;
drop procedure if exists CancelOrder;
delimiter \\
create procedure CancelOrder(Orderid int) 
begin
delete from Orders where OrderID=Orderid;
select concat("Order ", OrderID, " is cancelled") as Confirmation;
end\\
delimiter ;

call CancelOrder(5)