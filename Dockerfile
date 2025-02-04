FROM node:16

WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json .

# If you are building your code for production
RUN npm ci --only=production

RUN npm install

# Bundle app source
COPY . .
RUN npm run build

# Remove Unecessary Files
RUN ls | grep -v package*.json | grep -v dist | xargs rm -rf

WORKDIR /usr/src

EXPOSE 8000
EXPOSE 8001
EXPOSE 8002

CMD [ "node", "app/dist/src/index.js" ]