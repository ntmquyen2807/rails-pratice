# Use base image
FROM ruby:2.5.1

ENV APP_ROOT /usr/src/app

#set rails_env variable [development | staging | production]
ENV RAILS_ENV development

WORKDIR $APP_ROOT

RUN export RAILS_ENV=$RAILS_ENV && \
    apt-get update && \
    apt-get install -y nodejs \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

COPY . $APP_ROOT

COPY config/puma.rb config/puma.rb

EXPOSE  3000

# The default command that gets ran will be to start the Puma server.
CMD bundle exec puma -C config/puma.rb