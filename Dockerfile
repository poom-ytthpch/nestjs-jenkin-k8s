# =====================
# Build
# =====================
FROM node:22-alpine AS builder

WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .

RUN ls -la /app
RUN ls -la /app/public || echo "NO PUBLIC"

RUN pnpm build


# =====================
# Prod deps only
# =====================
FROM node:22-alpine AS prod-deps

WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml ./

# Install only production deps
RUN pnpm install --prod --frozen-lockfile \
  && pnpm store prune \
  && rm -rf /root/.pnpm-store


# =====================
# Runtime
# =====================
FROM node:22-alpine

WORKDIR /app

# Copy only minimal files
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/public ./public
COPY package.json ./

# Clean cache (extra safety)
RUN rm -rf /root/.npm /root/.cache

EXPOSE 8000

CMD ["node", "dist/main.js"]
