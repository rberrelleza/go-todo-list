FROM golang:buster as builder
RUN go install github.com/go-delve/delve/cmd/dlv@latest
WORKDIR /app
ADD . .
RUN go build -o app

##########################

FROM debian:buster as prod

WORKDIR /app
COPY --from=builder /app/app /app/app
COPY --from=builder /app/static /app/static
EXPOSE 8080
CMD ["./app"]