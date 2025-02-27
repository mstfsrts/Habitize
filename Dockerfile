# 1️⃣ Frontend'i build et
FROM node:18 AS frontend
WORKDIR /client

COPY client/package*.json ./
RUN npm install --omit=dev
COPY client ./
RUN npm run build

# 2️⃣ Backend için yeni bir Node.js container oluştur
FROM node:18 AS backend
WORKDIR /server

# package.json ve package-lock.json'ı kopyala ve bağımlılıkları yükle
COPY server/package*.json ./
RUN npm install --omit=dev
RUN npm rebuild bcrypt --build-from-source  # bcrypti düzeltmek için ekledik

# Uygulama kodunu kopyala
COPY server ./

# `.env` dosyasını `server` içine taşı
COPY .env /server/.env

# 3️⃣ Frontend'in build edilen dosyalarını backend içine KOPYALA
COPY --from=frontend /client/dist /server/dist

# 4️⃣ Ortam değişkenlerini belirle
ENV NODE_ENV=production
EXPOSE 4000

# 5️⃣ Backend'i çalıştır
CMD ["node", "src/index.js"]
