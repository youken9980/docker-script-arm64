FROM youken9980/temurin:8-jre-noble
LABEL maintainer="YangJian <youken9980@163.com>"

ENV MYCAT_HOME=/mycat
ENV PATH=".:$PATH:$MYCAT_HOME/bin"

EXPOSE 1984 8066 9066

COPY --chown=root:root app/$MYCAT_HOME $MYCAT_HOME
COPY entrypoint.sh /usr/local/bin/

RUN mkdir -p $MYCAT_HOME/logs && \
    touch $MYCAT_HOME/logs/mycat.log && \
    chmod -R 644 $MYCAT_HOME && \
    find $MYCAT_HOME -type d -exec chmod 755 {} \; && \
    chmod -R 755 $MYCAT_HOME/bin/* && \
    sed -i 's|        <asyncRoot level="info" includeLocation="true">|        <asyncRoot level="debug" includeLocation="true">|g' $MYCAT_HOME/conf/log4j2.xml

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
