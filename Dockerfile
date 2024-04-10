FROM oven/bun:latest as base
WORKDIR /usr/src/app
COPY package.json bun.lockb ./

FROM base as build
RUN bun install
COPY . .
ENV NODE_ENV=production
RUN bun run build

# Copy built files from Stage 1
FROM base as production
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/.next/standalone ./
COPY --from=build /usr/src/app/.next/static ./.next/static
COPY --from=build /usr/src/app/public ./public
EXPOSE 3000
CMD ["node", "server.js"]