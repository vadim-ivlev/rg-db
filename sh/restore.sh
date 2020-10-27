#!/bin/bash

# восстанавливает дамп базы данных rgdb

if [ "$1" = "" ]; then
    echo "Укажите файл с дампом: ./restore.sh filename.dump.gz"
    exit 1
fi

# https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script
a=$1
xpath=${a%/*} 
xbase=${a##*/}
xfext=${xbase##*.}
xpref=${xbase%.*}

echo xpath=${xpath}
echo xbase=${xbase}
echo xpref=${xpref}
echo xfext=${xfext}

DUMPFILE=$1
DUMPDIR=$xpath
DUMPNAME=$xpref
echo "DUMPNAME=$DUMPNAME"

echo "Распаковываем $DUMPFILE"
time pigz -dkf $DUMPFILE 

echo "Копируем $DUMPDIR/$DUMPNAME в котейнер"
time docker cp "$DUMPDIR/$DUMPNAME" rg-db-prod:/dumps/

echo "Удаляем $DUMPDIR/$DUMPNAME"
rm "$DUMPDIR/$DUMPNAME" 

echo "Чистим базу данных"
time docker exec -it rg-db-prod psql -d rgdb -c 'DROP SCHEMA public CASCADE;'
time docker exec -it rg-db-prod psql -d rgdb -c 'CREATE SCHEMA public;'

echo "Восстанавливаем данные из $DUMPNAME в контейнере"
time docker exec -it rg-db-prod pg_restore -j 15 -C -d rgdb "/dumps/$DUMPNAME"

echo "Удаляем дамп $DUMPNAME из контейнера"
docker exec -it rg-db-prod rm /dumps/$DUMPNAME