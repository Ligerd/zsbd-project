## Pull the mysql:latest image
FROM mysql:latest

 # mysql working location
ENV WORK_PATH /usr/local

ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d

ENV secure-file-priv=/usr/local

ENV INSTALL_DATA_SHELL docker-entrypoint.sh

COPY ./scripts $WORK_PATH/
COPY ./$INSTALL_DATA_SHELL $AUTO_RUN_DIR/

RUN chmod a+x $AUTO_RUN_DIR/$INSTALL_DATA_SHELL

RUN mkdir -p ${WORK_PATH}/reports 
RUN chmod 777 ${WORK_PATH}/reports 

EXPOSE 3307
EXPOSE 3306