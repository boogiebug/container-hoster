# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM golang:1.26.0-alpine3.23 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download && go mod verify
COPY *.go ./
ARG TARGETOS
ARG TARGETARCH
ARG VERSION=version_not_set
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build --tags netgo -ldflags="-w -s -X 'main.version=${VERSION}'" -o /container-hoster .
RUN mkdir -p /healthdir

FROM scratch
LABEL org.opencontainers.image.source=https://github.com/boogiebug/container-hoster
LABEL org.opencontainers.image.description="A simple 'etc/hosts' file injection tool to resolve names of local Docker containers on the host."
LABEL org.opencontainers.image.licenses=MIT
VOLUME /var/run/docker.sock
VOLUME /hosts
ENTRYPOINT ["/container-hoster"]
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD ["/container-hoster", "--healthcheck"]
WORKDIR /
COPY --from=build ./container-hoster /container-hoster
COPY --from=build /healthdir /tmp
