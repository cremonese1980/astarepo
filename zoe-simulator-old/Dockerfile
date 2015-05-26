FROM dockerfile/java:oracle-java8
MAINTAINER Lottonetwork <developers@lottonetworkservices.com>
EXPOSE 8080
ADD target/zoe-simulator-0.0.1-SNAPSHOT.jar /data/
ENTRYPOINT "java" "-jar" "zoe-simulator-0.0.1-SNAPSHOT.jar"
