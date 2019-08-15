FROM ruby:2.6.3-alpine

ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver APP_HOME=/app
WORKDIR $APP_HOME

RUN apk add --update build-base postgresql-dev git tzdata nodejs yarn && \
    cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
    echo "Europe/London" > /etc/timezone

RUN gem install bundler:2.0.2

ADD Gemfile Gemfile.lock package.json yarn.lock $APP_HOME/
RUN yarn install --check-files
RUN bundle install

ADD . $APP_HOME/

CMD bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0
