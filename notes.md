

# Полезные команды
## Дамп/Восстановление данных

**Способ 1.** Дамп через stdout в текстовый скрипт. 

Дамп. Занимает 1.5 мин.
```
$ time docker exec -it rg-db-prod pg_dump rgdb > ../dumps/rgdb.sql
```
Восстановление из текстового дампа.

**Шаг1**. Копировать дамп в том контейнера postgress.
```
docker cp ../dumps/rgdb.sql rg-db-prod:/dumps/
```
**Шаг 2.** Загрузка данных из текстового скрипта БД. Занимает 8 мин.
Перед восстановлением данных
необходимо удалить таблицы из базы данных.
```
$ time docker exec -it rg-db-prod psql -d rgdb -f /dumps/rgdb.sql
```
**Способ 2.**  Дамп в бинарный формат со сжатием 0.

Дамп (1.2 мин)
```
$ time docker exec -it rg-db-prod pg_dump -v -Z0 -F c -f /dumps/rgdb.dump rgdb
```

Восстановление (8 мин). Перед восстановлением данных
необходимо удалить таблицы из базы данных.
```
$ time docker exec -it rg-db-prod pg_restore -v -j 15 -C -d rgdb /dumps/rgdb.dump

```

## Размер базы данных
```
$ docker exec -it rg-db-prod psql rgdb -c '\l+ rgdb'
```

Команды просмотра томов и копирования данных между контейнерами и хостирующим компом.
```
$ docker exec -it rg-db-prod ls -lh /dumps/
$ docker exec -it rg-db-prod rm  /dumps/rgdb.dump
```
сжатие дампов
```
pigz rgdb.dump
```

