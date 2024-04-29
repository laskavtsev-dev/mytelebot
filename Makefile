VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
APP := $(shell basename $(shell git remote get-url origin) | tr '[:upper:]' '[:lower:]' | sed 's/\.git$$//')
REGISTRY := ghcr.io/laskavtsev-dev

OS := linux
#A := B
#OS := windows
#ARCH := arm64
ARCH := amd64
IMAGENAME := ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}

get:
	go get

format:
	gofmt -s -w ./

lint:
	go lint

test:
	go test -v

linux: format
	go get gopkg.in/telebot.v3
	CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -v -o MyTeleBot -ldflags "-X="https://github.com/laskavtsev-dev/MyTeleBot/cmd.appVersion=${VERSION}

arm: format
	go get gopkg.in/telebot.v3
	CGO_ENABLED=0 GOOS=android GOARCH=${ARCH} go build -v -o MyTeleBot -ldflags "-X="https://github.com/laskavtsev-dev/MyTeleBot/cmd.appVersion=${VERSION}

macos: format
	go get gopkg.in/telebot.v3
	CGO_ENABLED=0 GOOS=darwin GOARCH=${ARCH} go build -v -o MyTeleBot -ldflags "-X="https://github.com/laskavtsev-dev/MyTeleBot/cmd.appVersion=${VERSION}

windows: format
	go get gopkg.in/telebot.v3
	CGO_ENABLED=0 GOOS=windows GOARCH=${ARCH} go build -v -o MyTeleBot -ldflags "-X="https://github.com/laskavtsev-dev/MyTeleBot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${IMAGENAME}

push:
	docker push ${IMAGENAME}

clean:
	rm -rf MyTeleBot
	docker rmi ${IMAGENAME}
