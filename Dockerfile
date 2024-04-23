FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make linux

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/MyTeleBot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT [ "./MyTeleBot" ]