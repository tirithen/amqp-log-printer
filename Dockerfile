FROM mhart/alpine-node:6.7

# Add bash only for running the wait-for-http.sh (until another wait method is figured out)
RUN /sbin/apk --update add bash
RUN /sbin/apk --update add curl

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

CMD [ "npm", "start" ]
