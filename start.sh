#!/bin/sh
echo "=== ENV CHECK ==="
echo "DATABASE_CLIENT=$DATABASE_CLIENT"
echo "DATABASE_URL length=${#DATABASE_URL}"
echo "NODE_ENV=$NODE_ENV"
echo "PORT=$PORT"
echo "=================="
npm run start