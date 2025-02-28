# 1️⃣ Frontend’i build et
FROM node:18 AS build
WORKDIR /client

# Paketleri yükle
COPY package.json package-lock.json ./
RUN npm install

# Frontend kodlarını kopyala
COPY . .

# Build et
RUN npm run build

# 2️⃣ Nginx ile serve etmek için
FROM nginx:1.23

# Nginx konfigürasyonunu 3000 portu için ayarla
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Frontend’in build dosyasını Nginx’e kopyala
COPY --from=build /client/dist /usr/share/nginx/html

# 3000 portunu aç
EXPOSE 3000

# Nginx’i başlat
CMD ["nginx", "-g", "daemon off;"]
