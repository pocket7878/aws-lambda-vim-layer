.PHONY: build

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build: 
	docker run --rm -v $(ROOT_DIR):/tmp/layer lambci/lambda:build-nodejs8.10 /tmp/layer/scripts/build.sh


upload: 
	./upload.sh

clean:
	rm -rf bin
	rm -rf lib

test:
	sam local invoke lambdaFunction -e event.json
