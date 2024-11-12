FROM youken9980/alpine:3 AS source-han-serif
ARG GITHUB_MIRROR="https://github.com"
# Source Han Serif | 思源宋体 | 思源宋體 | 思源宋體 香港 | 源ノ明朝 | 본명조
RUN wget -O /SourceHanSerif.ttc ${GITHUB_MIRROR}/adobe-fonts/source-han-serif/releases/download/1.001R/SourceHanSerif.ttc

# FROM youken9980/alpine:3 AS source-han-sans
# ARG GITHUB_MIRROR="https://github.com"
# Source Han Sans | 思源黑体 | 思源黑體 | 思源黑體 香港 | 源ノ角ゴシック | 본고딕
# RUN axel -n 8 -o /SourceHanSans.ttc ${GITHUB_MIRROR}/adobe-fonts/source-han-sans/releases/download/2.003R/SourceHanSans.ttc

# FROM youken9980/alpine:3 AS source-han-mono
# ARG GITHUB_MIRROR="https://github.com"
# Source Han Mono | 思源等宽 | 思源等寬 | 思源等寬 香港 | 源ノ等幅 | 본모노
# RUN axel -n 8 -o /SourceHanMono.ttc ${GITHUB_MIRROR}/adobe-fonts/source-han-mono/releases/download/1.002/SourceHanMono.ttc

FROM youken9980/alpine:3 AS novnc
ARG GITHUB_MIRROR="https://github.com"
RUN NOVNC_HOME="/noVNC" && \
    axel -n 8 -o novnc.tar.gz ${GITHUB_MIRROR}/novnc/noVNC/archive/v1.4.0.tar.gz && \
    axel -n 8 -o websockify.tar.gz ${GITHUB_MIRROR}/novnc/websockify/archive/v0.11.0.tar.gz && \
    mkdir -p ${NOVNC_HOME}/utils/websockify && \
    tar -zxvf novnc.tar.gz -C ${NOVNC_HOME} --strip-components=1 --no-same-owner && \
    tar -zxvf websockify.tar.gz -C ${NOVNC_HOME}/utils/websockify --strip-components=1 --no-same-owner && \
    cd ${NOVNC_HOME} && \
    ln -snf vnc.html index.html


FROM youken9980/alpine:3
LABEL maintainer="YangJian <youken9980@163.com>"

ENV USER=root
ENV DISPLAY=:1
ENV HOME=/home/${USER}
ENV TERM=xterm
ENV VNC_PASSWD=alpinelinux
ENV VNC_PORT=5900
ENV VNC_RESOLUTION=1280x800
ENV VNC_COL_DEPTH=24
ENV NOVNC_PORT=6080
ENV NOVNC_HOME=${HOME}/noVNC

RUN set -eux && \
    \
    apk --update --no-cache add \
        xfce4 xfce4-terminal x11vnc xvfb \
        bash procps python3 font-adobe-100dpi \
        firefox && \
    fc-cache -f && \
    \
    rm -rf /var/cache/apk/*.*

EXPOSE $VNC_PORT $NOVNC_PORT

COPY --chown=root:root --from=source-han-serif /SourceHanSerif.ttc /usr/share/fonts/SourceHanSerif.ttc
COPY --chown=root:root --from=novnc /noVNC ${NOVNC_HOME}

COPY config /etc/skel/.config
COPY entrypoint.sh /entrypoint.sh

# RUN apk --update --no-cache add chromium && \
#     mv /usr/lib/chromium/locales/en-US*.* /. && \
#     rm -rf /usr/lib/chromium/locales && \
#     mkdir -p /usr/lib/chromium/locales && \
#     mv /en-US*.* /usr/lib/chromium/locales/. && \
#     echo "CHROMIUM_FLAGS=\"--no-sandbox --no-first-run --disable-gpu\"" >> /etc/chromium/chromium.conf

CMD ["/entrypoint.sh"]
