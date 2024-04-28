FROM oven/bun:latest as base
WORKDIR /app
COPY package.json bun.lockb ./

FROM base as build
RUN bun install
COPY . .
ENV NODE_ENV=production
RUN bun run build

# Copy built files from Stage 1
FROM base as production
WORKDIR /app
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static
COPY --from=build /app/public ./public
EXPOSE 3000
CMD ["node", "server.js"]
