# Use Node.js LTS version as the base image
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the application listens on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
