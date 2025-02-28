FROM node:18 AS backend
WORKDIR /server

# package.json ve package-lock.json'ı kopyala ve bağımlılıkları yükle
COPY package*.json ./
RUN npm install --omit=dev  # Production için

# Backend kodlarını kopyala
COPY . .

# 🔴 BU SATIRI KALDIR! `.env` dosyasını Docker Compose ile yönetiyoruz.
# COPY .env .env 

# Ortam değişkenlerini belirle
ENV NODE_ENV=production
EXPOSE 4000

# Backend'i çalıştır
CMD ["node", "src/index.js"]
