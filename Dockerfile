FROM openjdk:11
EXPOSE 8080
ADD target/javaparser-maven-sample-1.0-SNAPSHOT.jar javaparser-maven-sample-1.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/javaparser-maven-sample-1.0-SNAPSHOT.jar"]
