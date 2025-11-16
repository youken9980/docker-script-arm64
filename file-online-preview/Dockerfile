FROM youken9980/temurin:17-jre-noble
LABEL maintainer="YangJian <youken9980@163.com>"

ENV KKFILEVIEW_HOME="/kkFileView"
# 文件上传功能默认已禁用。如需开启，请通过以下方式配置：
# ENV KK_FILE_UPLOAD_DISABLE=false
# 请注意：文件上传限开发环境调试使用，生产环境建议保持关闭状态，避免非法上传导致的安全隐患。

RUN set -eux && \
    \
    apt-get update && \
    apt-get install -y --reinstall ca-certificates && \
    apt-get clean && apt-get update && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install --no-install-recommends -y \
            tzdata locales language-pack-zh-hans \
            fontconfig ttf-mscorefonts-installer ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy \
            libxrender1 libxinerama1 libxt6 libxext-dev libfreetype6-dev libcairo2 libcups2 libx11-xcb1 libnss3 \
            procps aptitude axel libreoffice && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8 && \
    locale-gen zh_CN.UTF-8 && \
    mkfontscale && \
    mkfontdir && \
    fc-cache -fv && \
    \
    rm -rf /var/lib/apt/lists/* \
           /var/cache/* \
           /tmp/*

COPY --chown=root:root app/${KKFILEVIEW_HOME} ${KKFILEVIEW_HOME}

EXPOSE 8012

WORKDIR ${KKFILEVIEW_HOME}/bin

# nohup java -Duser.timezone=GMT+8 -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Dspring.config.location=../config/application.properties -jar kkFileView-4.3.0.jar > ../log/kkFileView.log 2>&1 &
CMD ["java", "-Duser.timezone=GMT+8", "-Dfile.encoding=UTF-8", "-Dsun.jnu.encoding=UTF-8", "-Dspring.config.location=../config/application.properties", "-jar", "kkFileView.jar"]


# ENV KK_OFFICE_HOME="/opt/openoffice4"

# RUN set -eux && \
#     OPENOFFICE_VERSION="4.1.14" && \
#     OPENOFFICE_DOWNLOAD_URL="https://jaist.dl.sourceforge.net/project/openofficeorg.mirror/${OPENOFFICE_VERSION}/binaries/en-US/Apache_OpenOffice_${OPENOFFICE_VERSION}_Linux_x86-64_install-deb_en-US.tar.gz" && \
#     \
#     apt-get update && \
#     DEBIAN_FRONTEND="noninteractive" && \
#     apt-get install --no-install-recommends -y \
#         procps aptitude \
#         ttf-mscorefonts-installer ttf-wqy-microhei ttf-wqy-zenhei xfonts-intl-chinese xfonts-wqy \
#         libxrender1 libxt6 libxext-dev libfreetype6-dev && \
#     mkfontscale && \
#     mkfontdir && \
#     \
#     axel -n 32 -o /tmp/openoffice.tar.gz ${OPENOFFICE_DOWNLOAD_URL} && \
#     tar -zxvf /tmp/openoffice.tar.gz -C /tmp --strip-components=1 --no-same-owner && \
#     dpkg -i /tmp/DEBS/*.deb /tmp/DEBS/desktop-integration/*.deb && \
#     \
#     rm -rf /var/lib/apt/lists/* \
#            /var/cache/* \
#            /tmp/* \
#            /opt/openoffice4/help

# COPY --chown=root:root --from=temp ${KKFILEVIEW_HOME} ${KKFILEVIEW_HOME}

# EXPOSE 8012

# WORKDIR ${KKFILEVIEW_HOME}/bin

# # java -Duser.timezone=GMT+8 -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Dspring.config.location=../config/application.properties -jar kkFileView-4.3.0.jar
# CMD ["java", "-Duser.timezone=GMT+8", "-Dfile.encoding=UTF-8", "-Dsun.jnu.encoding=UTF-8", "-Dspring.config.location=../config/application.properties", "-jar", "kkFileView.jar"]
