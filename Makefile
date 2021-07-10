DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
hadoop_version := 2.10.1
#hadoop_version := $(shell echo ${current_branch} | cut -d- -f1)
docker_build_common_args := " --build-arg HADOOP_VERSION=${hadoop_version} "
build_args := ${docker_build_common_args}

echo_env:
	echo "current_branch:${current_branch}"
	echo "hadoop_version:${hadoop_version}"

build_base:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-base:$(hadoop_version) ./base
build_namenode:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-namenode:$(hadoop_version) ./namenode
build_datanode:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-datanode:$(hadoop_version) ./datanode
build_resourcemanager:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-resourcemanager:$(hadoop_version) ./resourcemanager
build_nodemanager:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-nodemanager:$(hadoop_version) ./nodemanager
build_historyserver:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-historyserver:$(hadoop_version) ./historyserver
build:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-namenode:$(hadoop_version) ./namenode
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-datanode:$(hadoop_version) ./datanode
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-resourcemanager:$(hadoop_version) ./resourcemanager
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-nodemanager:$(hadoop_version) ./nodemanager
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-historyserver:$(hadoop_version) ./historyserver
build_submit:
	docker build --build-arg HADOOP_VERSION=${hadoop_version} -t zll5267/hadoop-submit:$(hadoop_version) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(hadoop_version) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(hadoop_version) hdfs dfs -copyFromLocal -f /opt/hadoop-${hadoop_version}/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(hadoop_version) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(hadoop_version) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(hadoop_version) hdfs dfs -rm -r /input
