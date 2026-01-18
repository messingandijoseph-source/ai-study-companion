# Use official Node.js LTS image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency files first (for caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --only=production

# Copy application source
COPY src ./src

# Expose service port
EXPOSE 3000

# Start the service
CMD ["node", "src/index.js"]
