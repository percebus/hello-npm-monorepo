FROM node:22 AS base

FROM base as root
WORKDIR /usr/project
COPY . .
RUN npm run setup:ci --if-present && npm ci

FROM root as linted
RUN npm run lint

FROM base as express-app
WORKDIR /usr/project
COPY ./node/express-app .
RUN npm run setup:ci --if-present && npm ci
RUN npm test
CMD ["npm", "run", "start" ]
