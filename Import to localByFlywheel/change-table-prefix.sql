DROP PROCEDURE IF EXISTS change_wp_tables_prefix ;

DELIMITER $$
CREATE procedure change_wp_tables_prefix(db VARCHAR(50), old_prefix VARCHAR(50),new_prefix VARCHAR(50))
BEGIN
	DECLARE database_name VARCHAR(100) DEFAULT db;
	DECLARE done INT DEFAULT FALSE;
	DECLARE old_table_name VARCHAR(100) DEFAULT '';
	DECLARE new_table_name VARCHAR(100) DEFAULT '';
	DECLARE table_names CURSOR FOR SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = database_name AND TABLE_NAME LIKE CONCAT(old_prefix, '%');
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN table_names;
		allTables: LOOP
			FETCH table_names INTO old_table_name;
			IF done = TRUE THEN
				LEAVE allTables;
			END IF;
			SET new_table_name = REPLACE (old_table_name,old_prefix,new_prefix);
			SET @rename_statment = CONCAT('RENAME TABLE ', database_name,'.', old_table_name,' TO ', new_table_name , ";");
			PREPARE prepared_stmt FROM @rename_statment;
			EXECUTE prepared_stmt;
			DEALLOCATE PREPARE prepared_stmt;
		END LOOP allTables;
	CLOSE table_names;
	SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = database_name AND TABLE_NAME LIKE CONCAT(old_prefix, '%');
END$$
DELIMITER ;