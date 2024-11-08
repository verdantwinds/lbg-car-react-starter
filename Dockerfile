# Build stage
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install yarn if not present (though node:18-alpine should have it)
RUN apk add --no-cache yarn

# First copy only package.json and yarn.lock
# This optimizes caching and only reinstalls if these files change
COPY package.json ./
COPY yarn.lock ./

# Install dependencies with a clean yarn install
RUN yarn install --network-timeout 1000000

# Copy the rest of the application code
COPY . .

# Build the application
RUN yarn build

# Install serve for hosting the built application
RUN yarn global add serve

# Expose port 3000
EXPOSE 3000

# Start the application using serve
CMD ["serve", "-s", "build", "-l", "3000"]
