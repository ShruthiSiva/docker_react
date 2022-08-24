# as builder is used to tag this phase as the builder phase - used to build the application and install dependencies. 
FROM node:16-alpine as builder
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
CMD npm run build

# start the run phase which copies the build folder to the nginx container and uses this server to serve the statically generated content in build. No syntax is needed to speicify that the intial phase is stopping. A block can only have a single FROm statement, so it is obvious that the new FROM means the end of the previous block and start of a new one.
FROM nginx
# want to copy something from the builder phase. First argument is the thing we want to copy. Second is where we want to copy it to in the nginx container. This folder location was pulled from nginx's documentation.
COPY --from=builder /app/build /usr/share/nginx/html
