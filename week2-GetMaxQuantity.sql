use LittleLemonDB;
drop procedure if exists GetMaxQuantity;
create procedure GetMaxQuantity() select max(Quantity) as GetMaxQuantity from Orders;
call GetMaxQuantity();