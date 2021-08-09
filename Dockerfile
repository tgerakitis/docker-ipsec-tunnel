#
# Dockerfile for ipsec
#

FROM ubuntu


RUN apt update && apt-get install -yf wget iputils-ping telnet strongswan iptables \
    && ln -sf /conf/ipsec.conf /etc/ipsec.conf \
    && ln -sf /conf/ipsec.secrets /etc/ipsec.secrets \
    && echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf \
    && wget -O /traefik.tar.gz https://github.com/traefik/traefik/releases/download/v2.4.12/traefik_v2.4.12_linux_amd64.tar.gz \
    && tar -zxvf /traefik.tar.gz \
    && ln -s /traefik /usr/bin/traefik


COPY docker-entrypoint.sh /entrypoint.sh
COPY /strongswan /conf
COPY /traefik-conf /traefik-conf

CMD ["/entrypoint.sh"]
