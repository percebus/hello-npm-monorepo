FROM node:22 AS base
ENTRYPOINT [ "npm", "run" ]

FROM base AS root
WORKDIR /usr/project
COPY . .
RUN ls -la
RUN npm run setup:ci --if-present && npm ci
CMD [ "test" ]

FROM base AS express-app
WORKDIR /usr/project
COPY ./node/express-app .
RUN npm run setup:ci --if-present && npm ci
CMD [ "test" ]

FROM base AS rest-app
WORKDIR /usr/project
COPY ./node/rest-app .
RUN npm run setup:ci --if-present && npm ci
CMD [ "test" ]
