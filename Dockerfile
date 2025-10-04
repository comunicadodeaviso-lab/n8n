FROM node:20-bullseye

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar arquivos
COPY . .

# Ativar pnpm
RUN corepack enable && corepack prepare pnpm@9.6.0 --activate

# Debug: mostrar versões
RUN node -v && pnpm -v

# Instalar dependências
RUN pnpm install --frozen-lockfile --unsafe-perm

# Debug: listar pacotes
RUN pnpm list --depth 1

# Rodar build separado (pra ver erro exato)
RUN pnpm run build

EXPOSE 5678

CMD ["pnpm", "run", "start:default"]
