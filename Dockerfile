FROM  dragonwell-registry.cn-hangzhou.cr.aliyuncs.com/dragonwell/dragonwell:8 AS base

LABEL MAINTAINER="ccccccc"

ARG DAVINCI_ZIP=davinci-assembly_0.3.1-0.3.1-SNAPSHOT-dist-rc.zip

RUN yum install -y wget zip unzip &&cd / \
	&& mkdir -p /opt/davinci \
	&& wget https://github.com/edp963/davinci/releases/download/v0.3.0-rc/$DAVINCI_ZIP \
	&& unzip $DAVINCI_ZIP -d /opt/davinci\
	&& rm -rf $DAVINCI_ZIP \
	&& cp -v /opt/davinci/config/application.yml.example /opt/davinci/config/application.yml

ADD bin/docker-entrypoint.sh /opt/davinci/bin/docker-entrypoint.sh

RUN chmod +x /opt/davinci/bin/docker-entrypoint.sh

ENV DAVINCI3_HOME /opt/davinci
ENV OPENSSL_CONF=/etc/ssl/

WORKDIR /opt/davinci

CMD ["./bin/start-server.sh"]

EXPOSE 8080
