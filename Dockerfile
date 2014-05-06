FROM ubuntu:latest
MAINTAINER Takaaki Mizuno <takaaki.mizuno@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install wget

# set up java
RUN apt-get -y install wget python-software-properties software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# set up DynamoDB Local and ElastcMQ
RUN cd /tmp && wget https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-0.8.0.jar \
               wget wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest \
               mv dynamodb_local_latest dynamodb_local_latest.jar

RUN mkdir /tmp/log
RUN nohup java -jar /tmp/elasticmq-server-0.8.0.jar > /tmp/log/elasticmp.log 2>&1 &
EXPOSE 9324
