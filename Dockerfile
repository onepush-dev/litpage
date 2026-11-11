# Litpage on Railway: builds upstream litmers-dev/litpage (MIT) at a pinned commit, app unmodified.
# Upstream's own Dockerfile steps; defaults baked as ENV because Railway templates drop plain variable values.
# SQLite database + uploaded files live in NC_DATA_DIR=/data (Railway volume).
FROM node:26-slim
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/litpage"
ARG LITPAGE_REF=931cd28d93218badf2b3264828731d74687395b7
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/* \
 && npm install -g pnpm@10.32.1
WORKDIR /app
RUN git clone https://github.com/litmers-dev/litpage.git . && git checkout "$LITPAGE_REF" && rm -rf .git \
 && pnpm install --frozen-lockfile && pnpm --filter @nc/web build
ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=3001 \
    NC_TRUST_PROXY=1 \
    NC_DATA_DIR=/data \
    NC_BOOTSTRAP_EMAIL=admin@example.com \
    NC_BOOTSTRAP_NAME=Admin \
    NC_BOOTSTRAP_WORKSPACE=Workspace
EXPOSE 3001
# Railway injects PORT=8080 when no PORT variable is set; the public domain targets 3001, so pin it here.
CMD ["sh", "-c", "PORT=${LITPAGE_PORT:-3001} exec node apps/server/src/main.ts"]
