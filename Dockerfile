# Dockerfile for middlemanapp toolset (website development)

FROM tt-ubuntu16-ruby
MAINTAINER Thomas Herrmann <mail@thoherr.de>

RUN mkdir /middleman
RUN gem install middleman

WORKDIR /middleman
