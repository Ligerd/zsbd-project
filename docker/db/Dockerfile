## MySQL 5.6 with Percona Xtrabackup

## Pull the mysql:latest image
FROM mysql:latest

 # mysql working location
ENV WORK_PATH /usr/local

 # Define the directory that will be automatically executed by the container
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d

# SQL to initialize the database
#ENV FILE_0 createTable.sql
#ENV FILE_1 inserTestData.sql

 # Execute SQL
ENV INSTALL_DATA_SHELL docker-entrypoint.sh

COPY ./scripts $WORK_PATH/
#COPY ./$FILE_1 $WORK_PATH/
 #Place the shell file to be executed in the /docker-entrypoint-initdb.d/ directory, the container will automatically execute the shell
COPY ./$INSTALL_DATA_SHELL $AUTO_RUN_DIR/

 #Add executable permissions to executable files
RUN chmod a+x $AUTO_RUN_DIR/$INSTALL_DATA_SHELL

EXPOSE 3307
EXPOSE 3306
 # Set the command to be executed when the container starts
#CMD ["sh", "/docker-entrypoint-initdb.d/import.sh"]