FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /cmd
COPY . .
#RUN go get
RUN make macos

FROM scratch
WORKDIR /
COPY --from=builder /cmd/MyTeleBot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT [ "./MyTeleBot" ]