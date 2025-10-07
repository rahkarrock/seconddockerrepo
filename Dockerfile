# Step 1: Build stage
FROM node:18 g build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Run stage with Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
