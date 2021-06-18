# Dockerfile
# User ruby image
FROM ruby:2.7.3-alpine
RUN apk update
RUN gem install bundler -v 2.1.4
WORKDIR /myapp
COPY ruby/Gemfile /myapp/ruby/Gemfile.lock
CMD [ "bundler", "exec", "install" ]
COPY . /myapp

# Start the test suite
CMD [ "ruby", "ruby/tests/customer_success_balancing_tests.rb", "--verbose"]

