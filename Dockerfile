FROM node:20-alpine3.20

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps --no-package-lock

COPY . .

ARG CACHEBUST=4

RUN rm -rf /app/dist /app/.strapi

RUN ./node_modules/.bin/tsc --project tsconfig.json --skipLibCheck || true

RUN cp -r /app/src/api /app/dist/api 2>/dev/null || true && \
    cp -r /app/src/extensions /app/dist/extensions 2>/dev/null || true

RUN mkdir -p /app/dist/config/env/production && \
    cp /app/config/database.js /app/dist/config/database.js && \
    cp /app/config/env/production/database.js /app/dist/config/env/production/database.js && \
    cp /app/config/admin.js /app/dist/config/admin.js && \
    cp /app/config/server.js /app/dist/config/server.js

RUN ls /app/dist/api

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

RUN npm run build

CMD ["npm", "run", "start"]