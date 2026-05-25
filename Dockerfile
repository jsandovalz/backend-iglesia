FROM node:20-alpine3.20

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps --no-package-lock

COPY . .

# Guardar dist/api antes del build
RUN cp -r /app/dist/api /tmp/api-backup

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

RUN npm run build

# Restaurar dist/api compilado
RUN cp -r /tmp/api-backup /app/dist/api

# Copiar configs
RUN mkdir -p /app/dist/config/env/production && \
    cp /app/config/database.js /app/dist/config/database.js && \
    cp /app/config/env/production/database.js /app/dist/config/env/production/database.js && \
    cp /app/config/admin.js /app/dist/config/admin.js && \
    cp /app/config/server.js /app/dist/config/server.js

CMD ["npm", "run", "start"]