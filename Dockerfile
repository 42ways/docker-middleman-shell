# Dockerfile for middlemanapp toolset (website development)
# based on Ubuntu 20 with bundled ruby (2.7.0)

FROM ubuntu:20.04
MAINTAINER Thomas Herrmann <mail@thoherr.de>

ENV DEBIAN_FRONTEND noniteractive

RUN apt-get update \
        && apt-get install -y curl git ca-certificates ruby ruby-dev python3 build-essential \
                              netcat-openbsd tzdata nodejs npm vim \
        && rm -rf /var/lib/apt/lists/*

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
RUN ( echo 'export GEM_HOME=/usr/local/bundle'; echo 'export PATH=$GEM_HOME/bin/:$PATH' ) >> /etc/bash.bashrc

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

RUN gem install bundler \
        && bundle config --global path "$GEM_HOME" \
        && bundle config --global bin "$GEM_HOME/bin"

RUN npm install -g bower

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

# RUN locale-gen de_DE.UTF-8
ENV LC_CTYPE de_DE.UTF-8

COPY Gemfile .
RUN bundle install

VOLUME /middleman
WORKDIR /middleman

CMD [ "/bin/bash", "-l" ]
