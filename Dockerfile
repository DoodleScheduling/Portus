FROM library/ruby:2.3.1
MAINTAINER Flavio Castelli <fcastelli@suse.com>

ENV COMPOSE=1
EXPOSE 3000

WORKDIR /portus
COPY Gemfile* ./
RUN bundle install --retry=3 && bundle binstubs phantomjs
RUN apt-get update && apt-get -y install curl && curl -sL https://deb.nodesource.com/setup_6.x | sh
RUN apt-get update && \
    apt-get install -y nodejs

ADD package.json .
RUN npm install
ADD . .
RUN rake webpack:compile
