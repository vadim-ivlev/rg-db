# RG-DB

База данных для документов РГ, в рамках проекта рекомендательной машины.

Дамп

```
$ time docker exec -it rg-db pg_dump rgdb > dumps/rgdb.sql
```

Копировать дамп в вольюм

d cp ../dumps/rgdb.sql rg-db:/dumps/

Восстановление. 
To reload such a script into a (freshly created) database named newdb:

```
$ psql -U username -d dbname < filename.sql
$ time docker exec -it rg-db psql -d rgdb < ../dumps/rgdb.sql

$ psql -d newdb -f db.sql
$ time docker exec -it rg-db psql -d rgdb -f /dumps/rgdb.sql
$ time docker exec -it rg-db pg_restore -C /dumps/rgdb.sql

```