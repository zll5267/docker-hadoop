FROM openjdk:8

MAINTAINER zll <zll5267@163.com>

ARG HADOOP_VERSION=2.10.1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      net-tools curl netcat \
      less vim
      
ENV HADOOP_VERSION ${HADOOP_VERSION}
ENV HADOOP_URL https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && mv /opt/hadoop-$HADOOP_VERSION /opt/hadoop \
    && rm /tmp/hadoop.tar.gz* \
    && ln -s /opt/hadoop/etc/hadoop /etc/hadoop \
    && mkdir /opt/hadoop/logs \
    && mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
