# Build stage
FROM node:18-alpine as build

# Install yarn
RUN apk add --no-cache yarn

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the application
RUN yarn build

# Install serve globally
RUN yarn global add serve

# Expose port 80
EXPOSE 80

# Start the application using serve
CMD ["serve", "-s", "build", "-l", "3000"]
