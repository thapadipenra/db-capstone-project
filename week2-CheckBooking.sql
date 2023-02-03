use LittleLemonDB;
DROP PROCEDURE IF EXISTS CheckBooking;
CREATE PROCEDURE CheckBooking(BookingDate DATE,Table_Number INT)
	SELECT CONCAT("Table ", TableNumber, " is already booked")
    WHERE exists (select * from Bookings where Date = BookingDate and TableNumber = Table_Number)
CALL CheckBooking("2022-11-12", 3);
