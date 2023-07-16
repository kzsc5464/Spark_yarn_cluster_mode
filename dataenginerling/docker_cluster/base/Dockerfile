# 기반이 되는 이미지를 설정. 여기서는 ubuntu 18 기반인 zulu의 openjdk 8버전을 선택
FROM azul/zulu-openjdk:11

# 바이너리를 내려받기 위해 설치
RUN apt-get update && apt-get install -y curl
RUN apt-get install -y python3 &&\
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y python3-pip

ENV HADOOP_VERSION=3.3.6
# ENV HADOOP_URL=http://mirror.apache-kr.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV HADOOP_URL=https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ENV SPARK_URL=https://archive.apache.org/dist/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz 

# Spark 3.3.2
RUN curl -fSL "$SPARK_URL" -o /tmp/spark.tgz 
RUN tar -xzf /tmp/spark.tgz -C /opt/
RUN rm /tmp/spark.tgz 

 

# # Hadoop 2.9.2 버전을 내려받고 /opt/hadoop에 압축 해제
RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz

RUN ln -s /opt/spark-3.3.2-bin-hadoop3 /opt/spark

# # 데이터 디렉토리 생성 및 설정 폴더의 심볼릭 링크 생성
RUN ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop \
    && mkdir /opt/hadoop/dfs \
    && ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop \
    && rm -rf /opt/hadoop/share/doc

# # 로컬의 core-site.xml 파일을 복제
ADD core-site.xml /etc/hadoop/

# # 실행 환경에 필요한 환경 변수 등록
ENV HADOOP_PREFIX /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $HADOOP_PREFIX/bin/:$PATH
ENV JAVA_HOME /usr/lib/jvm/zulu11-ca-amd64

ENV SPARK_HOME /opt/spark/
ENV PATH ${SPARK_HOME}/bin:$PATH
ENV PYSPARK_PYTHON /usr/bin/python3
ENV SPARK_MASTER_HOST namenode
ENV SPARK_MASTER_PORT 7077