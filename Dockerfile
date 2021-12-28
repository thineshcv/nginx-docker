# stage 1 Build stage

FROM node:lts-alpine AS build 

RUN mkdir /app

WORKDIR /app

COPY package.json /app
COPY package-lock.json /app

COPY . /app

RUN npm run build

# stage 2

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]