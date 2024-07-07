# Use the official Node image for a build stage
FROM node:14 AS build
WORKDIR /app
# Copy the package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install
# Copy the rest of the code
COPY . .
# Build the project
RUN npm run build

# Use Nginx to serve the static content
FROM nginx:alpine
# Copy the built application from the build stage
COPY --from=build /app/dist/your-angular-app-name /usr/share/nginx/html
# Expose the port Nginx is listening on
EXPOSE 80