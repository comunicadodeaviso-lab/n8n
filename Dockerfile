FROM node:20-bullseye

RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN corepack enable && corepack prepare pnpm@9.6.0 --activate

# Instalar dependências sem rodar prepare/lefthook
RUN pnpm install --frozen-lockfile --unsafe-perm --ignore-scripts

# Agora rodar build normal
RUN pnpm run build

EXPOSE 5678

CMD ["pnpm", "run", "start:default"]
