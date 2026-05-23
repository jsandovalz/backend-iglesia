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

# Copiar schemas a dist/
RUN find /app/src/api -name "schema.json" | while read f; do \
    target=$(echo "$f" | sed 's|/app/src/|/app/dist/|'); \
    mkdir -p "$(dirname $target)"; \
    cp "$f" "$target"; \
    done

# Crear JS válidos para controllers, routes y services
RUN for dir in /app/dist/api/*/; do \
    name=$(basename "$dir"); \
    mkdir -p "$dir/controllers" "$dir/routes" "$dir/services"; \
    printf "'use strict';\nconst { createCoreController } = require('@strapi/strapi').factories;\nmodule.exports = createCoreController('api::%s.%s');" "$name" "$name" > "$dir/controllers/$name.js"; \
    printf "'use strict';\nconst { createCoreRouter } = require('@strapi/strapi').factories;\nmodule.exports = createCoreRouter('api::%s.%s');" "$name" "$name" > "$dir/routes/$name.js"; \
    printf "'use strict';\nconst { createCoreService } = require('@strapi/strapi').factories;\nmodule.exports = createCoreService('api::%s.%s');" "$name" "$name" > "$dir/services/$name.js"; \
    echo "module.exports = {};" > "$dir/index.js"; \
    done

# Copiar configs
RUN mkdir -p /app/dist/config/env/production && \
    cp /app/config/database.js /app/dist/config/database.js && \
    cp /app/config/env/production/database.js /app/dist/config/env/production/database.js && \
    cp /app/config/admin.js /app/dist/config/admin.js && \
    cp /app/config/server.js /app/dist/config/server.js

CMD ["npm", "run", "start"]