VERSION = $(shell git describe --tags --match="[0-9]\.[0-9]\.[0-9]" 2> /dev/null || echo 0.0.0)
BUILD_DIR = ./build
BIN_NAME = $(shell basename $(PWD))

docker-build:
	docker compose build

docker-start:
	docker compose up

build-linux-arm:
	GOOS=linux GOARCH=arm go build -tags release -ldflags="-s -w -X 'main.version=$(VERSION)'" -o $(BUILD_DIR)/$(BIN_NAME)

build-linux-arm64:
	GOOS=linux GOARCH=arm64 go build -tags release -ldflags="-s -w -X 'main.version=$(VERSION)'" -o $(BUILD_DIR)/$(BIN_NAME)

build-linux-386:
	GOOS=linux GOARCH=386 go build -tags release -ldflags="-s -w -X 'main.version=$(VERSION)'" -o $(BUILD_DIR)/$(BIN_NAME)

build-linux-amd64:
	GOOS=linux GOARCH=amd64 go build -tags release -ldflags="-s -w -X 'main.version=$(VERSION)'" -o $(BUILD_DIR)/$(BIN_NAME)

build-darwin-amd64:
	GOOS=darwin GOARCH=amd64 go build -tags release -ldflags="-s -w -X 'main.build=$(VERSION)'" -o $(BUILD_DIR)/$(BIN_NAME)

build-darwin-arm64:
	GOOS=darwin GOARCH=arm64 go build -tags release -ldflags="-s -w -X 'main.build=$(VERSION)'" -o $(BUILD_DIR)/$(BIN_NAME)

clean:
	go clean
	rm -fr $(BUILD_DIR)

format:
	gofmt -s -w *.go


.PHONY: build clean