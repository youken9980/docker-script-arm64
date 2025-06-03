FROM youken9980/temurin:21-jre-noble
LABEL maintainer="YangJian <youken9980@163.com>"

# https://api.papermc.io/v2/projects/paper/versions/1.21.5/builds/103/downloads/paper-1.21.5-103.jar
RUN set -eux && \
    PAPERMC_VERSION="1.21.5" && \
    PAPERMC_BUILD="103" && \
    \
    mkdir -p /papermc && cd /papermc && \
    wget -O papermc.jar https://api.papermc.io/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${PAPERMC_BUILD}/downloads/paper-${PAPERMC_VERSION}-${PAPERMC_BUILD}.jar && \
    java -jar papermc.jar && \
    sed -i 's|eula=false|eula=true|g' eula.txt && \
    sed -i 's|online-mode=true|online-mode=false|g' server.properties && \
    \
    rm -rf /var/lib/apt/lists/* \
           /var/cache/* \
           /tmp/*

# server.properties
# gamemode=survival  //游戏模式 0=生存 1=创造 2=冒险 3=旁观
# difficulty=easy  //难度0=和平 1=简单 2=普通 3=困难
# max-players=20  //服务器最大玩家数限制
# server-port=25565  //服务器端口
# online-mode=true  //在线（正版）验证[默认启用]
# pvp=true

EXPOSE 25565

WORKDIR /papermc
CMD ["java", "-Xms2G", "-Xmx2G", "-jar", "/papermc/papermc.jar", "--nogui"]
