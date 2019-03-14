FROM node:8-alpine
MAINTAINER James Tatman <jtatmanus atatat gmail dhat com>

# runs install for irslackd as illustrated at
#  https://github.com/adsr/irslackd


RUN apk --no-cache install git openssl
# debug TBR
RUN apk --no-cache install bash

RUN mkdir -p /srv

WORKDIR /srv

RUN git clone https://github.com/tatmantech/irslackd.git

WORKDIR /srv/irslackd

RUN npm install    # Fetch dependencies into local `node_modules/` directory

EXPOSE 6697

CMD ["./irslackd"]

