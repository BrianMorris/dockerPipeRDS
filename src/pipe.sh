#!/bin/bash
source .env.sh

DB_USER_SRC=${DB_USER_SRC:=$ENV_USER_SRC}
DB_PWD_SRC=${DB_PWD_SRC:=$ENV_PWD_SRC}
DB_NAME_SRC=${DB_NAME_SRC:="test01"}
DB_HOST_SRC=${DB_HOST_SRC:="mydbinstance.cfudftsks7ny.us-east-2.rds.amazonaws.com"}

DB_USER_DEST=${DB_USER_DEST:=$ENV_USER_DEST}
DB_PWD_DEST=${DB_PWD_DEST:=$ENV_PWD_DEST}
DB_NAME_DEST=${DB_NAME_DEST:='test'}
DB_HOST_DEST=${DB_HOST_DEST:='mydbinstance.cfudftsks7ny.us-east-2.rds.amazonaws.com'}


echo "env"
echo "evn is: $ENV_PWD"
echo "src values:"
echo "DB_USER_SRC $DB_USER_SRC"
echo "DB_PWD_SRC $DB_PWD_SRC"
echo "DB_NAME_SRC $DB_NAME_SRC"
echo "DB_HOST_SRC $DB_HOST_SRC"

echo "dest values"
echo "DB_USER_DEST $DB_USER_DEST"
echo "DB_PWD_DEST $DB_PWD_DEST"
echo "DB_NAME_DEST $DB_NAME_DEST"
echo "DB_HOST_DEST $DB_HOST_DEST"

# cat ./src/sampleLocate.sql | sed -E 's/DEFINER=`[^`]+`@`[^`]+`/DEFINER=CURRENT_USER/g' | mysql -u$DB_USER_DEST -p$DB_PWD_DEST -h$DB_HOST_DEST $DB_HOST_DEST 
mysqldump -u$DB_USER_SRC -p$DB_PWD_SRC -h$DB_HOST_SRC $DB_NAME_SRC  | sed -E 's/DEFINER=`[^`]+`@`[^`]+`/DEFINER=CURRENT_USER/g' | mysql -u$DB_USER_DEST -p$DB_PWD_DEST -h$DB_HOST_DEST $DB_NAME_DEST 

echo "done"