# Use an official Node.js runtime as a parent image
FROM node:19-alpine

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
RUN npm install -g http-server

# Build the app
RUN npm run build --prod

# Run the app when the container starts
CMD ["npm", "run", "serve"]