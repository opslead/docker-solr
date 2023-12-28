FROM azul/zulu-openjdk:11

LABEL maintainer="opslead"
LABEL repository="https://github.com/opslead/docker-solr"

ARG SOLR_VERSION

WORKDIR /opt/solr

ENV SOLR_USER="solr" \
    SOLR_UID="8983" \
    SOLR_GROUP="solr" \
    SOLR_GID="8983" \
    SOLR_PORT="8080" \
    IMAGE_MODE="server"

COPY entrypoint /opt/solr

RUN groupadd -r --gid "$SOLR_GID" "$SOLR_GROUP"
RUN useradd -r --uid "$SOLR_UID" --gid "$SOLR_GID" "$SOLR_USER"

RUN apt-get update && \
    apt-get -y install curl && \
    curl -f -L https://dlcdn.apache.org/solr/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz --output /tmp/apache-solr.tar.gz && \
    tar xf /tmp/apache-solr.tar.gz -C /tmp && \
    mv /tmp/solr-$SOLR_VERSION/modules /opt/solr/ && \
    mv /tmp/solr-$SOLR_VERSION/prometheus-exporter /opt/solr/ && \
    mv /tmp/solr-$SOLR_VERSION/server /opt/solr/ && \
    rm -rf /tmp/* &&  \
    mkdir -p /opt/solr/data/cores && \
    chown $SOLR_USER:$SOLR_GROUP -R /opt/solr && \
    chmod +x /opt/solr/entrypoint && \
    apt-get clean

# COPY security.json /opt/solr/data

USER $SOLR_USER
VOLUME ["/opt/solr/data/cores"]

ENTRYPOINT ["/opt/solr/entrypoint"]