FROM ubuntu:18.04 

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf \
    && apt update \
    && apt install -y openjdk-8-jdk ssh rsync vim

# Install hadoop, set environment
RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.3/hadoop-2.7.3.tar.gz 
RUN tar -xvf hadoop-2.7.3.tar.gz 
ENV HADOOP_HOME $HOME/hadoop-2.7.3
RUN echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

# Set up SSH key
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# expose various ports
EXPOSE 8088 50070 50075 50030 50060

COPY start-hadoop.sh .

# start hadoop
CMD bash start-hadoop.sh