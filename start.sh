#!/bin/sh
echo "=== COPYING CONFIG TO DIST ==="
mkdir -p /app/dist/config/env/production
cp /app/config/database.js /app/dist/config/database.js
cp /app/config/server.js /app/dist/config/server.js 2>/dev/null || true
cp /app/config/middlewares.js /app/dist/config/middlewares.js 2>/dev/null || true
cp /app/config/plugins.js /app/dist/config/plugins.js 2>/dev/null || true
cp /app/config/admin.js /app/dist/config/admin.js 2>/dev/null || true
cp /app/config/env/production/database.js /app/dist/config/env/production/database.js 2>/dev/null || true

echo "=== COPYING API TO DIST ==="
cp -r /app/src/api /app/dist/api 2>/dev/null || true
cp -r /app/src/extensions /app/dist/extensions 2>/dev/null || true
cp -r /app/src/components /app/dist/components 2>/dev/null || true

echo "=== STARTING STRAPI ==="
npm run start