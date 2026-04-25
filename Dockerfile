FROM ruby:4.0.3-slim

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev git curl && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 4567

CMD ["ruby", "app.rb"]
