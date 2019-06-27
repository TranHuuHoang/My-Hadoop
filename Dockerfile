FROM ubuntu:18.04 

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf \
    && apt update \
    && apt install -y openjdk-8-jdk ssh rsync vim

# Install hadoop, set environment
RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.3/hadoop-2.7.3.tar.gz 
RUN tar -xvf hadoop-2.7.3.tar.gz 

ENV HADOOP_HOME $HOME/hadoop-2.7.3
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

RUN echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# Set up SSH key
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# expose various ports
EXPOSE 8088 50070 50075 50030 50060

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml

COPY start-hadoop.sh .

# start hadoop
CMD bash start-hadoop.sh