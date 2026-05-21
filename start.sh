#!/bin/sh
echo "=== COPYING CONFIG TO DIST ==="
mkdir -p /app/dist/config/env/production
cp /app/config/database.js /app/dist/config/database.js
cp /app/config/server.js /app/dist/config/server.js
cp /app/config/middlewares.js /app/dist/config/middlewares.js
cp /app/config/plugins.js /app/dist/config/plugins.js
cp /app/config/admin.js /app/dist/config/admin.js
cp /app/config/api.js /app/dist/config/api.js 2>/dev/null || true
cp /app/config/env/production/database.js /app/dist/config/env/production/database.js 2>/dev/null || true
echo "=== STARTING STRAPI ==="
npm run start