FROM node:20-alpine3.20

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps --no-package-lock

COPY . .

RUN rm -rf /app/dist /app/.strapi

# Copiar src completo a dist
RUN mkdir -p /app/dist && cp -r /app/src/* /app/dist/ 2>/dev/null || true

# Copiar archivos .ts como .js para que Strapi los pueda  leer
RUN find /app/dist -name "*.ts" | while read f; do cp "$f" "${f%.ts}.js"; done

# Copiar configs
RUN mkdir -p /app/dist/config/env/production && \
    cp /app/config/database.js /app/dist/config/database.js && \
    cp /app/config/env/production/database.js /app/dist/config/env/production/database.js && \
    cp /app/config/admin.js /app/dist/config/admin.js && \
    cp /app/config/server.js /app/dist/config/server.js

    
RUN ls /app/dist/api || echo "WARNING: dist/api not found"

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

RUN npm run build

CMD ["npm", "run", "start"]