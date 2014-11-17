# Isso
#
# VERSION 0.2.2

FROM debian:wheezy

RUN apt-get update \
    && apt-get install -y python python-dev python-pkg-resources python-pip \
                          build-essential sqlite3 \
    && rm -rf /var/lib/apt/lists/* \
    && pip install isso uwsgi \
    && apt-get remove -y build-essential python-pip \
    && apt-get autoremove -y \
    && useradd -M -s /usr/sbin/nologin uwsgi

ADD assets/isso/isso.cfg.template /app/isso.cfg.template
ADD assets/init /app/init

RUN chmod 755 /app/init \
    && mkdir -p /tmp/isso/mail

EXPOSE 8000

VOLUME ["/data"]

ENTRYPOINT ["/app/init"]
