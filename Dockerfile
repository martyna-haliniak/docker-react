#----------build phase--------------
FROM node:16-alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm install 
COPY . . 

# volumes not needed anymore as we're not changing our source code

RUN npm run build 

#------------run phase-------------
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# no need to start nginx, it starts automatically
