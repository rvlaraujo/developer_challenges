# Dockerfile
# User ruby image
FROM ruby:2.7.3-alpine
RUN apk update
RUN gem install bundler -v 2.1.4
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile.lock
CMD [ "bundler", "exec", "install" ]
COPY . /myapp

# Start the test suite
CMD [ "rake", "test", "TESTOPTS=\"-v\""]

