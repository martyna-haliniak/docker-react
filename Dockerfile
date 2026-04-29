#----------build phase--------------
FROM node:16-alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm ci
COPY . . 

# volumes not needed anymore as we're not changing our source code

RUN npm run build 

#------------run phase-------------
FROM nginx:alpine

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/build /usr/share/nginx/html


EXPOSE 80

# no need to start nginx, it starts automatically
