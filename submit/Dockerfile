ARG HADOOP_VERSION=2.10.1
FROM zll5367/hadoop-base:${HADOOP_VERSION}

MAINTAINER zll <zll5267@163.com>

COPY WordCount.jar /opt/hadoop/applications/WordCount.jar

ENV JAR_FILEPATH="/opt/hadoop/applications/WordCount.jar"
ENV CLASS_TO_RUN="WordCount"
ENV PARAMS="/input /output"

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
