# file: scala-cheat-sheet.sh

# unless otherwise stated you should always execute all the commands from
cd <<proj_root_dir>>

# how-to compile my scala project 
sbt compile

# how-to execute the tests in my scala project 
sbt test 

# test only a certain test from the 
sbt "test:testOnly *ReaderFactoryTest"

# how-to list all the tasks in my project
sbt tasks



# Purpose
# to provide a cheat sheet for the most used scala related shell commands
#  
# 
# eof file: scala-cheat-sheet.sh