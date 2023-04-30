# Use an official Node.js runtime as a parent image
FROM node:19-alpine

# Expose port 80 for the app
EXPOSE 80

# Set the working directory to /app
WORKDIR /app

# Install git
#  RUN apk add --no-cache git
#  RUN git clone https://github.com/S1V7T-Yoshino/temp-app.git .

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Copy the remaining app files to the container
COPY . .

# Install dependencies
RUN npm install
RUN npm install -g http-server

# Build the app
RUN npm run build --prod

# Remove evvrything except the dist folder
# RUN mv dist/* . && rm -rf dist
# RUN rm -rf src
#nav to dist folder
# WORKDIR /app/dist/my-app
# Run the app when the container starts
CMD ["npm", "run", "serve"]
# CMD ["http-server", "-p", "80", "-c-1", "."]
