USE LittleLemonDB;
DROP PROCEDURE IF EXISTS AddValidBooking;
DROP FUNCTION IF EXISTS Validate;

DELIMITER $$

CREATE FUNCTION Validate(RecordsFound INTEGER, message VARCHAR(255)) RETURNS INTEGER DETERMINISTIC
BEGIN
    IF RecordsFound IS NOT NULL OR RecordsFound > 0 THEN
        SIGNAL SQLSTATE 'ERR0R' SET MESSAGE_TEXT = message;
    END IF;
    RETURN RecordsFound;
END$$

CREATE PROCEDURE AddValidBooking(IN BookingDate DATE, IN TableNumber INT)
	BEGIN
		DECLARE `_rollback` BOOL DEFAULT 0;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
		START TRANSACTION;
        
        SELECT Validate(COUNT(*), CONCAT("Table ", TableNumber, " is already booked"))
        FROM bookings
        WHERE date = BookingDate AND table_number = TableNumber;
        
		INSERT INTO bookings (date, table_number)
		VALUES (BookingDate, TableNumber);
		
		IF `_rollback` THEN
			SELECT CONCAT("Table ", TableNumber, " is already booked - booking cancelled") AS "Booking status";
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
    END$$
    
DELIMITER ;

CALL AddValidBooking("2022-12-17", 6);