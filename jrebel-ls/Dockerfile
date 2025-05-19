FROM youken9980/temurin:8-jre-noble
LABEL maintainer="YangJian <youken9980@163.com>"

COPY --chown=root:root app/service.jar /service.jar

ARG SERVER_PORT="8080"
ENV SERVER_PORT=${SERVER_PORT}
EXPOSE ${SERVER_PORT}

STOPSIGNAL SIGTERM

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-Dfile.encoding=UTF-8", "-Dsun.jnu.encoding=UTF-8", "-jar", "/service.jar", "-p", "${SERVER_PORT}"]
