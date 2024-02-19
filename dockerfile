# Build stage
FROM node:16-alpine as build

# Setup proxy if needed
ENV HTTP_PROXY=http://172.17.0.1:3128
ENV HTTPS_PROXY=http://172.17.0.1:3128

# Prepare build directory
WORKDIR /frontend

# Install dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Build application
COPY . .
RUN yarn build && yarn cache clean

# Final stage
FROM nginx:stable-alpine

# Setup server
COPY --from=build /frontend/dist /app
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80