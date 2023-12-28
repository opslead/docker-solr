# Apache Solr Container Image

[![Docker Stars](https://img.shields.io/docker/stars/opslead/solr.svg?style=flat-square)](https://hub.docker.com/r/opslead/solr) 
[![Docker Pulls](https://img.shields.io/docker/pulls/opslead/solr.svg?style=flat-square)](https://hub.docker.com/r/opslead/solr)

#### Docker Images

- [GitHub actions builds](https://github.com/opslead/docker-solr/actions) 
- [Docker Hub](https://hub.docker.com/r/opslead/solr)


#### Environment Variables
When you start the Solr image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the docker run command line. The following environment values are provided to custom Solr:

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `JAVA_ARGS`               |               | Configure JVM params            |

#### Run the Service

```bash
docker service create --name solr \
  -p 2181:2181 \
  -e JAVA_ARGS="-Xms2G -Xmx6G" \
  opslead/solr:latest
```

When running Docker Engine in swarm mode, you can use `docker stack deploy` to deploy a complete application stack to the swarm. The deploy command accepts a stack description in the form of a Compose file.

```bash
docker stack deploy -c solr-stack.yml solr
```

Compose file example:
```yaml
version: "3.8"
services:
  solr:
    image: opslead/solr:latest
    ports:
      - 8080:8080
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      environment:
        - JAVA_ARGS=-Xms2G -Xmx6G
```

# Contributing
We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/opslead/docker-solr/issues), or submit a [pull request](https://github.com/opslead/docker-solr/pulls) with your contribution.

# Issues
If you encountered a problem running this container, you can file an [issue](https://github.com/opslead/docker-solr/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version
- Output of docker info
- Version of this container
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)
