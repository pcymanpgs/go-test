FROM golang:1.19 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
RUN go mod verify
COPY . ./
RUN go build -o hello .

FROM debian:buster-slim
RUN apt update && apt install -y ca-certificates
COPY --from=builder /app/hello /app/hello
ENTRYPOINT ["/app/hello"]
