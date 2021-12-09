#!/bin/bash
mysql -uroot -proot <<EOF
source /usr/local/createTable.sql;
source /usr/local/inserTestData.sql;
source /usr/local/job.sql;
source /usr/local/procedure.sql;
source /usr/local/trigger.sql;
source /usr/local/views.sql;
source /usr/local/function.sql;