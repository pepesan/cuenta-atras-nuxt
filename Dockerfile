ARG NODE_VERSION=26.11.1

# Base
FROM node:${NODE_VERSION}-slim AS base
WORKDIR /src

# Build: instala con pnpm y el lockfile exacto (reproducible)
FROM base AS build
RUN npm install -g pnpm@10.8.1
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

# Run: Chainguard (Wolfi, sin shell ni npm/yarn), usuario no-root
FROM cgr.dev/chainguard/node:latest
WORKDIR /src
ENV NODE_ENV=production \
    PORT=3000 \
    HOST=0.0.0.0

COPY --from=build --chown=node:node /src/.output /src/.output

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD ["/usr/bin/node", "-e", "fetch('http://127.0.0.1:'+(process.env.PORT||3000)+'/api/contador').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"]

CMD [".output/server/index.mjs"]
