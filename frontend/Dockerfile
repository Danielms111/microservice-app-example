FROM node:18-alpine

WORKDIR /app
COPY . .

ENV PORT=8081
ENV AUTH_API_ADDRESS=http://auth-api:8000
ENV TODOS_API_ADDRESS=http://todos-api:8082

RUN npm install
RUN npm run build

# Servir la app estática con `serve`
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-l", "8081"]
