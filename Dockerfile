FROM openjdk:8-jre-alpine

ENV DERBY_VERSION=10.14.2.0
ENV DERBY_HOME=/derby
ENV DERBY_LIB=${DERBY_HOME}/lib
ENV CLASSPATH=${DERBY_LIB}/derby.jar:${DERBY_LIB}/derbynet.jar:${DERBY_LIB}/derbytools.jar:${DERBY_LIB}/derbyoptionaltools.jar:${DERBY_LIB}/derbyclient.jar

RUN \
    apk add --update openssl && \
    wget https://dist.apache.org/repos/dist/release/db/derby/db-derby-${DERBY_VERSION}/db-derby-${DERBY_VERSION}-bin.tar.gz && \
    tar xzf /db-derby-${DERBY_VERSION}-bin.tar.gz && \
    mv /db-derby-${DERBY_VERSION}-bin /derby && \
    rm -Rf /*.tar.gz ${DERBY_HOME}/demo ${DERBY_HOME}/javadoc ${DERBY_HOME}/docs ${DERBY_HOME}/test ${DERBY_HOME}/*.html ${DERBY_HOME}/KEYS && \
    apk del openssl

WORKDIR /dbs
VOLUME ["/dbs"]
EXPOSE 1527

HEALTHCHECK CMD nc -z localhost 1527 || exit 1

CMD ["java", "-Dderby.stream.error.field=java.lang.System.out", "org.apache.derby.drda.NetworkServerControl", "start", "-h", "0.0.0.0"]
