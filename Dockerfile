ARG RUBY_VERSION=2.5
ARG NODE_VERSION=10.15

FROM node:$NODE_VERSION-alpine AS nodejs
FROM ruby:$RUBY_VERSION-alpine

MAINTAINER Jason Taylor <jason@redant.com.au>

COPY --from=nodejs /usr/local/bin/node /usr/local/bin/
COPY --from=nodejs /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodejs /opt/ /opt/

RUN ln -sf /usr/local/bin/node /usr/local/bin/node \
  && ln -sf /usr/local/bin/node /usr/local/bin/nodejs \
  && ln -sf ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -sf ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
  && ln -sf /opt/yarn*/bin/yarn /usr/local/bin/yarn \
  && ln -sf /opt/yarn*/bin/yarnpkg /usr/local/bin/yarnpkg

RUN apk add --no-cache bash

CMD ["bash"]
