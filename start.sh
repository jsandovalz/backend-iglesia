#!/bin/sh
echo "=== ENV CHECK ==="
echo "DATABASE_CLIENT=$DATABASE_CLIENT"
echo "DATABASE_URL length=${#DATABASE_URL}"
echo "NODE_ENV=$NODE_ENV"
echo "=== CONFIG FILES ==="
cat /app/config/database.js 2>/dev/null || echo "no config/database.js"
cat /app/config/env/production/database.js 2>/dev/null || echo "no config/env/production/database.js"
echo "=== DIST CONFIG ==="
find /app/dist -name "database*" 2>/dev/null || echo "no dist database files"
echo "=================="
npm run start