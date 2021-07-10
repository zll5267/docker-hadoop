ARG HADOOP_VERSION=2.10.1
FROM zll5267/hadoop-base:${HADOOP_VERSION}

MAINTAINER zll <zll5267@163.com>

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]
