FROM openjdk:8-jre-alpine
MAINTAINER Sankalan Banerjee <banerjee.sankalan2@gmail.com>

# Install curl
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*
	
#  Version
ENV   SOAPUI_VERSION  5.2.1

# Download and unarchive SoapUI
RUN mkdir -p /opt &&\
    curl  http://smartbearsoftware.com/distrib/soapui/5.2.1/SoapUI-5.2.1-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/SoapUI-${SOAPUI_VERSION} /opt/SoapUI

# Set working directory
WORKDIR /opt/SoapUI/bin

# Set environment
ENV PATH ${PATH}:/opt/SoapUI/bin

ENTRYPOINT ["/bin/bash"]
