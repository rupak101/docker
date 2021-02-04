FROM openjdk:8-jre-slim
# Docker image base dir
ARG BASE_DIR=/usr/share/tag

ENV SELENIUM_HUB 127.0.0.1
# Add the jar with all the dependencies
# Maven creates container-test.jar in the target folder of my workspace.
# We need this in some location - say - /usr/share/tag folder of the container
ADD  target/container-test.jar $BASE_DIR/container-test.jar
ADD  target/libs $BASE_DIR/libs

# Add the suite xmls
ADD basic-flow-module.xml $BASE_DIR/basic-flow-module.xml

# Command line to execute the test
ENTRYPOINT ["sh", "-c", "/usr/bin/java -cp /usr/share/tag/container-test.jar -DseleniumHubHost=$SELENIUM_HUB org.testng.TestNG -d /usr/share/tag/test-output /usr/share/tag/basic-flow-module.xml"]
#ENTRYPOINT /usr/bin/java -cp $BASE_DIR/container-test.jar -DseleniumHubHost=$SELENIUM_HUB org.testng.TestNG -d $BASE_DIR/test-output $BASE_DIR/basic-flow-module.xml
