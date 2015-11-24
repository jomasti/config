export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk7/Contents/Home
export M3_HOME=/usr/local/Cellar/maven32/3.2.5
export PATH=$M2_HOME/bin:$PATH
export MAVEN_OPTS="-Xms2048m -Xmx2048m -XX:MaxPermSize=2048m"
export JAVA_OPTS="-Xmx2048m -Xms2048m -XX:MaxPermSize=2048m -XX:MaxGCPauseMillis=1500 -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC -Denvironment=lab -Dsite=maint-site1"

