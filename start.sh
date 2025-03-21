#!/bin/bash
export HIVE_HOME=/opt/hive
export PATH=$PATH:$HIVE_HOME/bin

export HADOOP_HOME=/opt/spark
# Inicia o SSH Server
service ssh start

# Inicia o code-server
code-server --auth none --bind-addr 0.0.0.0:8080 /home/vscode &

schematool -initSchema -dbType derby

$SPARK_MASTER_EXEC &
$SPARK_WORKER_EXEC &

hive --service metastore & 
# Mantém o contêiner em execução
tail -f /dev/null
