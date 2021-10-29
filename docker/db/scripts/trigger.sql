use airlines;

-- trigger 
DELIMITER $$
create trigger airlines before insert on passenger for each row
begin 
	DECLARE rowcount INT;
	SELECT COUNT(*) 
	INTO rowcount
    FROM passenger
    where passenger.passport = new.passport;
	IF rowcount > 0 THEN
        SIGNAL sqlstate '45001' set message_text = "Passport must be unique. This passenger alredy in database";
    END IF; 
END $$

DELIMITER ;