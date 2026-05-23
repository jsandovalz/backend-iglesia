FROM node:20-alpine3.20

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps --no-package-lock

COPY . .

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

RUN npm run build

RUN find /app/dist -name "schema.json" 2>/dev/null || echo "NO SCHEMAS IN DIST" && \
    find /app/.strapi -name "schema.json" 2>/dev/null || echo "NO SCHEMAS IN .STRAPI" && \
    find /app/src -name "schema.json" 2>/dev/null || echo "NO SCHEMAS IN SRC"

RUN find /app/dist -name "schema.json" | head -20 || echo "No schema.json found"

# Sobreescribir configs DESPUÉS del build
RUN mkdir -p /app/dist/config/env/production && \
    cp /app/config/database.js /app/dist/config/database.js && \
    cp /app/config/env/production/database.js /app/dist/config/env/production/database.js && \
    cp /app/config/admin.js /app/dist/config/admin.js && \
    cp /app/config/server.js /app/dist/config/server.js

CMD ["npm", "run", "start"]