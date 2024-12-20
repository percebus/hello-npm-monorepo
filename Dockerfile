FROM node:22 AS base

FROM base AS root
WORKDIR /usr/project
COPY . .
RUN ls -la
RUN npm run setup:ci --if-present && npm ci

FROM root AS linted
RUN npm run lint

FROM base AS express-app
WORKDIR /usr/project
COPY ./node/express-app .
RUN npm run setup:ci --if-present && npm ci
RUN npm test
CMD ["npm", "run", "start" ]
