# ---------- Build Stage ----------
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

COPY . .

# ---------- Runtime Stage ----------
FROM gcr.io/distroless/nodejs18-debian11

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["app.js"]
