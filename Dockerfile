FROM node:20-alpine

ARG CACHEBUST=1

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps

COPY . .

RUN rm -rf /app/dist /app/.strapi

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

RUN npm run build

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]