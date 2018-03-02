FROM jenkinsci/jnlp-slave
FROM centos:7
FROM java:openjdk-7-jdk
MAINTAINER Sankalan <banerjee.sankalan2@gmail.com>
CMD ["sh", "-c", "tail -f /dev/null"]
