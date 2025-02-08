FROM node:18-alpine AS builder
WORKDIR /build
COPY . /build
RUN npm install 
RUN npm run build

FROM caddy:2.9.1-alpine
COPY --from=builder /build/dist /app
WORKDIR /app
ENTRYPOINT ["caddy", "file-server", "-l", "0.0.0.0:8783"]
