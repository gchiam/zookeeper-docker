FROM gchiam/openjdk:8

MAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>

RUN wget -q -O - http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz| tar -xzf - -C /opt
RUN mv /opt/zookeeper-3.4.7/conf/zoo_sample.cfg /opt/zookeeper-3.4.7/conf/zoo.cfg

ENV ZK_HOME /opt/zookeeper-3.4.7
RUN sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg; mkdir $ZK_HOME/data

ADD start-zk.sh /usr/bin/start-zk.sh
EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper-3.4.7
VOLUME ["/opt/zookeeper-3.4.7/conf", "/opt/zookeeper-3.4.7/data"]

CMD /usr/sbin/sshd && start-zk.sh
