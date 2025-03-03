# 1️⃣ Frontend’i build et
FROM node:18 AS build
WORKDIR /client

# Paketleri yükle
COPY package.json package-lock.json ./
RUN npm install

# Frontend kodlarını kopyala
COPY . .

# Build-time environment değişkenini geçir
ARG REACT_APP_BASE_SERVER_URL
ENV REACT_APP_BASE_SERVER_URL=$REACT_APP_BASE_SERVER_URL

# Build et ve değişkenin geçmesini sağla
RUN REACT_APP_BASE_SERVER_URL=$REACT_APP_BASE_SERVER_URL npm run build

# 2️⃣ Nginx ile serve etmek için
FROM nginx:1.23

# Nginx konfigürasyonunu kopyala
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Frontend’in build dosyasını Nginx’e kopyala
COPY --from=build /client/dist /usr/share/nginx/html

# 3001 portunu aç
EXPOSE 3001

# Nginx’i başlat
CMD ["nginx", "-g", "daemon off;"]
