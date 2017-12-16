FROM ruby:2.4.2-alpine3.7

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update ruby-nokogiri \
                                linux-headers \
                                build-base \
                                postgresql-dev \
                                nodejs \
                                tzdata

# Different layer for gems installation
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install --jobs 4 --retry 3

# Copy the application into the container
COPY . /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000