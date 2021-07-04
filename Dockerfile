FROM golang:1.15.1-alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/github.com/pravekum55/prometheusdemo
COPY . $GOPATH/src/github.com/pravekum55/prometheusdemo
RUN go get -d -v
RUN go build -o /tmp/monitor *.go

FROM alpine:3.12.0
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && mkdir -p /app 
COPY --from=builder /tmp/monitor /app
COPY conf.json /app
RUN chmod a+rx /app/monitor

USER appuser
WORKDIR /app
ENV LISTENING_PORT 8080
CMD ["./monitor"]
