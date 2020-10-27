# RG-DB
База данных postgres для документов РГ, в рамках проекта рекомендательной машины.

## Настройки сервера

**1. Тома (volumes)**

Для наполнения БД данными RG API может потребоваться 
несколько суток. Чтобы сократить время создайте внешние тома
для данных и дампов  
```
$ docker volume create rg-db-data
$ docker volume create rg-db-data-dumps
```


**2. Переменная окружения RGPASS**

Определите переменную RGPASS c паролем суперпользователя postgress.(r********1)
```
$ export RGPASS=r******1
```

## Дамп 
Дампы базы данных хранятся в директории ../rgdb-dumps/rg-db.
Чтобы создать дамп выполните команду (2.5 мин на dockertest.rgwork.ru)

```
sh/dump.sh
```
## Восстановление данных
Для восстановления данных из дампа выполните команду (8 мин на dockertest.rgwork.ru)
```
sh/restore.sh ../rgdb-dumps/rg-db/rgdb....dump.gz
```

## Настройки сronjob

На сервере настроен дамп базы данных rgdb каждое воскресенье в 00:00.
```
0 0 * * 0 /home/gitupdater/rg-db-prod/sh/dump.sh
```
Просмотр расписания
```
crontab -l
```
Редактирование
```
crontab -e
```


<br><br>

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

