# file: docs/cheat-sheets/sql/mysql/mysql-cheat-sheet.sh

# how-to change mysql user pw
mysqladmin -u root -p'old_pass' mysql_user_pw 'new_pass'

# how-to check the status of the mysql service
sudo bash /etc/init.d/mysql status

# how-to start the mysql server
sudo bash /etc/init.d/mysql start

# how-to stop the mysql server
sudo bash /etc/init.d/mysql stop

# how-to recover root password
sudo /etc/init.d/mysql stop
sudo mysqld_safe --skip-grant-tables &
mysql -uroot
use mysql
update user set password = PASSWORD ('secret') where user='root';
flush privileges;
quit ;
sudo /etc/init.d/mysql start


# how-to generate a select table statement in bash 
mysql -u$mysql_user -p$mysql_user_pw -c $project_db -s -e \
"SELECT @cCommand := GROUP_CONCAT( COLUMN_NAME ORDER BY ORDINAL_POSITION \
SEPARATOR ', ') FROM INFORMATION_SCHEMA.COLUMNS WHERE 1=1 \
AND TABLE_SCHEMA = '"$project_db"' AND TABLE_NAME = '"$table_name"'; \
SET @cCommand = CONCAT( 'SELECT ', @cCommand, ' from "$project_db.$table_name";');
SELECT @cCommand
; "


mysql -u mysql_user -p  -D db_name -B -e "select * from users;"   > /home/yogeorgi/tmp/list.csv ;
mysql -u mysql_user -p  -D information_schema -B -e "select columns from columns;"   > /home/yogeorgi/tmp/list.csv ;

# Batch mode (feeding in a script): 
mysql -u user -p < batch_file
/* (Use -t for nice table layout and -vvv for command echoing.) */
# Alternatively: 
source batch_file;


#how-to load a CSV file into a table.
LOAD DATA INFILE '/tmp/filename.csv' replace INTO TABLE `table_name` FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (field1,field2,field3);

#Dump all databases for backup. Backup file is sql commands to recreate all dbs
mysqldump -u root -pmysql_user_pw >/tmp/alldatabases.sql

# Dump one database for backup. 
mysqldump -u mysql_user -pmysql_user_pw #databases db_name >/tmp/db_name.sql 

# Dump a table from a database
mysqldump -c -u mysql_user -pmysql_user_pw db_name table_name > /tmp/db_name.table_name.sql

# Restore database (or database table) from backup. 
mysql -u mysql_user -pmysql_user_pw db_name < /tmp/db_name.sql 

# check to which port mysql is listening
netstat -ln | grep mysql

# check whether mysql is running
ps -ef | grep -i mysql

#
# Purpose:
# ---------------------------------------------------------
# mostly bash shell cheat commmads for mysql 
# ---------------------------------------------------------
# VersionHistory
# 1.0.0 -- 2016-09-29 10:17:11 -- ysg -- total refactory
#
# eof file: docs/cheat-sheets/sql/mysql/mysql-cheat-sheet.sh
