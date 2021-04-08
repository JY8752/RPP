FROM node:12.17.0-alpine
WORKDIR /app

COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install

COPY . .
