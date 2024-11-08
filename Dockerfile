# Dockerfile
# Stage 1 - Build and Test
FROM node:16-alpine as build

WORKDIR /app
COPY package.json ./
COPY package-lock.json ./

RUN npm install
COPY . . 

# Run tests
# RUN npm run test

# Build production files
RUN npm run build

# Stage 2 - Production Deployment
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

# Expose port and define command
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
