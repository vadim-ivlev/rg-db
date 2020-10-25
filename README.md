# RG-DB

База данных для документов РГ, в рамках проекта рекомендательной машины.

Дамп

```
$ time docker exec -it rg-db pg_dump rgdb > dumps/rgdb.sql
```
Восстановление. 
To reload such a script into a (freshly created) database named newdb:

```
$ psql -U username -d dbname < filename.sql
$ time docker exec -it rg-db psql -U username -d dbname < filename.sql

$ psql -d newdb -f db.sql
$ time docker exec -it rg-db psql -d newdb -f db.sql

```