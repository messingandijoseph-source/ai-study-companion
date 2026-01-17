# Use Node.js official image
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY src ./src

# Expose port 3000 for the service
EXPOSE 3000

# Start the service
CMD ["node", "src/index.js"]
