FROM golang:latest as builder
WORKDIR /app
COPY . .
RUN go mod init go-app && \
    go mod download && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-app .

FROM scratch
WORKDIR /app
COPY --from=builder /app/go-app .
CMD ["./go-app"]


