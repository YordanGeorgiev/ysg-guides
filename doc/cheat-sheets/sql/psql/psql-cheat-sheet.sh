IFS='' read -r -d '' sql_code << EOF_SQL_CODE
            SELECT users.id, email, password, roles.name as roles
            FROM users
            LEFT JOIN user_roles ON (users.guid = user_roles.users_guid)
            LEFT JOIN roles ON (roles.guid = user_roles.roles_guid)
            WHERE 1=1
            AND status > 0
            AND email='AdminEmail';
EOF_SQL_CODE
psql -d dev_qto -c "$sql_code"

IFS='' read -r -d '' sql_code << EOF_SQL_CODE
	SELECT
	o.oid
	, o.conname AS constraint_name
	, (SELECT nspname FROM pg_namespace WHERE oid=m.relnamespace) AS source_schema
	, m.relname AS source_table
	, (SELECT a.attname FROM pg_attribute a
	WHERE a.attrelid = m.oid AND a.attnum = o.conkey[1] AND a.attisdropped = false) AS source_column
	, (SELECT nspname FROM pg_namespace
	WHERE oid=f.relnamespace) AS target_schema
	, f.relname AS target_table
	, (SELECT a.attname FROM pg_attribute a
	WHERE a.attrelid = f.oid AND a.attnum = o.confkey[1] AND a.attisdropped = false) AS target_column
	, ROW_NUMBER () OVER (ORDER BY o.oid) as rowid
	FROM pg_constraint o
	LEFT JOIN pg_class f ON f.oid = o.confrelid
	LEFT JOIN pg_class m ON m.oid = o.conrelid
	WHERE 1=1
	AND o.contype = 'f'
	AND o.conrelid IN (SELECT oid FROM pg_class c WHERE c.relkind = 'r')
EOF_SQL_CODE
psql -d dev_qto -c "$sql_code"




# copy paste me into bash shell directly
clear; IFS='' read -r -d '' sql_code << 'EOF_SQL_CODE'
CREATE OR REPLACE FUNCTION func_get_all_users_roles()
-- define the return type of the result set as table
-- those datatypes must match the ones in the src
RETURNS TABLE (
     id           bigint
   , email        varchar(200)
   , password     varchar(200)
   , roles        varchar(100)) AS
$func$
BEGIN
RETURN QUERY 
-- start the select clause
SELECT users.id, users.email, users.password, roles.name as roles
FROM user_roles
LEFT JOIN roles ON (roles.guid = user_roles.roles_guid)
LEFT JOIN users ON (users.guid = user_roles.users_guid)
-- stop the select clause
;
END
$func$  LANGUAGE plpgsql;
EOF_SQL_CODE
# create the function
psql -d db_name -c "$sql_code"; 

# call the function 
psql -d db_name -c "select * from func_get_all_users_roles() "



-- Start a transaction
   BEGIN;SELECT func_get_users_roles(refcursor); FETCH ALL IN "refcursor";COMMIT;


# how-to export 
while read -r t ; do psql -d prd_veldan -t  -c \
"SELECT 
table_name,column_name from information_schema.columns 
where 1=1 
and table_catalog='prd_veldan' and table_name='"$t"' order by 1;" ; \
done < <(psql -d prd_veldan -t -c "SELECT \
table_name FROM information_schema.tables \
WHERE 1=1 and table_schema='public' ORDER BY 1" ) \
| perl -ne 's/\s+\|\s+/;/g; print $_ if /[a-z]/g '>/vagrant/list.csv