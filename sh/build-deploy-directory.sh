#!/bin/bash

rm -rf deploy/docker-compose.yml
rm -rf deploy/README.md
rm -rf deploy/sh


cp -R README.md deploy/
cp -R docker-compose.yml deploy/
mkdir -p deploy/sh
cp sh/dump.sh deploy/sh/
cp sh/restore.sh deploy/sh/