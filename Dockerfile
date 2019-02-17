FROM ruby:2.3-alpine

COPY Gemfile                         /app/
COPY gollum/Gemfile                  /app/gollum/
COPY gollum/gollum.gemspec           /app/gollum/
COPY gollum-lib/Gemfile              /app/gollum-lib/
COPY gollum-lib/gollum-lib.gemspec   /app/gollum-lib/
COPY omnigollum/Gemfile              /app/omnigollum/
COPY omnigollum/Gemfile.lock         /app/omnigollum/
COPY omnigollum/omnigollum.gemspec   /app/omnigollum/

WORKDIR /app/

RUN apk add --no-cache --virtual .builddeps \
      g++ \
      gcc \
      icu-dev \
      libc-dev \
      make \
      &&\
    bundle install &&\
    apk del --no-network .builddeps

RUN apk add --no-cache git icu-libs

COPY gollum/     /app/gollum/
COPY gollum-lib/ /app/gollum-lib/
COPY omnigollum/ /app/omnigollum/

EXPOSE 3000

COPY docker/startup.sh /startup.sh
CMD ["/startup.sh"]
