FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ENV TZ=Asia/Ho_Chi_Minh LANG=C.UTF-8
WORKDIR /usr/src/app
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY . /usr/src/app
