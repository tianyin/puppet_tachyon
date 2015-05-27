#Compile Tachyon with specific Hadoop version

1. Change the hadoop.version tag in pom.xml in Tachyon's root directory

2. You probably want to set the following options for ```Maven``` build
```
export MAVEN_OPTS='-Xmx1024m -XX:MaxPermSize=1024m'
```

3. Build Tachyon
```
mvn -Dhadoop.version=2.2.0 clean package
```
