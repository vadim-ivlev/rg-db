#!/bin/bash

# Делвет дамп базы данных rgdb

DUMPDIR="../rgdb-dumps/rg-db"
DUMPNAME="rgdb-$(date +"%Y-%m-%d-%H-%M-%S").dump"

echo "Создаем директорию дампов $DUMPDIR" 

mkdir -p $DUMPDIR

echo "Делам дамп $DUMPNAME в контейнере"
time docker exec -it rg-db-prod pg_dump -Z0 -F c -f /dumps/$DUMPNAME rgdb

echo "Копируем $DUMPNAME из котейнера в $DUMPDIR"
time docker cp rg-db-prod:/dumps/$DUMPNAME "$DUMPDIR/"

echo "Пакуем $DUMPDIR/$DUMPNAME"
time pigz "$DUMPDIR/$DUMPNAME"

echo "Удаляем дамп $DUMPNAME из контейнера"
docker exec -it rg-db-prod rm /dumps/$DUMPNAME