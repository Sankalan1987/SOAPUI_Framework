FROM jenkinsci/jnlp-slave
FROM centos:7
FROM java:openjdk-7-jdk
MAINTAINER Sankalan Banerjee <banerjee.sankalan2@gmail.com>

#  Version
ENV   SOAPUI_VERSION  5.2.1

# Download and unarchive SoapUI
RUN mkdir -p /opt &&\
    curl  http://smartbearsoftware.com/distrib/soapui/5.2.1/SoapUI-5.2.1-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /var/SoapUI-${SOAPUI_VERSION} /var/SoapUI

# Set working directory
WORKDIR /var/SoapUI/bin

# Set environment
ENV PATH ${PATH}:/var/SoapUI/bin
