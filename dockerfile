# Build stage
FROM node:16-alpine as build

# Prepare build directory
WORKDIR /frontend

# Install dependencies
COPY . .
RUN yarn install --frozen-lockfile

# Build application
RUN yarn build && yarn cache clean

# Final stage
FROM nginx:stable-alpine

# Setup server
COPY --from=build /frontend/dist /app
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
