# Use Node 20, que é compatível com o n8n
FROM node:20-bullseye

# Diretório de trabalho dentro do container
WORKDIR /app

# Copiar arquivos necessários
COPY . .

# Ativar corepack e preparar pnpm
RUN corepack enable \
  && corepack prepare pnpm@9.6.0 --activate

# Instalar dependências e build
RUN pnpm install --frozen-lockfile \
  && pnpm run build

# Expor porta padrão do n8n (5678)
EXPOSE 5678

# Comando padrão para rodar o n8n
CMD ["pnpm", "run", "start:default"]
