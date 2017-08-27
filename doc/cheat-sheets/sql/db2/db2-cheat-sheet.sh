# to start db2 
sudo /opt/ibm/db2/V10.5_01/adm/db2start

# to stop db2 
sudo /opt/ibm/db2/V10.5_01/adm/db2stop 
sudo /opt/ibm/db2/V10.5_01/adm/db2stop force


#how-to connnect to a database
db2 "connect to sample"

#db2 
quit

# list all the tables
db2 "list tables for all " | less

# run a file 
db2 -f ./path/to/file/run.sql

# use a different statement separator than the default ;
db2 -td/ -svf db2.sql

# src: http://dublintech.blogspot.fi/2011/10/db2-cheat-sheet.html
# src: http://www.michael-thomas.com/tech/db2/db2_survival_guide.htm



