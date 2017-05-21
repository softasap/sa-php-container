#!/bin/sh
PROJECT_NAME=php-fpm-alpine
ansible-container --debug --project-name ${PROJECT_NAME} run --roles-path ./roles/ -- -vvv
