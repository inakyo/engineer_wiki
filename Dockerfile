FROM ruby:3.0.0

ENV TZ Asia/Tokyo

#apt-key has beed not recomended
#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | \apt-key add - \
#  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list > /dev/null

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

RUN mkdir /engineer_wiki
ENV APP_ROOT /engineer_wiki
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT
