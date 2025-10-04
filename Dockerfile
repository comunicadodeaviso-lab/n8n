# Imagem base com Node 20
FROM node:20-bullseye

# Instalar dependências de compilação (necessárias para sqlite3, esbuild, etc.)
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Ativar corepack e preparar pnpm
RUN corepack enable \
  && corepack prepare pnpm@9.6.0 --activate

# Instalar dependências e buildar monorepo
RUN pnpm install --frozen-lockfile --unsafe-perm \
  && pnpm run build

# Porta padrão do n8n
EXPOSE 5678

# Start do n8n
CMD ["pnpm", "run", "start:default"]
