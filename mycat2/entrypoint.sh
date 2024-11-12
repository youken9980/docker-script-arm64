#!/bin/bash

java -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -DMYCAT_HOME=${MYCAT_HOME} -jar ${MYCAT_HOME}/mycat2.jar
