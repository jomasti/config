export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk8/Contents/Home
export JRE_HOME=$JAVA_HOME/jre
export M3_HOME=/usr/local/Cellar/maven32/3.2.5
export PATH=$M2_HOME/bin:$PATH
export MAVEN_OPTS="-Xms8g -Xmx8g -XX:MaxPermSize=512m"
export JAVA_OPTS="-Xmx8g -Xms8g -XX:MaxGCPauseMillis=1500 -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC -Denvironment=lab -Dsite=dev-mainline"
export TOMCAT_HOME="/usr/local/jakarta-tomcat"
export ECLIPSE_HOME="/opt/homebrew-cask/Caskroom/eclipse-ide/4.5.1/Eclipse.app/Contents/Eclipse"

alias tomdown="$TOMCAT_HOME/bin/shutdown.sh"
alias tomup="$TOMCAT_HOME/bin/startup.sh"
alias tomset="$EDITOR $TOMCAT_HOME/bin/setenv.sh"
alias mount_analytics="sshfs vagrant_analytics:/home/analytics ~/analytics_project/vagrant_analytics -oauto_cache,reconnect,defer_permissions,noappledouble"
alias analytics="mount_analytics || umount ~/vagrant_analytics && mount_analytics"
alias eclimd="/opt/homebrew-cask/Caskroom/eclipse-ide/4.5.1/Eclipse.app/Contents/Eclipse/eclimd"

source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
