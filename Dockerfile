# Use an official Node.js runtime as a parent image
FROM node:19-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install dependencies
RUN apk add --no-cache git && \
    git clone https://github.com/S1V7T-Yoshino/temp-app.git .
RUN npm install
RUN npm install -g http-server

# Copy the remaining app files to the container
# COPY . .

# Build the app
RUN npm run build --prod

# Expose port 80 for the app
EXPOSE 80

# Run the app when the container starts
CMD ["npm", "run", "serve"]
