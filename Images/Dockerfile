FROM ubuntu:18.04 

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf \
    && apt update \
    && apt install --no-install-recommends -y \
        build-essential software-properties-common \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt install -y openjdk-7-jdk ssh rsync vim

# Install hadoop, set environment
RUN wget http://apache.mirrors.tds.net/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz \
    && tar -xzf hadoop-2.8.1.tar.gz \
    && mv hadoop-2.8.1 $HADOOP_HOME \
    && echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

# Set up SSH key
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# expose various ports
EXPOSE 8088 50070 50075 50030 50060

# start hadoop
CMD bash start-hadoop.sh