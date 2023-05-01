# Use an official Node.js runtime as a parent image
FROM node:19-alpine

# Expose port 80 for the app
EXPOSE 80

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN npm install -g http-server

# Run the app when the container starts
CMD ["npm", "run", "serve"]