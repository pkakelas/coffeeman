FROM mhart/alpine-node:7.5.0

RUN apk --update add tini

WORKDIR /src

COPY package.json /src

RUN npm install

COPY . /src

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/usr/bin/node", "/src/index.js"]
