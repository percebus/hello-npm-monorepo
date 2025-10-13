FROM node:22 AS base


FROM base AS npm
ENTRYPOINT [ "npm", "run" ]

FROM base AS yarn
ENTRYPOINT [ "yarn", "run" ]

# SRC: https://pnpm.io/docker
FROM base as pnpm
ENV CI="true"
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
ENTRYPOINT [ "pnpm", "run" ]


FROM npm AS root
WORKDIR /usr/project
COPY . .
RUN ls -la
RUN npm run setup:docker --if-present && npm ci
CMD [ "test" ]


FROM npm AS express-app
WORKDIR /usr/project
COPY ./node/express-app .
RUN ls -la
RUN npm run setup:docker --if-present && npm ci
CMD [ "test" ]

FROM npm AS rest-app
WORKDIR /usr/project
COPY ./node/rest-app .
RUN ls -la
RUN npm run setup:docker --if-present && npm ci
CMD [ "test" ]

FROM pnpm AS my-parcel-app
WORKDIR /usr/project
COPY ./node/my-parcel-app .
RUN ls -la
RUN npm run setup:docker --if-present
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
CMD [ "test" ]
