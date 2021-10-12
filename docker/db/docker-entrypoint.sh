#!/bin/bash
mysql -uroot -proot <<EOF
source /usr/local/createTable.sql;
source /usr/local/inserTestData.sql;