.PHONY: build

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build: 
	rm -rf dst
	docker run -t --rm -v $(ROOT_DIR):/tmp/layer lambci/lambda:build-nodejs8.10 /tmp/layer/src/scripts/build.sh

dive:
	docker run -it --rm -v $(ROOT_DIR):/tmp/layer lambci/lambda:build-nodejs8.10 bash

upload: 
	./upload.sh

clean:
	rm -rf bin
	rm -rf lib

test:
	sam local invoke lambdaFunction -e event.json
