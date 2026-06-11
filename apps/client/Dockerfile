FROM node:22-alpine AS builder

RUN corepack enable

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN pnpm install

COPY . .
ARG PUBLIC_API_URL
RUN pnpm build

FROM node:22-alpine

WORKDIR /app

ENV PORT=3000
ENV HOST=0.0.0.0

COPY --from=builder /app/build ./build

EXPOSE 3000

CMD ["node", "build"]
