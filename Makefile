
build:
	sh build.sh

test:
	sh test.sh

clean:
	sh clean.sh

cleand:
	sh clean_docker.sh

.PHONY: build test clean
