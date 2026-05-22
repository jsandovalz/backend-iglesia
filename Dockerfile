FROM node:20-alpine

ARG CACHEBUST=1

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps --no-package-lock

COPY . .

RUN rm -rf /app/dist /app/.strapi

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

# Compilar TypeScript
RUN ./node_modules/.bin/tsc --project tsconfig.json --skipLibCheck || true

# Verificar que dist/api existe
RUN ls /app/dist/api || echo "WARNING: dist/api not found"

RUN npm run build

CMD ["/start.sh"]