FROM node:22 AS base

FROM base AS root
WORKDIR /usr/project
COPY . .
RUN ls -la
RUN npm run setup:ci --if-present && npm ci
RUN npm test

FROM base AS express-app
WORKDIR /usr/project
COPY ./node/express-app .
RUN npm run setup:ci --if-present && npm ci
RUN npm test
RUN npm run start

FROM base AS rest-app
WORKDIR /usr/project
COPY ./node/rest-app .
RUN npm run setup:ci --if-present && npm ci
RUN npm test
RUN npm run start
