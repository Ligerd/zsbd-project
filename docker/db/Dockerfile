## Pull the mysql:latest image
FROM mysql:latest

 # mysql working location
ENV WORK_PATH /usr/local

ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d


ENV INSTALL_DATA_SHELL docker-entrypoint.sh

COPY ./scripts $WORK_PATH/
COPY ./$INSTALL_DATA_SHELL $AUTO_RUN_DIR/

RUN chmod a+x $AUTO_RUN_DIR/$INSTALL_DATA_SHELL

EXPOSE 3307
EXPOSE 3306