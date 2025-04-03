# Use official Node.js image for building the Angular app
FROM node:20 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the project files
COPY . .

# Build the Angular app
RUN npm run build --prod

# Use Nginx for serving the Angular app
FROM nginx:alpine

# Copy built Angular files to Nginx HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
