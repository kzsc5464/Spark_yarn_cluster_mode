#!/bin/sh
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}

$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR datanode