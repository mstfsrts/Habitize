# 1️⃣ Frontend'i build et
FROM node:18 AS frontend
WORKDIR /client

# Paketleri yükle
COPY client/package*.json ./
RUN npm install

# Tüm frontend kodlarını kopyala
COPY client ./

# Frontend'i build et
RUN npm run build

# 2️⃣ Backend için yeni bir Node.js container oluştur
FROM node:18 AS backend
WORKDIR /server

# package.json ve package-lock.json'ı kopyala ve bağımlılıkları yükle
COPY server/package*.json ./
RUN npm install --omit=dev  # Gereksiz dev bağımlılıkları atlamak için

# Backend kodlarını kopyala
COPY server ./

# `.env` dosyasını backend içine taşı (Eğer varsa)
COPY .env /server/.env

# Frontend'in build edilen dosyalarını backend içine kopyala
COPY --from=frontend /client/dist /server/dist

# **EKSİK OLAN:** Node_modules klasörünü backend’e kopyala (Webpack hatası olmaması için)
COPY --from=frontend /client/node_modules /server/client_node_modules

# Ortam değişkenlerini belirle
ENV NODE_ENV=production
EXPOSE 4000

# Backend'i çalıştır
CMD ["node", "src/index.js"]
