FROM ruby:2.3

COPY Gemfile                         /app/
COPY gollum/Gemfile                  /app/gollum/
COPY gollum/gollum.gemspec           /app/gollum/
COPY gollum-lib/Gemfile              /app/gollum-lib/
COPY gollum-lib/gollum-lib.gemspec   /app/gollum-lib/
COPY omnigollum/Gemfile              /app/omnigollum/
COPY omnigollum/Gemfile.lock         /app/omnigollum/
COPY omnigollum/omnigollum.gemspec   /app/omnigollum/

WORKDIR /app/

RUN bundle install --path=vendor/bondle

COPY gollum/     /app/gollum/
COPY gollum-lib/ /app/gollum-lib/
COPY omnigollum/ /app/omnigollum/

EXPOSE 3000

CMD ["bundle", "exec", "thin", "-p", "3000", "-e", "production", "start"]
