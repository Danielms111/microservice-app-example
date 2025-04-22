FROM node:10-alpine
RUN apk add --no-cache python make g++
WORKDIR /app
COPY . .

ENV PORT=8081
ENV AUTH_API_ADDRESS=http://auth-api:8000
ENV TODOS_API_ADDRESS=http://todos-api:8082

RUN npm install
RUN npm run build

RUN npm install -g serve@11.3.2

CMD ["serve", "-s", "dist", "-l", "8081"]
