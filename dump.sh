#!/bin/bash

echo -n Please enter the uesr name:
read USER_NAME

echo -n Please enter the DB name:
read DB

IGNORE_TABLES=""
IGNORE_TABLE_DATA=""

#ignore_table_listより、定義もデータもダンプしないテーブルを設定
while read IGNORE_TBL
do
  IGNORE_TABLES=$IGNORE_TABLES" --ignore-table=${DB}.${IGNORE_TBL}"
done < ./ignore_table_list.txt

#ignore_table_data_listより、データはダンプしないテーブルを設定
while read IGNORE_TBL_DATA
do
  IGNORE_TABLE_DATA=$IGNORE_TABLE_DATA" --ignore-table=${DB}.${IGNORE_TBL_DATA}"
done < ./ignore_table_data_list.txt

#テーブル定義のみダンプ
mysqldump -u ${USER_NAME} -p ${IGNORE_TABLES} ${DB} -d -n | gzip -c > ${DB}_table.sql.gz

#テーブルデータのみダンプ
mysqldump -u ${USER_NAME} -p ${IGNORE_TABLES} ${IGNORE_TABLE_DATA} ${DB} -n | gzip -c > ${DB}_table_data.sql.gz
