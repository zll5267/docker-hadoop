DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)

build_base:
	docker build -t zll5267/hadoop-base:$(current_branch) ./base
build_namenode:
	docker build -t zll5267/hadoop-namenode:$(current_branch) ./namenode
build_datanode:
	docker build -t zll5267/hadoop-datanode:$(current_branch) ./datanode
build_resourcemanager:
	docker build -t zll5267/hadoop-resourcemanager:$(current_branch) ./resourcemanager
build_nodemanager:
	docker build -t zll5267/hadoop-nodemanager:$(current_branch) ./nodemanager
build_historyserver:
	docker build -t zll5267/hadoop-historyserver:$(current_branch) ./historyserver
build:
	docker build -t zll5267/hadoop-base:$(current_branch) ./base
	docker build -t zll5267/hadoop-namenode:$(current_branch) ./namenode
	docker build -t zll5267/hadoop-datanode:$(current_branch) ./datanode
	docker build -t zll5267/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t zll5267/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t zll5267/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t zll5267/hadoop-submit:$(current_branch) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.3.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} zll5267/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
