# Use an official Node.js runtime as a parent image
FROM node:19-alpine AS build

# Expose port 80 for the app
EXPOSE 80

# Install Git
RUN apk update && apk add --no-cache git

# Clone the repository
RUN git clone https://github.com/S1V7T-Yoshino/temp-app.git /app

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN npm install

# Build the app
RUN npm run build --prod

# Start with a fresh nginx image
FROM nginx:alpine

# Copy the built Angular application from the previous stage
COPY --from=build /app/dist/my-app /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]