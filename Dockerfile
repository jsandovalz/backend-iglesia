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

# Build solo el admin panel (no toca dist/api)
RUN npm run build

# Restaurar dist/api desde src (el build lo sobreescribe)
RUN find /app/src/api -name "*.js" | while read f; do \
    target=$(echo "$f" | sed 's|/app/src/|/app/dist/|'); \
    mkdir -p "$(dirname $target)"; \
    cp "$f" "$target"; \
    done

# Copiar schemas
RUN find /app/src/api -name "schema.json" | while read f; do \
    target=$(echo "$f" | sed 's|/app/src/|/app/dist/|'); \
    mkdir -p "$(dirname $target)"; \
    cp "$f" "$target"; \
    done

# Copiar configs
RUN mkdir -p /app/dist/config/env/production && \
    cp /app/config/database.js /app/dist/config/database.js && \
    cp /app/config/env/production/database.js /app/dist/config/env/production/database.js && \
    cp /app/config/admin.js /app/dist/config/admin.js && \
    cp /app/config/server.js /app/dist/config/server.js

CMD ["npm", "run", "start"]