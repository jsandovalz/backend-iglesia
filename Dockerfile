FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache python3 make g++ libc6-compat

COPY package.json ./
RUN npm install --legacy-peer-deps

COPY . .

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

RUN npm run build

RUN ls -la /app && ls -la /app/.strapi 2>/dev/null || echo "no .strapi dir" && ls -la /app/dist 2>/dev/null || echo "no dist dir"

CMD ["npm", "run", "start"]
