ARG HADOOP_VERSION=2.10.1
FROM zll5267/hadoop-base:${HADOOP_VERSION}

ARG HADOOP_VERSION

MAINTAINER zll <zll5267@163.com>

HEALTHCHECK CMD curl -f http://localhost:50075/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50075

CMD ["/run.sh"]
