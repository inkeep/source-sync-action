FROM alpine:3.10

RUN apk --no-cache add curl

RUN apk add --no-cache jq

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
