# syntax=docker/dockerfile:1

# Use the official Node.js image for the base image
# stage 1
ARG NODE_VERSION=22
FROM node:${NODE_VERSION}-alpine AS base

# Add a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Install dependencies only when needed
# stage 2
FROM base AS deps
RUN apk add --no-cache libc6-compat && npm install -g corepack

WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json ./
COPY yarn.lock* ./
COPY package-lock.json* ./
COPY pnpm-lock.yaml* ./
COPY .npmrc* ./
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i; \
  else echo "Error: No lockfile found. Please ensure you have one of the following lockfiles: yarn.lock, package-lock.json, or pnpm-lock.yaml." && exit 1; \
  fi

# Development image
# stage 3
FROM base AS runner
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

ENV NODE_ENV=development

# Install TypeScript globally
RUN npm install -g typescript

# Switch to the non-root user
USER appuser

EXPOSE 3000

CMD ["npm", "run", "dev"]
