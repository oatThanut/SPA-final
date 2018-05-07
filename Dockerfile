FROM golang:1.10-alpine3.7

ARG pkg=github.com/realroy/spa-lab-final

RUN apk add --no-cache ca-certificates

COPY . $GOPATH/src/$pkg

RUN set -ex \
      && apk add --no-cache --virtual .build-deps \
              git \
      && go get -v $pkg/... \
      && apk del .build-deps

RUN go install $pkg/...

# Needed for templates for the front-end app.
WORKDIR $GOPATH/src/$pkg/app

# Users of the image should invoke either of the commands.
CMD echo "Use the app or pubsub_worker commands."; exit 1
