use LittleLemonDB;
create view OrdersView as select OrderID, Quantity,TotalCost from Orders;
Select * from OrdersView;