FROM ruby:2.3.0-slim
MAINTAINER Seigo Uchida <spesnova@gmail.com> (@spesnova)

WORKDIR /test
ENV PHANTOMJS_VERSION 2.1.1

# See below link about phantomjs
#   http://phantomjs.org/download.html
RUN curl -o /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
  -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
  && tar jxf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp \
  && cp /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs \
  && rm -rf /tmp/phantomjs-*

COPY Gemfile /test/Gemfile
COPY Gemfile.lock /test/Gemfile.lock

RUN apt-get update && \
    apt-get install -y \
      build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    bundle install -j4 && \
    apt-get purge -y --auto-remove build-essential

VOLUME ["/test/spec"]

CMD ["bundle", "exec", "rspec", "-c"]
