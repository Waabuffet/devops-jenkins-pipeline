#!/bin/bash
mv -v ./env ./.env
. ./.env

echo "cleaning up"

# docker-compose down
# sudo rm -rf $FILE_PATH/mysql
# rm $FILE_PATH/website/db/env.php
# cp $FILE_PATH/env.php $FILE_PATH/website/db/env.php
# rm $FILE_PATH/result.txt

# pull repo

echo "starting servers"
docker-compose up -d

mysql_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql)

echo "waiting for mysql to be up..."
while ! docker exec mysql mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "SELECT 1"; do
    sleep 2
done

# while ! (nc -z -w30 $mysql_ip 3306); do
#         sleep 1
# done

docker exec -i mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < "$FILE_PATH/$JOB_NAME@script/mydb.sql"

echo "preparing php env"
mkdir $FILE_PATH/$JOB_NAME/website/db
ENV_PHP=$FILE_PATH/$JOB_NAME/website/db/env.php
cp "$FILE_PATH/$JOB_NAME@script/env.php" $ENV_PHP

sed -i "s/<MYSQL_HOST>/$mysql_ip/" $ENV_PHP
sed -i "s/<MYSQL_PORT>/3306/" $ENV_PHP
sed -i "s/<MYSQL_DB>/$MYSQL_DATABASE/" $ENV_PHP
sed -i "s/<MYSQL_USER>/$MYSQL_USER/" $ENV_PHP
sed -i "s/<MYSQL_PASS>/$MYSQL_PASSWORD/" $ENV_PHP

echo "starting test"
# docker run -it --rm --name test-script -v "$FILE_PATH/test":/usr/src/app -w /usr/src/app node:8 node your-daemon-or-script.js

website_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' website)

mkdir $FILE_PATH/$JOB_NAME/test/env
ENV_NODE=$FILE_PATH/$JOB_NAME/test/env/env.js
cp "$FILE_PATH/$JOB_NAME@script/env.js" $ENV_NODE

sed -i "s/<METHOD>/$PROTOCOL_METHOD/" $ENV_NODE
sed -i "s/<HOST>/$website_ip/" $ENV_NODE
sed -i "s/<PORT>/$WEBSITE_PORT/" $ENV_NODE
sed -i "s/<API_ROUTE>/$TESTING_ROUTE/" $ENV_NODE

# $FILE_PATH/$JOB_NAME/run-test.sh

# wait for response file to be there
echo "waiting for test results..."
# while [ ! -f $FILE_PATH/result.txt ]; do sleep 1; done
