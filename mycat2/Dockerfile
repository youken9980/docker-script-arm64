FROM youken9980/temurin:8-jre-noble
LABEL maintainer="YangJian <youken9980@163.com>"

ENV MYCAT_HOME=/mycat

EXPOSE 1984 8066

COPY --chown=root:root app/$MYCAT_HOME $MYCAT_HOME
COPY entrypoint.sh /usr/local/bin/

RUN mkdir -p $MYCAT_HOME/logs && \
    chmod -R 644 $MYCAT_HOME && \
    find $MYCAT_HOME -type d -exec chmod 755 {} \;

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
