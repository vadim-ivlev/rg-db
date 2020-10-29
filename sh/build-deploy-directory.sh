#!/bin/bash

rm -rf deploy/docker-compose.yml
rm -rf deploy/README.md
rm -rf deploy/notes.md
rm -rf deploy/notebooks
rm -rf deploy/Dockerfile-notebook

rm -rf deploy/sh


cp -R docker-compose.yml deploy/
cp -R README.md deploy/
cp -R notes.md deploy/
cp -R notebooks deploy/
cp -R Dockerfile-notebook deploy/

mkdir -p deploy/sh
cp sh/dump.sh deploy/sh/
cp sh/restore.sh deploy/sh/
cp sh/dump-to-csv.sh deploy/sh/