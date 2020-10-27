#!/bin/bash

rm -rf deploy/docker-compose.yml
rm -rf deploy/README.md
rm -rf deploy/notes.md
rm -rf deploy/csv-to-elastic.ipynb
rm -rf deploy/Dockerfile-base-notebook

rm -rf deploy/sh


cp -R docker-compose.yml deploy/
cp -R README.md deploy/
cp -R notes.md deploy/
cp -R csv-to-elastic.ipynb deploy/
cp -R Dockerfile-base-notebook deploy/

mkdir -p deploy/sh
cp sh/dump.sh deploy/sh/
cp sh/restore.sh deploy/sh/
cp sh/dump-to-csv.sh deploy/sh/