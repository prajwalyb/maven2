FROM openjdk:11
EXPOSE 8080
ADD target/MyMavenApp-0.0.1-SNAPSHOT.jar MyMavenApp-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/MyMavenApp-0.0.1-SNAPSHOT.jar"]
