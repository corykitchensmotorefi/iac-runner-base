
build:
	docker image build -t iac-runner-base .

run:
	docker container run --rm --name iac-runner-base \
	iac-runner-base:latest

sh:
	docker container run -it --rm iac-runner-base:latest /bin/bash