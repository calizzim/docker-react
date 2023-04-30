# first step is the build phase
# all we care about is the result of the build
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# now that we have built the project we can serve it
FROM nginx
# this does not do anything locally - aws uses this to expose port 80
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html