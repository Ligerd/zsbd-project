use airlines;
-- event
SET GLOBAL event_scheduler = ON; 
SET @@GLOBAL.event_scheduler = ON; 
SET GLOBAL event_scheduler = 1; 
SET @@GLOBAL.event_scheduler = 1;

delimiter |
  CREATE EVENT e_daily_flight_stat
     ON SCHEDULE
       EVERY 1 MINUTE
     COMMENT 'Saves total number of sessions then clears the table each day'
     DO
     begin
	SET @TS = DATE_FORMAT(NOW(),'_%Y_%m_%d_%H_%i_%s');
	SET @FOLDER = '/usr/local/reports/';
	SET @PREFIX = 'report';
	SET @EXT    = '.csv';
	set @QUERY = "select CURRENT_DATE as fly_date, flight.flight_number as flight_number, count(*) as number_pass from passenger join ticket on ticket.passenger = passenger_id join flight on ticket.flight = flight.flight_id WHERE departure > DATE_SUB(NOW(), INTERVAL 24 HOUR) AND departure <= NOW() group by flight.flight_number INTO OUTFILE '";
	SET @CMD = CONCAT(@QUERY,@FOLDER,@PREFIX,@TS,@EXT,
	"' FIELDS ENCLOSED BY '\"'",
	" TERMINATED BY ','"," 
	ESCAPED BY '\"'",
	" LINES TERMINATED BY '\\n';");

	PREPARE statement FROM @CMD;
	EXECUTE statement;
END |
delimiter ;