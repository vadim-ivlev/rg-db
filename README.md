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
## Экспорт данных в Эластик
Проводится в два этапа. 

1. Экспорт в csv (3 мин)
    ```
    sh/dump-to-csv.sh
    ```
    CSV файлы сохраняются в директорию csv/

2. Импрорт csv в Эластик (30 мин)
   
   Откройте браузер
    <http://dockertest.rgwork.ru:8888/notebooks/csv-to-elastic.ipynb>. 
    Введите пароль. Запустите программу. 
    После импорта файлы csv можно удалить.

<br><br>
Дополнительная информация в notes.md.
