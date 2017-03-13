#!/bin/sh

TOMCAT_SERVER_URL=$1
echo "Tomcat Serrver Url is : $TOMCAT_SERVER_URL"

VERSION_NO=$2
echo "Version to be downloaded is : $VERSION_NO"

cd /tmp

echo "Downloading autoclaim war version $VERSION_NO"
wget "http://ec2-35-166-232-252.us-west-2.compute.amazonaws.com:8081/nexus/content/repositories/releases/com/example/autoclaim/$VERSION_NO/autoclaim-$VERSION_NO.war"

if [ -f autoclaim-$VERSION_NO.war ]; then
        echo "Downloaded autoclaim war version $VERSION_NO"

        cp autoclaim-$VERSION_NO.war autoclaim.war
        echo "Copied autoclaim-$VERSION_NO.war to autoclaim.war"

        echo "Deploying autoclaim.war to Tomcat Server $TOMCAT_SERVER_URL"
        curl -v --basic --user admin:devops --upload-file autoclaim.war "http://manager-script:changeit@$TOMCAT_SERVER_URL/manager/text/deploy?path=/autoclaim&update=true"
        echo "Deployment Successful"
        rm -f autoclaim*.war
        echo "Downloaded binaries deleted from tmp folder"
else
        echo "Deployment Failed"
fi
