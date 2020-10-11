GOCMD=go
DOCKERCMD=docker
SSL=openssl genrsa
GO_RUN=$(GOCMD) run
GO_BUILD=$(GOCMD) build
DOCKER_BUILD=$(DOCKERCMD) build
DOCKER_RUN=$(DOCKERCMD) run

TMPGEN= mkdir tmp
DEVDOCKER=config/development/Dockerfile
DEVCONFIG=config/development/gqlgen.yml
GQLGEN=github.com/99designs/gqlgen

all:
clean:
	rm private.key
	rm -rf pkg/bff
	rm -rf pkg/server/model
build:
	$(SSL) -out private.key 4096
	$(GO_RUN) $(GQLGEN)
	$(GO_BUILD) -o server pkg/server/server.go
docker-build:
	$(DOCKER_BUILD) ./ -t miraikeitai2020/bff:0.2.0
docker-run:
	$(DOCKER_RUN) -d -p 9020:9020 miraikeitai2020/bff:0.2.0
