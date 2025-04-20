ARG NODE_VERSION=22.14.0

ARG PORT=3000

FROM node:${NODE_VERSION}-slim as base

WORKDIR /src

# Build
FROM base as build

COPY --link package.json  .

RUN npm install

COPY --link . .

RUN npm run build

# Run
FROM base

ENV PORT=$PORT
ENV NODE_ENV=production

COPY --from=build /src/.output /src/.output

CMD [ "node", ".output/server/index.mjs" ]
