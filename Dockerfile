FROM golang:1.22.5 as base
WORKDIR /app
copy go.mod .
RUN go mod download
copy . .
RUN go build -o main .
EXPOSE 8080
CMD ["./main"]
# Use a minimal image for the final build
# final stage - Dstroless image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD ["./main"]