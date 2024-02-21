# Etapa 1: Construcción del frontend
FROM node:20.5.0 AS frontend_builder

# Crear directorio para el frontend
WORKDIR /app/frontend

# Copiar los archivos del frontend
COPY ./FRONT_PIS/package*.json ./FRONT_PIS/
COPY ./FRONT_PIS/ /app/frontend/

# Instalar dependencias del frontend
RUN npm install
RUN npm install -g npm@10.4.0
RUN npm install react-ace ace-builds

# Construir el frontend
RUN npm run build

# Etapa 2: Construcción del backend
FROM node:20.5.0 AS backend_builder

# Crear directorio para el backend
WORKDIR /app/backend

# Copiar los archivos del backend
COPY ./back_pis/package*.json ./back_pis/
COPY ./back_pis/ /app/backend/

# Instalar dependencias del backend
RUN npm install
RUN npm install axios

# Etapa 3: Creación del contenedor final
FROM nginx:alpine

# Copiar los archivos del frontend construido
COPY --from=frontend_builder /app/frontend/build /usr/share/nginx/html

# Copiar la configuración de NGINX para el proxy
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80 para NGINX
EXPOSE 80

# CMD predeterminado de nginx
CMD ["nginx", "-g", "daemon off;"]

