#!/bin/bash

rm -rf deploy/docker-compose.yml
rm -rf deploy/README.md

cp -R README.md deploy/
cp -R docker-compose.yml deploy/