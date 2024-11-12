#!/bin/sh

set -eux
/usr/local/ngrok/bin/ngrokd -tlsKey="/usr/local/ngrok/assets/server/tls/snakeoil.key" -tlsCrt="/usr/local/ngrok/assets/server/tls/snakeoil.crt" -domain="${NGROK_DOMAIN}" -httpAddr=":80" -httpsAddr=":443" -tunnelAddr=":4443" -log="stdout" -log-level="INFO"
