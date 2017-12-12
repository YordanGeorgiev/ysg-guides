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