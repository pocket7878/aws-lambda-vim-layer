.PHONY: build

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build:
ifndef VIM_VERSION
	  @echo '[ERROR] $$VIM_VERSION must be specified'
	  @echo 'make build VIM_VERSION=x.x.x'
	  exit 255
endif
	  docker run -e VIM_VERSION=$(VIM_VERSION) --rm -v $(ROOT_DIR):/tmp/layer lambci/lambda:build-nodejs8.10 /tmp/layer/scripts/build.sh

clean:
	rm -rf bin
	rm -rf lib

test:
	sam local invoke lambdaFunction -e event.json
