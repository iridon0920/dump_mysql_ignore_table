#!/usr/bin/env bash

echo -n Please enter the DB name:
read DB

TABLES=(
"tbl1"
"tbl2"
"tbl3"
"tbl4"
"tbl5"
"tbl100"
)
IGNORE_TABLES=""

for TBL in ${TABLES[@]}; do
  IGNORE_TABLES=$IGNORE_TABLES" --ignore-table=${DB}.${TBL}"
  echo $TBL
done

#mysqldump -u root -p ${IGNORE_TABLES} ${DB} | gzip -c > ${DB}.sql.gz
